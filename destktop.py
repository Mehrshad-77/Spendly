import threading
import time
import urllib.request
import urllib.error
import uvicorn
import webview
from api import app

class ServerThread(threading.Thread):
    def __init__(self, host="127.0.0.1", port=8000):
        super().__init__(daemon=True)
        config = uvicorn.Config(app, host=host, port=port, log_level="warning")
        self.server = uvicorn.Server(config)
        self.host = host
        self.port = port

    def run(self):
        self.server.run()

    def stop(self):
        self.server.should_exit = True
        self.join(timeout=5)


def wait_until_ready(host, port, timeout=5.0):
    """Poll the server until it responds or timeout seconds have passed.
    Returns True once it's up, False if it never came up in time."""
    url = f"http://{host}:{port}/categories"
    deadline = time.monotonic() + timeout
    while time.monotonic() < deadline:
        try:
            with urllib.request.urlopen(url, timeout=0.5) as resp:
                if resp.status == 200:
                    return True
        except (urllib.error.URLError, ConnectionError, OSError):
            pass
        time.sleep(0.05)
    return False


def run_in_window(server):
    """Open a native window onto the running server."""
    window = webview.create_window(
        "Expense Tracker",
        f"http://{server.host}:{server.port}",
        width=1100,
        height=750,
        min_size=(700, 500),
    )
    # Fires after the window is actually gone; runs in its own thread (it
    # doesn't block the window from closing), so we just ask the server to
    # stop and let ServerThread.stop()'s own join() wait for it.
    window.events.closed += server.stop
    webview.start()


def run_in_terminal(server):
    """Fallback for environments with no GTK/Qt available (e.g. this
    sandbox, or a headless dev machine) - keeps the server running until
    Ctrl+C, same as running the API directly."""
    print(f"No GUI backend available - running headless at http://{server.host}:{server.port}")
    print("Press Ctrl+C to stop.")
    try:
        while True:
            time.sleep(1)
    except KeyboardInterrupt:
        print("Shutting down server...")


def main():
    server = ServerThread()
    server.start()

    if not wait_until_ready(server.host, server.port, timeout=10.0):
        # The server never came up - no point opening a window onto nothing.
        print("Error: the server did not start in time.")
        server.stop()
        return

    try:
        run_in_window(server)
    except webview.WebViewException:
        run_in_terminal(server)
    finally:
        # Whichever path we took, make sure the server actually stops -
        # stop() is safe to call twice (should_exit=True either way).
        server.stop()


if __name__ == "__main__":
    main()