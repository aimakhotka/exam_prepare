CREATE TABLE flights (
    id SERIAL PRIMARY KEY,
    departure_date DATE NOT NULL,
    departure_city VARCHAR(255) NOT NULL,
    arrival_city VARCHAR(255) NOT NULL
);

CREATE TABLE tickets (
    id SERIAL PRIMARY KEY,
    price NUMERIC(10,2) NOT NULL,
    class VARCHAR(255) NOT NULL,
    flight_id INTEGER NOT NULL REFERENCES flights(id)
);

CREATE TABLE passengers (
    id SERIAL PRIMARY KEY,
    full_name VARCHAR(255) NOT NULL,
    birth_date DATE NOT NULL,
    ticket_id INTEGER NOT NULL REFERENCES tickets(id)
); 

CREATE TABLE tickets_passengers (
  ticket_id INTEGER NOT NULL REFERENCES tickets(id),
  passenger_id INTEGER NOT NULL REFERENCES passengers(id),
  PRIMARY KEY (ticket_id, passenger_id)
);
