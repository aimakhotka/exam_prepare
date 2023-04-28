# exam_prepare

## Проект ticket1
<details>
<summary> Инструкция по запуску </summary>

Для запуска данного проекта необходимо выполнить следующие шаги:

1. Установите Docker и Docker Compose на свой компьютер, если они еще не установлены. Инструкции по установке можно найти на официальных сайтах: https://docs.docker.com/get-docker/ и https://docs.docker.com/compose/install/.

2. Склонируйте репозиторий на свой компьютер:

```
https://github.com/aimakhotka/exam_prepare.git
```

3. Перейдите в папку `ticket1`
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

6. Откройте веб-браузер и перейдите на http://localhost:8000/, чтобы использовать приложение.

7. Для остановки контейнеров используйте команду:

```
docker-compose down
```

По умолчанию все данные, созданные приложением, хранятся в `postgres-data/`, которая является точкой монтирования для директории `/var/lib/postgresql/data` контейнера `postgres`. Если вы хотите удалить все данные и начать заново, просто удалите директорию `postgres-data/` перед запуском контейнеров.

</details>

<details>
<summary> Как проверить </summary>

Вот несколько тестовых запросов для проверки функциональности REST API метода /search:

1. Поиск билетов из города "Moscow" в город "London":
```
curl -X GET 'http://localhost:5000/search?city_from=Moscow&city_to=London'
```
2. Поиск билетов из города "London" в город "New York":
```
curl -X GET 'http://localhost:5000/search?city_from=London&city_to=New%20York'
```
3. Поиск билетов из города "New York" в город "San Francisco":
```
curl -X GET 'http://localhost:5000/search?city_from=New%20York&city_to=San%20Francisco'
```

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

</details>