from flask import Flask, jsonify
import logging
from logging.handlers import RotatingFileHandler
from clickhouse_driver import Client

app = Flask(__name__)
app.config['JSON_AS_ASCII'] = False

# настройка логирования
handler = RotatingFileHandler('app.log', maxBytes=10000, backupCount=1)
handler.setLevel(logging.INFO)
app.logger.addHandler(handler)

app = Flask(__name__)

@app.route('/tickets', methods=['GET'])
def get_tickets():
    client = Client(host='clickhouse', user='clickhouse', password='clickhouse', port='9000', database='postgres_repl')
    query = "SELECT toDate(f.departure_date) as date, COUNT(*) as num_tickets, AVG(t.price) as avg_price FROM flights f JOIN tickets t ON t.flight_id = f.id GROUP BY date ORDER BY date;"
    result = client.execute(query)
    response = {}
    for row in result:
        date_str = str(row[0])
        response[date_str] = {
            "count": row[1],
            "avg_price": row[2]
        }
    return jsonify(response)


# запуск приложения
if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5000)
