# exam_prepare
## A collection of practical exercises covering Docker, PostgreSQL, ElasticSearch, and a bit of Clickhouse as part of exam preparation.

To run the project, follow these steps:

Install Docker and Docker Compose on your computer if they are not already installed. Installation instructions can be found on the official websites: [Docker](https://docs.docker.com/get-docker/) and [Docker Compose](https://docs.docker.com/compose/install/).

2. Clone the repository to your computer:

```
https://github.com/aimakhotka/exam_prepare.git
```
3. Navigate to the directory of the desired project. Then follow the instructions for launching and using the specific project.

Important! You cannot have more than one project running at a time because most applications use the same ports. After finishing work with the project, use Ctrl+C to stop it, and additionally, run the command `docker compose down` to remove the containers and free up the ports.


## Project ticket1

PostgreSQL database with automatic migration using Flyway. Python-based REST API application for index search. Everything is deployed using Docker Compose.

<details>
<summary> Startup Instructions </summary>

4. Create a `.env` file in the project's root directory and populate it with environment variables according to your local configuration. Here's an example of how to fill the file: `.env`:

```
DB_NAME=airline_tickets
DB_USER=postgres
DB_PASSWORD=postgres
DB_HOST=localhost
DB_PORT=5432
```
5. Launch the containers using the docker-compose command:
```
docker compose up
```
To run in detached mode, use the -d flag.

6. How to verify

Here are several test requests to verify the functionality of the REST API method `/search`:

    1. Search for tickets from the city "Moscow" to the city "London":

    curl -v 'http://localhost:5000/search?city_from=Moscow&city_to=London'

    2. Search for tickets from the city "London" to the city "New York":

    curl -v 'http://localhost:5000/search?city_from=London&city_to=New%20York'

    3. Search for tickets from the city "New York" to the city "San Francisco":

    curl -v 'http://localhost:5000/search?city_from=New%20York&city_to=San%20Francisco'


Expected result for each request: a list of tickets (in JSON format) matching the specified parameters of departure and arrival cities. For example, for the first request, the expected result is as follows:

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

7. To stop the containers, use the command:

```
docker compose down
```
</details>

## Project ticket2

A PostgreSQL database with automatic migration applying via Flyway and concurrent refreshing of materialized view per cron. A Python REST API application for indexing search. All deployed using Docker Compose.

<details>
<summary> Startup Instructions </summary>

4. Create a `.env` file in the project's root directory and fill it with environment variables according to your local configuration. Here's an example of how to fill the file: `.env`:

```
DB_NAME=airline_tickets
DB_USER=postgres
DB_PASSWORD=postgres
DB_HOST=postgres
DB_PORT=5432
POSTGRES_DB=airline_tickets
```

5. Launch the containers using the `docker-compose` command:
```
docker compose up
```

To run in detached mode, use the -d flag.

6. Open the web page http://localhost:5000/flights_tickets_passengers to retrieve the materialized view containing the result of joining primary/foreign keys of all tables.
```
curl http://localhost:5000/flights_tickets_passengers
```

7. To stop and remove the containers, use the command:

```
docker compose down
```

</details>

## Project ticket2.2

A variation of the ticket2 project, but with a different database.
A PostgreSQL database with automatic migration applying via Flyway and concurrent refreshing of materialized view per cron. A Python REST API application for indexing search. All deployed using Docker Compose.

<details>
<summary> Startup Instructions </summary>

5. Launch the containers using the `docker-compose` command:
```
docker compose up
```
To run in detached mode, use the `-d` flag.

6. Open the web page http://localhost:5000/joined_data to retrieve the materialized view containing the result of joining primary/foreign keys of all tables.
```
curl http://localhost:5000/joined_data
```

7. To stop the containers, use the command:

```
docker compose down
```

</details>

## Project ticket6

A database in Elasticsearch and a Python REST API application with two methods for search and aggregation.

<details>
<summary> Startup Instructions </summary>

4. Create a `.env` file in the project's root directory and fill it with environment variables according to your local configuration. Here's an example of how to fill the `.env` file:

```
APP_NAME=app
ES_HOST=elasticsearch
ES_PORT=9200
```

5. Launch the containers using the `docker-compose` command:
```
docker compose up
```
To run in detached mode, use the `-d` flag.

6. Execute the request to create an index:

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

7. Execute the request to add products to the index.
```
curl -H "Content-Type: application/json" -XPOST "localhost:9200/products/_bulk?pretty" --data-binary "@ticket6/json/add_products"
```
8. Open the web page http://localhost:5000/products/by_country to obtain the calculation of the distribution of product quantities and average prices by country.
```
curl http://localhost:5000/products/by_country
```
9. Open the web page http://localhost:5000/products/price_distribution to obtain the calculation of the distribution of product quantities by price groups with an interval of 5000.
```
curl http://localhost:5000/products/price_distibution
```
10. To stop the containers, use the command:

```
docker compose down
```

</details>

## Project ticket7

A database in Elasticsearch and a Python REST API application with a method for searching based on a value passed through a URL parameter.

<details>
<summary> Startup Instructions </summary>

4. Create a `.env` file in the project's root directory and fill it with environment variables according to your local configuration. Here's an example of how to fill the `.env` file:

```
APP_NAME=app
ES_HOST=elasticsearch
ES_PORT=9200
```

5. Launch the containers using the `docker-compose` command:
```
docker compose up
```
To run in detached mode, use the `-d` flag.

6. Execute the request to create an index:

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

7. Execute the request to add products to the index, substituting the path to the file from the current directory.
```
curl -H "Content-Type: application/json" -XPOST "localhost:9200/products/_bulk?pretty" --data-binary "@json/add_products"
```
Instead of `json/add_products`, substitute the path to this file from the current directory.

8. In Postman, execute a GET request specifying the `arrival` parameter for a partial search of tickets by arrival city. For example:
```
http://localhost:5000/elastic/city?arrival=Мос
```
You cannot make a request directly via cURL as it does not support Cyrillic characters, and you will receive an empty response.

9. To stop the containers, use the command:

```
docker compose down
```

</details>

## Project ticket9

A PostgreSQL database with Flyway and cron, automatically replicating to ClickHouse. REST API method for executing queries in ClickHouse (calculating the quantity and average price of tickets grouped by flight dates).

<details>
<summary> Startup Instructions </summary>

4. Create a `.env` file in the project's root directory and fill it with environment variables according to your local configuration. Here's an example of how to fill the `.env` file:

```
DB_NAME=tickets
DB_USER=postgres
DB_PASSWORD=postgres
DB_HOST=postgres
DB_PORT=5432
POSTGRES_DB=tickets
```

5. Launch the containers using the `docker-compose` command:
```
docker compose up
```
To run in detached mode, use the `-d` flag.

6. Execute a request to the application to obtain the calculation of the distribution of ticket quantities and average prices.
```
curl 'localhost:5000/tickets'
```
There are additional query examples in `clickhouse/querys`.

7. To stop the containers, use the command:

```
docker compose down
```

</details>

## Project exam

A database in Elasticsearch and two queries.

<details>
<summary> Startup Instructions </summary>

4. Create a `.env` file in the project's root directory and fill it with environment variables according to your local configuration. Here's an example of how to fill the `.env` file:

```
APP_NAME=app
ES_HOST=elasticsearch
ES_PORT=9200
```

5. Launch the containers using the `docker-compose` command:
```
docker compose up
```
To run in detached mode, use the `-d` flag.

6. Execute the request to create an index:

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

7. Execute the request to add products to the index, substituting the path to the file from the current directory.
```
curl -H "Content-Type: application/json" -XPOST "localhost:9200/nalog/_bulk?pretty" --data-binary "@json/add_data"
```

Instead of `json/add_products` , substitute the path to this file from the current directory.

8. Execute the request in Elasticsearch to retrieve the calculation of the distribution of taxpayers and their average income (for example, using Postman):
```
GET "http://localhost:9200/nalog/_search"

// Calculating the total number of people and their average income.

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
You cannot make a request directly via cURL as it does not support Cyrillic characters, and you will receive an empty response.

9. Execute the request in Elasticsearch to distribute taxpayers by income groups:
```
GET "http://localhost:9200/nalog/_search"

// Distribution of the number of people not from Moscow and Saint Petersburg, aged 25 to 30, by income groups.

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

10. To stop the containers, use the command:

```
docker compose down
```

</details>
