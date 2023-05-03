from flask import Flask, request, jsonify
import psycopg2
from dotenv import load_dotenv
import os
import logging
from logging.handlers import RotatingFileHandler

app = Flask(__name__)

# настройка логирования
handler = RotatingFileHandler('app.log', maxBytes=10000, backupCount=1)
handler.setLevel(logging.INFO)
app.logger.addHandler(handler)

# загрузка переменных окружения из файла .env
load_dotenv()

# параметры подключения к базе данных из переменных окружения
db_params = {
    'dbname': os.getenv('DB_NAME'),
    'user': os.getenv('DB_USER'),
    'password': os.getenv('DB_PASSWORD'),
    'host': os.getenv('DB_HOST'),
    'port': os.getenv('DB_PORT')
}

# создание курсора для выполнения запросов
conn = psycopg2.connect(
    dbname=db_params['dbname'],
    user=db_params['user'],
    password=db_params['password'],
    host=db_params['host'],
    port=db_params['port']
)
cur = conn.cursor()

# REST API метод для отображения материализованного представления
@app.route('/joined_data')
def joined_data():
    try:
        cur.execute("SELECT * FROM joined_data_idx")
        rows = cur.fetchall()
        columns = [desc[0] for desc in cur.description]
        result = []
        for row in rows:
            result.append(dict(zip(columns, row)))
        return jsonify(result), 200
    except Exception as e:
        app.logger.error(str(e))
        return jsonify({'message': 'Internal Server Error'}), 500


# запуск приложения
if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5000)
