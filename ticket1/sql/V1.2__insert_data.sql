INSERT INTO flights(departure_date, departure_city, arrival_city) 
VALUES ('2023-05-01', 'Moscow', 'London'),
       ('2023-05-03', 'London', 'New York'),
       ('2023-05-05', 'New York', 'San Francisco');


INSERT INTO tickets(price, class, flight_id)
VALUES (1000, 'economy', 1),
       (2500, 'business', 1),
       (500, 'economy', 2),
       (2000, 'business', 2),
       (150, 'economy', 3),
       (1000, 'business', 3);


INSERT INTO passengers(full_name, birth_date, ticket_id)
VALUES ('John Smith', '1980-01-01', 1),
       ('Jane Smith', '1985-02-15', 2),
       ('Bob Johnson', '1972-12-31', 3),
       ('Alice Johnson', '1975-08-20', 4),
       ('Mike Brown', '1990-05-10', 5),
       ('Sarah Brown', '1992-07-01', 6);


INSERT INTO tickets_passengers(ticket_id, passenger_id)
VALUES (1,1),
       (1,2),
       (2,3),
       (2,4),
       (3,5),
       (3,6);