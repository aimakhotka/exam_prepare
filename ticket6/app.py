from flask import Flask, jsonify
from elasticsearch import Elasticsearch

app = Flask(__name__)
app.config['JSON_AS_ASCII'] = False
es = Elasticsearch([{'host': 'elasticsearch', 'port': 9200}])

# Проверка подключения
if es.ping():
    print('Подключение успешно')
else:
    print('Ошибка подключения')

@app.route('/products/by_country', methods=['GET'])
def get_products_by_country():
    query = {
      "size": 0,
      "aggregations": {
        "by_country": {
          "terms": {
            "field": "manufacturer.country.name",
            "size": 20
          },
          "aggregations": {
            "total_products": {
              "value_count": {
                "field": "name"
              }
            },
            "attribVal": {
              "terms": {
                "field": "name"
              }
            },
            "avg_price": {
              "avg": {
                "field": "price"
              }
            }
          }
        }
      }
    }

    res = es.search(index="products", body=query)
    buckets = res['aggregations']['by_country']['buckets']
    result = {
        bucket['key']: {
            'count': bucket['total_products']['value'], 
            'avg_price': round(bucket['avg_price']['value'], 2)
        } for bucket in buckets
    }
    return jsonify(result)

@app.route('/products/price_distibution', methods=['GET'])
def get_price_distibution():
    query = {
      "size": 0,
      "query": {
        "bool": {
          "must": [
            {
              "terms": {
                "manufacturer.country.name": [
                  "Россия",
                  "Беларусь"
                ]
              }
            },
            {
              "range": {
                "manufacturer.founded": {
                  "gte": "2000-01-01",
                  "lt": "now/d"
                }
              }
            }
          ]
        }
      },
      "aggs": {
        "price_distribution": {
          "range": {
            "field": "price",
            "ranges": [
              {
                "from": 0,
                "to": 5000
              },
              {
                "from": 5000,
                "to": 10000
              },
              {
                "from": 10000,
                "to": 15000
              },
              {
                "from": 15000,
                "to": 20000
              },
              {
                "from": 20000
              }
            ]
          }
        }
      }
    }

    result = es.search(index="products", body=query)
    buckets = result["aggregations"]["price_distribution"]["buckets"]
    response = {}
    for bucket in buckets:
        key = f"{bucket['from']} - {bucket.get('to', 'above')}"
        count = bucket["doc_count"]
        response[key] = count

    return jsonify(response)

# запуск приложения
if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5000)
