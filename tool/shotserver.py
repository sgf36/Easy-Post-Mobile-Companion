"""Host-side screenshot server for the store capture runs.

The integration test runs inside the simulator or emulator and cannot shell out.
It hits this server at each clean frame; the server takes the native-resolution
capture and only then answers, so the test stays in lockstep with the captures.

Two platforms, one test. `SHOTS_PLATFORM=ios` (the default) captures with
`xcrun simctl`; `SHOTS_PLATFORM=android` captures with `adb exec-out screencap`.
The test itself is identical either way — it knows nothing about how the picture
is taken, which is why the same shot list serves the App Store and Play.
"""
import http.server
import os
import subprocess
import urllib.parse

PLATFORM = os.environ.get("SHOTS_PLATFORM", "ios").lower()
if PLATFORM not in ("ios", "android"):
    raise SystemExit(f"SHOTS_PLATFORM must be ios or android, not {PLATFORM!r}")

# Which emulator, when more than one is attached. adb picks arbitrarily
# otherwise, and capturing the wrong device is the sort of failure that looks
# like a rendering bug.
ANDROID_SERIAL = os.environ.get("ANDROID_SERIAL", "")


def _adb() -> str:
    """The adb binary, which is not necessarily on PATH.

    A GitHub runner has the SDK installed but leaves platform-tools off PATH, so
    a bare "adb" raises FileNotFoundError inside the request handler — once per
    request, as an unhandled traceback, while the caller sees only a dropped
    connection.
    """
    explicit = os.environ.get("ADB")
    if explicit:
        return explicit
    for root in (os.environ.get("ANDROID_HOME"), os.environ.get("ANDROID_SDK_ROOT")):
        if root:
            candidate = os.path.join(root, "platform-tools", "adb")
            for path in (candidate, candidate + ".exe"):
                if os.path.exists(path):
                    return path
    return "adb"


ADB = _adb()

# Overridable so CI can write into the workspace, where upload-artifact can see
# it. A GitHub runner's ~/Desktop is not a useful place to leave build output.
OUT = os.path.expanduser(os.environ.get("ASC_SHOTS_DIR", "~/Desktop/asc-screenshots"))
os.makedirs(OUT, exist_ok=True)


def capture(dest):
    """Take one native-resolution capture into `dest`."""
    if PLATFORM == "ios":
        return subprocess.run(
            ["xcrun", "simctl", "io", "booted", "screenshot", dest],
            capture_output=True,
        )

    # `adb exec-out` rather than `adb shell`: shell mangles the PNG by
    # translating LF to CRLF on some platforms, which produces a file that is
    # the right size and will not open. exec-out is a clean binary channel.
    serial = ["-s", ANDROID_SERIAL] if ANDROID_SERIAL else []
    result = subprocess.run(
        [ADB, *serial, "exec-out", "screencap", "-p"], capture_output=True
    )
    if result.returncode == 0 and result.stdout:
        with open(dest, "wb") as fh:
            fh.write(result.stdout)
    return result


class Handler(http.server.BaseHTTPRequestHandler):
    def do_GET(self):
        query = urllib.parse.parse_qs(urllib.parse.urlparse(self.path).query)
        name = query.get("name", ["shot"])[0]
        dest = os.path.join(OUT, name + ".png")
        # A missing tool used to escape as an unhandled traceback per request,
        # leaving the caller with a dropped connection and no reason. Answer
        # with the reason instead.
        try:
            result = capture(dest)
        except OSError as e:
            body = f"capture tool failed: {e}".encode()
            print("FAILED %s: %s" % (name, e), flush=True)
            self.send_response(500)
            self.send_header("Content-Type", "text/plain")
            self.send_header("Content-Length", str(len(body)))
            self.end_headers()
            self.wfile.write(body)
            return
        # A failed capture must answer with a failure.
        #
        # This used to reply "200 ok" whatever happened, and the caller catches
        # its own errors — so a run where simctl never captured anything at all
        # was green at both ends and only an empty output directory gave it
        # away. Report the truth and let the test decide.
        size = os.path.getsize(dest) if os.path.exists(dest) else 0
        ok = result.returncode == 0 and size > 0
        if ok:
            print("CAPTURED %s (%d bytes)" % (name, size), flush=True)
        else:
            detail = result.stderr.decode()[:200] or "no file written"
            print("FAILED %s: %s" % (name, detail), flush=True)

        body = b"ok" if ok else b"capture failed"
        self.send_response(200 if ok else 500)
        self.send_header("Content-Type", "text/plain")
        self.send_header("Content-Length", str(len(body)))
        self.end_headers()
        self.wfile.write(body)

    def log_message(self, *args):
        pass


if __name__ == "__main__":
    print("shotserver (%s, %s) listening on 127.0.0.1:8099 -> %s" % (PLATFORM, ADB if PLATFORM == "android" else "simctl", OUT), flush=True)
    http.server.HTTPServer(("127.0.0.1", 8099), Handler).serve_forever()
