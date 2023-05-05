# exam_prepare
## Сборник практических работ с Docker, PostgreSQL, ElasticSearch и немного Clickhouse в рамках подготовки к экзамену.

Для запуска проекта необходимо выполнить следующие шаги:

1. Установите Docker и Docker Compose на свой компьютер, если они еще не установлены. Инструкции по установке можно найти на официальных сайтах: https://docs.docker.com/get-docker/ и https://docs.docker.com/compose/install/.

2. Склонируйте репозиторий на свой компьютер:

```
https://github.com/aimakhotka/exam_prepare.git
```
3. Перейдите в папку нужного проекта. Далее следуйте инструкции по запуску и использованию конкретного проекта.

Важно! Нельзя держать запущенным более одного проекта, т.к. для большинства приложений используются одини порты. После завершения работы с проектом с помощью Ctrl+C, дополнительно необходимо выполнить команду `docker compose down`, чтобы удалить контейнеры и освободить порты.

## Проект ticket1

База данных в PostgreSQL с автоматическим применением миграций flyway. REST API приложение на Python для поиска по индексу. Все разворачивается с помощью docker compose.

<details>
<summary> Инструкция по запуску </summary>

4. Создайте файл `.env` в корневой директории проекта и заполните его переменными окружения в соответствии с вашей локальной конфигурацией. Пример заполнения файла `.env`:

```
DB_NAME=airline_tickets
DB_USER=postgres
DB_PASSWORD=postgres
DB_HOST=localhost
DB_PORT=5432
```
5. Запустите контейнеры с помощью docker-compose командой:
```
docker compose up
```
Для запуска в фоновом режиме используйте флаг -d.

6. Как проверить

Вот несколько тестовых запросов для проверки функциональности REST API метода /search:

    1. Поиск билетов из города "Moscow" в город "London":

    curl -v 'http://localhost:5000/search?city_from=Moscow&city_to=London'

    2. Поиск билетов из города "London" в город "New York":

    curl -v 'http://localhost:5000/search?city_from=London&city_to=New%20York'

    3. Поиск билетов из города "New York" в город "San Francisco":

    curl -v 'http://localhost:5000/search?city_from=New%20York&city_to=San%20Francisco'


Ожидаемый результат для каждого запроса: список билетов (в виде JSON-объекта), соответствующих заданным параметрам городов отправления и прибытия. Например, для первого запроса ожидается следующий результат:

```
[    {        
        "flight_id": 1,        
        "date": "2023-05-01",        
        "from_city": "Moscow",        
        "to_city": "London",        
        "ticket_id": 1,        
        "price": 1000,        
        "class": "economy",        
        "passenger_id": 1,        
        "full_name": "John Smith",        
        "birth_date": "1980-01-01"    
    },    
    {        
        "flight_id": 1,        
        "date": "2023-05-01",        
        "from_city": "Moscow",        
        "to_city": "London",        
        "ticket_id": 2,        
        "price": 2500,        
        "class": "business",        
        "passenger_id": 2,        
        "full_name": "Jane Smith",        
        "birth_date": "1985-02-15"    
    }
]
```

7. Для остановки контейнеров используйте команду:

```
docker compose down
```
</details>

## Проект ticket2

База данных в PostgreSQL с автоматическим применением миграций flyway и конкурентным обновлением материализованного представления по cron. REST API приложение на Python для поиска по индексу. Все разворачивается с помощью docker compose.

<details>
<summary> Инструкция по запуску </summary>

4. Создайте файл `.env` в корневой директории проекта и заполните его переменными окружения в соответствии с вашей локальной конфигурацией. Пример заполнения файла `.env`:

```
DB_NAME=airline_tickets
DB_USER=postgres
DB_PASSWORD=postgres
DB_HOST=postgres
DB_PORT=5432
POSTGRES_DB=airline_tickets
```

5. Запустите контейнеры с помощью docker-compose командой:
```
docker compose up
```

Для запуска в фоновом режиме используйте флаг -d.

6. Откройте веб-страницу http://localhost:5000/flights_tickets_passengers, чтобы получить материализованное представление, содержащее результат соединения по первичным/внешним ключам всех таблиц.
```
curl http://localhost:5000/flights_tickets_passengers
```

7. Для остановки и удаления контейнеров используйте команду:

```
docker compose down
```

</details>

## Проект ticket2.2

Вариация проекта ticket2, но с другой БД.
База данных в PostgreSQL с автоматическим применением миграций flyway и конкурентным обновлением материализованного представления по cron. REST API приложение на Python для поиска по индексу. Все разворачивается с помощью docker compose.

<details>
<summary> Инструкция по запуску </summary>

5. Запустите контейнеры с помощью docker-compose командой:
```
docker compose up
```
Для запуска в фоновом режиме используйте флаг -d.

6. Откройте веб-страницу http://localhost:5000/joined_data, чтобы получить материализованное представление, содержащее результат соединения по первичным/внешним ключам всех таблиц.
```
curl http://localhost:5000/joined_data
```

7. Для остановки контейнеров используйте команду:

```
docker compose down
```

</details>

## Проект ticket6

База данных в ElasticSearch и REST API приложение на Python с двумя методами для поиска и агрегации

<details>
<summary> Инструкция по запуску </summary>

4. Создайте файл `.env` в корневой директории проекта и заполните его переменными окружения в соответствии с вашей локальной конфигурацией. Пример заполнения файла `.env`:

```
APP_NAME=app
ES_HOST=elasticsearch
ES_PORT=9200
```

5. Запустите контейнеры с помощью docker-compose командой:
```
docker compose up
```
Для запуска в фоновом режиме используйте флаг -d.

6. Выполните запрос для создания индекса:

```
curl -X PUT "localhost:9200/products" -H 'Content-Type: application/json' -d'
{
  "mappings": {
    "properties": {
      "name": { "type": "keyword" },
      "price": { "type": "integer" },
      "manufacturer": {
        "properties": {
          "name": { "type": "keyword" },
          "founded": { "type": "date", "format": "yyyy-MM-dd" },
          "country": {
            "properties": {
              "name": { "type": "keyword" },
              "language": { "type": "keyword" }
            }
          }
        }
      }
    }
  }
}
'
```

7. Выполните запрос для добавления продуктов в индекс:
```
curl -H "Content-Type: application/json" -XPOST "localhost:9200/products/_bulk?pretty" --data-binary "@ticket6/json/add_products"
```
8. Откройте веб-страницу http://localhost:5000/products/by_country, чтобы получить расчет распределения количества и средней цены продуктов по странам.
```
curl http://localhost:5000/products/by_country
```
9. Откройте веб-страницу http://localhost:5000/products/price_distibution, чтобы получить расчет распределения количества продуктов по ценовым группам с интервалом 5000.
```
curl http://localhost:5000/products/price_distibution
```
10. Для остановки контейнеров используйте команду:

```
docker compose down
```

</details>

## Проект ticket7

База данных в ElasticSearch и REST API приложение на Python с методом для поиска по переданному через параметр URL значению.

<details>
<summary> Инструкция по запуску </summary>

4. Создайте файл `.env` в корневой директории проекта и заполните его переменными окружения в соответствии с вашей локальной конфигурацией. Пример заполнения файла `.env`:

```
APP_NAME=app
ES_HOST=elasticsearch
ES_PORT=9200
```

5. Запустите контейнеры с помощью docker-compose командой:
```
docker compose up
```
Для запуска в фоновом режиме используйте флаг -d.

6. Выполните запрос для создания индекса:

```
curl -X PUT "localhost:9200/tickets" -H 'Content-Type: application/json' -d'
{
  "settings": {
      "index": {
          "number_of_shards": 1,
          "number_of_replicas": 0
      },
      "analysis": {
          "filter": {
              "russian_stop": {
                  "type": "stop",
                  "stopwords": "_russian_"
              },
              "russian_stemmer": {
                  "type": "stemmer",
                  "language": "russian"
              },
              "my_synonym": {
                  "type": "synonym",
                  "synonyms": [
                      "эконом => econom",
                      "бизнес => buisness",
                      "лайт => light"
                  ]
              },
              "text_ngram_filter": {
                  "type": "edge_ngram",
                  "min_gram": 1,
                  "max_gram": 10
              }
          },
          "analyzer": {
              "text_ru_analyzer": {
                  "tokenizer": "standard",
                  "filter": [
                      "lowercase",
                      "russian_stop",
                      "russian_stemmer",
                      "my_synonym"
                  ]
              },
              "ngram_ru_analyzer": {
                  "type": "custom",
                  "tokenizer": "standard",
                  "filter": [
                      "lowercase",
                      "text_ngram_filter"
                  ]
              }
          }
      }
  },
  "mappings": {
      "properties": {
          "price": {
              "type": "scaled_float",
              "scaling_factor": 100
          },
          "grade": {
              "type": "text",
              "analyzer": "text_ru_analyzer"
          },
          "date": {
              "type": "date"
          },
          "departure": {
              "type": "text",
              "analyzer": "ngram_ru_analyzer"
          },
          "arrival": {
              "type": "text",
              "analyzer": "ngram_ru_analyzer"
          }
      }
  }
}'
```

7. Выполните запрос для добавления продуктов в индекс:
```
curl -H "Content-Type: application/json" -XPOST "localhost:9200/products/_bulk?pretty" --data-binary "@json/add_products"
```
Вместо `json/add_products` подставьте путь к данному файлу из текущей папки.

8. В Postman выполните GET запрос с указанием параметра arrival для частичного поиска билетов по городу прибытия. Например,
```
http://localhost:5000/elastic/city?arrival=Мос
```
Curl не поддерживает кириллицу, так что через него сделать запрос нельзя.

9. Для остановки контейнеров используйте команду:

```
docker compose down
```

</details>

## Проект ticket9

База данных в PostgreSQL с flyway и cron, автоматически реплицирующаяся в ClickHouse. REST API метод для выполнения запроса в Clickhouse (расчет количества и средней цены билетов, сгруппированные по датам рейсов).

<details>
<summary> Инструкция по запуску </summary>

4. Создайте файл `.env` в корневой директории проекта и заполните его переменными окружения в соответствии с вашей локальной конфигурацией. Пример заполнения файла `.env`:

```
DB_NAME=tickets
DB_USER=postgres
DB_PASSWORD=postgres
DB_HOST=postgres
DB_PORT=5432
POSTGRES_DB=tickets
```

5. Запустите контейнеры с помощью docker-compose командой:
```
docker compose up
```
Для запуска в фоновом режиме используйте флаг -d.

6. Выполните запрос к приложению, чтобы получить расчет распределения количества и средней цены билетов:
```
curl 'localhost:5000/tickets'
```
В clickhouse/querys есть еще примеры запросов в Clickhouse.

7. Для остановки контейнеров используйте команду:

```
docker compose down
```

</details>

## Проект exam

База данных в ElasticSearch и два запроса.

<details>
<summary> Инструкция по запуску </summary>

4. Создайте файл `.env` в корневой директории проекта и заполните его переменными окружения в соответствии с вашей локальной конфигурацией. Пример заполнения файла `.env`:

```
APP_NAME=app
ES_HOST=elasticsearch
ES_PORT=9200
```

5. Запустите контейнеры с помощью docker-compose командой:
```
docker compose up
```
Для запуска в фоновом режиме используйте флаг -d.

6. Выполните запрос для создания индекса:

```
curl -X PUT "localhost:9200/nalog" -H 'Content-Type: application/json' -d'
{
  "mappings": {
    "properties": {
      "name": { "type": "keyword" },
      "birth_date": { "type": "date", "format": "yyyy-MM-dd" },
      "dohod": { "type": "integer" },
      "city": { "type": "keyword" }
      }
    }
  }
'
```

7. Выполните запрос для добавления продуктов в индекс:
```
curl -H "Content-Type: application/json" -XPOST "localhost:9200/nalog/_bulk?pretty" --data-binary "@json/add_data"
```
Вместо `json/add_products` подставьте путь к данному файлу из текущей папки.

8. Выполните запрос в ElasticSeach, чтобы получить расчет распределения количества налогоплательщиков и их среднего дохода (например, с помощью Postman):
```
GET "http://localhost:9200/nalog/_search"

// Подсчет общего количества людей и их средний доход

{
  "size": 0,
  "aggregations": {
    "total_people": {
      "value_count": {
        "field": "name"
      }
    },
    "avg_dohod": {
      "avg": {
        "field": "dohod"
      }
    }
  }
}
```
Curl не поддерживает кириллицу, так что через него напрямую сделать запрос нельзя - вы будете получать пустой ответ.

9. Выполните запрос в ElasticSeach для распределения налогоплательщиков по группам дохода:
```
GET "http://localhost:9200/nalog/_search"

// Распределение количества людей не из Москвы и Санкт-Петербурга и от 25 до 30 лет по группам дохода

{
  "size": 0,
  "query": {
    "bool": {
    "must_not": [
        {
          "terms": {
            "city": [
              "Москва",
              "Санкт-Петербург"
            ]
          }
        }
      ],
    "must": {
        "range": {
        "birth_date": {
            "gte": "1993-01-01",
            "lt": "1998-01-01"
        }
        }
    }
    }
  },
  "aggs": {
    "dohod_range": {
      "range": {
        "field": "dohod",
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
}'
```

10. Для остановки контейнеров используйте команду:

```
docker compose down
```

</details>