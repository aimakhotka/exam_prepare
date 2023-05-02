CREATE MATERIALIZED VIEW flights_tickets_passengers_mv AS 
SELECT f.id AS flight_id, f.departure_date AS date, f.departure_city AS from_city, f.arrival_city AS to_city, t.id AS ticket_id, t.price, t.class, p.id AS passenger_id, p.full_name, p.birth_date
FROM flights f
JOIN tickets t ON f.id = t.flight_id
JOIN passengers p ON t.id = p.ticket_id;

CREATE UNIQUE INDEX flights_tickets_passengers_mv_pk_idx ON flights_tickets_passengers_mv (flight_id, ticket_id, passenger_id);