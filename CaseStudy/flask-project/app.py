import os
import time
import psycopg2
from flask import Flask

app = Flask(__name__)

def get_connection():
    return psycopg2.connect(
        host=os.environ.get("DB_HOST", "db"),
        dbname=os.environ.get("DB_NAME", "flaskdb"),
        user=os.environ.get("DB_USER", "flaskuser"),
        password=os.environ.get("DB_PASSWORD", "flaskpass"),
    )

def init_db():
    # Retry a few times in case PostgreSQL is still starting
    for _ in range(10):
        try:
            conn = get_connection()
            cur = conn.cursor()
            cur.execute("CREATE TABLE IF NOT EXISTS visits (id SERIAL PRIMARY KEY, visited_at TIMESTAMP DEFAULT NOW());")
            conn.commit()
            cur.close()
            conn.close()
            return
        except psycopg2.OperationalError:
            time.sleep(2)
    raise RuntimeError("Could not connect to the database")

@app.route("/")
def index():
    conn = get_connection()
    cur = conn.cursor()
    cur.execute("INSERT INTO visits DEFAULT VALUES;")
    cur.execute("SELECT COUNT(*) FROM visits;")
    count = cur.fetchone()[0]
    conn.commit()
    cur.close()
    conn.close()
    return f"Flask is connected to PostgreSQL. Total visits: {count}\n"

if __name__ == "__main__":
    init_db()
    app.run(host="0.0.0.0", port=5000)