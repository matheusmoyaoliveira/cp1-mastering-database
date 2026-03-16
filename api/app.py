import os
from flask import Flask, render_template, redirect, url_for
import oracledb

BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
SQL_DIR = os.path.join(BASE_DIR, "sql")
TEMPLATES_DIR = os.path.join(BASE_DIR, "templates")

app = Flask(__name__, template_folder=TEMPLATES_DIR)

DB_USER = os.getenv("DB_USER")
DB_PASSWORD = os.getenv("DB_PASSWORD")
DB_DSN = os.getenv("DB_DSN")

if not DB_USER or not DB_PASSWORD or not DB_DSN:
    raise ValueError("Defina DB_USER, DB_PASSWORD e DB_DSN nas variáveis de ambiente.")

def get_connection():
    return oracledb.connect(
        user=DB_USER,
        password=DB_PASSWORD,
        dsn=DB_DSN
    )


def listar_herois():
    conn = get_connection()
    cursor = conn.cursor()

    cursor.execute("""
        SELECT id_heroi, nome, classe, hp_atual, hp_max, status
        FROM TB_HEROIS
        ORDER BY id_heroi
    """)

    colunas = ["id_heroi", "nome", "classe", "hp_atual", "hp_max", "status"]
    herois = [dict(zip(colunas, linha)) for linha in cursor.fetchall()]

    cursor.close()
    conn.close()
    return herois


def executar_turno():
    conn = get_connection()
    cursor = conn.cursor()

    caminho_sql = os.path.join(SQL_DIR, "turno_nevoa.sql")
    with open(caminho_sql, "r", encoding="utf-8") as arquivo:
        plsql = arquivo.read().replace("/", "").strip()

    cursor.execute(plsql)
    conn.commit()

    cursor.close()
    conn.close()


@app.route("/")
def index():
    herois = listar_herois()
    return render_template("index.html", herois=herois)


@app.route("/proximo_turno", methods=["POST"])
def proximo_turno():
    executar_turno()
    return redirect(url_for("index"))

if __name__ == "__main__":
    app.run(debug=True)