from flask import Flask, jsonify, request
from elasticsearch import Elasticsearch
import os
import logging

app = Flask(__name__)

def get_elastic_connection():
    host = os.getenv('ELASTIC_HOST') or '127.0.0.1'
    port = os.getenv('ELASTIC_PORT')
    return Elasticsearch(hosts=f'http://{host}:{port}')

# Проверка подключения
# if get_elastic_connection().ping():
#     print('Подключение успешно')
# else:
#     print('Ошибка подключения')

@app.route('/elastic/city', methods=['GET'])
def users_match_search():
    try:
        # arg = request.args.get('arg')
        # if not arg:
        #     return {'message': 'Argument "arg" is required'}, 400
        # query = {
        #     "match": {
        #     "arrival": {
        #         "query": arg,
        #         "analyzer": "ngram_ru_analyzer"
        #         }
        #     }
        # }
        query = {
            "match": {
            "arrival": {
                "query": "Мос",
                "analyzer": "ngram_ru_analyzer"
                }
            }
        }
        # print(query)
        with get_elastic_connection() as es:
            es_resp = es.search(index='tickets', query=query)
        citys = ""
        for hit in es_resp['hits']['hits']:
            city = hit['_source']['arrival']
            citys += city + ' '
        
        if citys:
            return citys
        else:
            return {'message': 'Not Found'}, 404
        
    except Exception as ex:
        logging.error(repr(ex), exc_info=True)
        return {'message': 'Bad Request'}, 400

# запуск приложения
if __name__ == '__main__':
    app.run(debug=True, port=5000)
