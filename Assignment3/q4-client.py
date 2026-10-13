
from ftplib import FTP

HOST = "127.0.0.1"
PORT = 2121
USERNAME = "student"
PASSWORD = "student123"

with FTP() as ftp:
    ftp.connect(HOST, PORT, timeout=10)
    ftp.login(USERNAME, PASSWORD)

    print("Connected to FTP server.")

    with open("downloaded_uptime.tsv", "wb") as file:
        ftp.retrbinary(
            "RETR uptime_data.tsv",
            file.write
        )

    print("File downloaded successfully.")

with open("downloaded_uptime.tsv", "r") as file:
    lines = file.readlines()

if len(lines) >= 2:
    print("Latest uptime information:")
    print(lines[1].strip())
else:
    print("No uptime data available.")
