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

OUT = os.path.expanduser("~/Desktop/asc-screenshots")
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
        if result.returncode == 0:
            size = os.path.getsize(dest) if os.path.exists(dest) else 0
            print("CAPTURED %s (%d bytes)" % (name, size), flush=True)
        else:
            print("FAILED %s: %s" % (name, result.stderr.decode()[:200]), flush=True)
        body = b"ok"
        self.send_response(200)
        self.send_header("Content-Type", "text/plain")
        self.send_header("Content-Length", str(len(body)))
        self.end_headers()
        self.wfile.write(body)

    def log_message(self, *args):
        pass


if __name__ == "__main__":
    print("shotserver listening on 127.0.0.1:8099 -> %s" % OUT, flush=True)
    http.server.HTTPServer(("127.0.0.1", 8099), Handler).serve_forever()
