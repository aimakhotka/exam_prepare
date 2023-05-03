# exam_prepare
Для запуска данного проекта необходимо выполнить следующие шаги:

1. Установите Docker и Docker Compose на свой компьютер, если они еще не установлены. Инструкции по установке можно найти на официальных сайтах: https://docs.docker.com/get-docker/ и https://docs.docker.com/compose/install/.

2. Склонируйте репозиторий на свой компьютер:

```
https://github.com/aimakhotka/exam_prepare.git
```
3. Перейдите в папку нужного проекта. Далее следуйте инструкции по запуску и использованию конкретного проекта.

Важно! Нельзя держать запущенным более одного проекта, т.к. для приложения используется один порт. После завершения работы с проектом с помощью Ctrl+C, дополнительно необходимо выполнить команду `docker compose down`, чтобы удалить контейнеры и освободить порты.

## Проект ticket1
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

<details>
<summary> Инструкция по запуску </summary>

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
    "name": { "type": "text" },
    "price": { "type": "integer" },
    "manufacturer": {
        "properties": {
        "name": { "type": "text" },
        "founded": { "type": "date", "format": "yyyy-MM-dd" },
        "country": {
            "properties": {
            "name": { "type": "text" },
            "language": { "type": "text" }
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
curl -H "Content-Type: application/json" -XPOST "localhost:9200/products/_bulk?pretty" --data-binary "@path/to/add_products.json"
```
6. Откройте веб-страницу http://localhost:5000/products/by_country, чтобы получить расчет распределения количества и средней цены продуктов по странам.
```
curl http://localhost:5000/products/by_country
```
7. Откройте веб-страницу http://localhost:5000/products/price_distibution, чтобы получить расчет распределения количества продуктов по ценовым группам с интервалом 5000.
```
curl http://localhost:5000/products/price_distibution
```
8. Для остановки контейнеров используйте команду:

```
docker compose down
```

</details>


<details>
<summary> Инструкция по запуску </summary>

5. Запустите контейнеры с помощью docker-compose командой:
```
docker compose up
```
Для запуска в фоновом режиме используйте флаг -d.

6. Откройте веб-браузер и сделайте запрос (примеры запросов ниже) на http://localhost:5000/, чтобы использовать приложение.

7. Для остановки контейнеров используйте команду:

```
docker compose down
```
</details>