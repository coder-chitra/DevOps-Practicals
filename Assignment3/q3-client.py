
import socket

HOST = "0.0.0.0"
PORT = 5001

with socket.socket(socket.AF_INET, socket.SOCK_DGRAM) as client:
    client.settimeout(5)

    client.sendto(b"GET_UPTIME", (HOST, PORT))

    try:
        data, addr = client.recvfrom(4096)
        print("Latest uptime information:")
        print(data.decode("utf-8"))
    except socket.timeout:
        print("No response from server.")
