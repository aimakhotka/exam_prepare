from flask import Flask, jsonify, request
from elasticsearch import Elasticsearch

app = Flask(__name__)
app.config['JSON_AS_ASCII'] = False
es = Elasticsearch([{'host': 'elasticsearch', 'port': 9200}])

# Проверка подключения
if es.ping():
    print('Подключение успешно')
else:
    print('Ошибка подключения')

@app.route('/elastic/city', methods=['GET'])
def users_match_search():
    arrival = request.args.get('arrival')
    if not arrival:
        return {'message': 'Argument "arrival" is required'}, 400
    
    query = {
        "match": {
            "arrival": {
                "query": arrival,
                "analyzer": "ngram_ru_analyzer"
                }
            }
        }

    res = es.search(index='tickets', query=query)
    hits = res['hits']['hits']
    result = {hit['_id']: hit['_source'] for hit in hits}

    return jsonify(result)
        

# запуск приложения
if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5000)
