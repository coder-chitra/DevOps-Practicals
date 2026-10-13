
from pyftpdlib.authorizers import DummyAuthorizer
from pyftpdlib.handlers import FTPHandler
from pyftpdlib.servers import FTPServer
import os

DIRECTORY = os.path.abspath(".")
HOST = "127.0.0.1"
PORT = 2121

authorizer = DummyAuthorizer()

authorizer.add_user(
    "student",
    "student123",
    DIRECTORY,
    perm="elr"
)

handler = FTPHandler
handler.authorizer = authorizer

server = FTPServer((HOST, PORT), handler)

print(f"FTP server running on {HOST}:{PORT}")
server.serve_forever()
