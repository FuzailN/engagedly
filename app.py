from flask import Flask
import psycopg2

app = Flask(__name__)

def get_db_connection():
    conn = psycopg2.connect(
        host="10.1.0.5",          #db_ip
        database="database",
        user="fuzail",
        password="fuzail"
    )
    return conn

@app.route('/')
def hello():
    conn = get_db_connection()
    cur = conn.cursor()
    cur.execute('SELECT 1')
    result = cur.fetchone()
    cur.close()
    conn.close()
    return f'PostgreSQL query result: {result}'

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=80)
