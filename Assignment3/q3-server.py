
import socket

HOST = "0.0.0.0"
PORT = 5001
FILE = "uptime_data.tsv"

def get_latest_uptime():
    try:
        with open(FILE, "r") as f:
            lines = f.readlines()

        if len(lines) < 2:
            return "No uptime data available."

        return lines[1].strip()

    except FileNotFoundError:
        return "Uptime file not found."

with socket.socket(socket.AF_INET, socket.SOCK_DGRAM) as server:
    server.bind((HOST, PORT))
    print(f"UDP server listening on port {PORT}")

    while True:
        data, addr = server.recvfrom(1024)
        print("Request received from:", addr)

        response = get_latest_uptime()
        server.sendto(response.encode("utf-8"), addr)
