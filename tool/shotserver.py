"""Host-side screenshot server for the App Store capture run.

The integration test runs inside the iOS Simulator and cannot shell out. It hits
this server at each clean frame; the server takes the native-resolution capture
with `xcrun simctl io booted screenshot` and only then answers, so the test stays
in lockstep with the captures.
"""
import http.server
import os
import subprocess
import urllib.parse

# Overridable so CI can write into the workspace, where upload-artifact can see
# it. A GitHub runner's ~/Desktop is not a useful place to leave build output.
OUT = os.path.expanduser(os.environ.get("ASC_SHOTS_DIR", "~/Desktop/asc-screenshots"))
os.makedirs(OUT, exist_ok=True)


class Handler(http.server.BaseHTTPRequestHandler):
    def do_GET(self):
        query = urllib.parse.parse_qs(urllib.parse.urlparse(self.path).query)
        name = query.get("name", ["shot"])[0]
        dest = os.path.join(OUT, name + ".png")
        result = subprocess.run(
            ["xcrun", "simctl", "io", "booted", "screenshot", dest],
            capture_output=True,
        )
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
    print("shotserver listening on 127.0.0.1:8099 -> %s" % OUT, flush=True)
    http.server.HTTPServer(("127.0.0.1", 8099), Handler).serve_forever()
