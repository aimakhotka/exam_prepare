INSERT INTO flights(departure_date, departure_city, arrival_city) 
VALUES ('2023-05-01', 'Moscow', 'London'),
       ('2023-05-03', 'London', 'New York'),
       ('2023-05-05', 'New York', 'San Francisco'),
       ('2022-12-31', 'Moscow', 'Sochi'),
       ('2022-12-31', 'Moscow', 'Sochi');


INSERT INTO tickets(price, class, flight_id)
VALUES (1000, 'economy', 1),
       (2500, 'business', 1),
       (500, 'economy', 2),
       (2000, 'business', 2),
       (150, 'economy', 3),
       (750, 'economy', 4),
       (1010, 'economy', 5),
       (2000, 'business', 4),
       (4000, 'business', 5);


INSERT INTO passengers(full_name, birth_date, ticket_id)
VALUES ('John Smith', '1980-01-01', 1),
       ('Jane Smith', '1985-02-15', 2),
       ('Bob Johnson', '1972-12-31', 3),
       ('Alice Johnson', '1975-08-20', 4),
       ('Mike Brown', '1990-05-10', 5),
       ('Jhon Doe', '1999-01-01', 6),
       ('Jhane Doe', '1992-01-01', 7),
       ('Khalisi Dragonborn', '1992-07-01', 8),
       ('Vladimir Putin', '1966-09-01', 9);


INSERT INTO tickets_passengers(ticket_id, passenger_id)
VALUES (1,1),
       (2,2),
       (3,3),
       (4,4),
       (5,5),
       (6,6),
       (7,7),
       (8,8),
       (9,9);