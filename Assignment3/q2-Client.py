
import socket

HOST = "0.0.0.0"
PORT = 5000

with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as client:
    client.connect((HOST, PORT))
    data = client.recv(4096)

    print("Latest uptime information:")
    print(data.decode("utf-8"))
