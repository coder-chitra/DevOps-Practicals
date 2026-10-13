
import socket

HOST = "0.0.0.0"
PORT = 5000
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

with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as server:
    server.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
    server.bind((HOST, PORT))
    server.listen()

    print(f"TCP server listening on port {PORT}")

    while True:
        conn, addr = server.accept()

        with conn:
            print("Connected by:", addr)
            message = get_latest_uptime()
            conn.sendall(message.encode("utf-8"))
