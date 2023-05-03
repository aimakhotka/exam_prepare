CREATE TABLE country (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    language TEXT NOT NULL
);

CREATE TABLE manufacturer (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    founded DATE NOT NULL,
    country_id INTEGER NOT NULL REFERENCES country(id)
);

CREATE TABLE product (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    price INTEGER NOT NULL,
    manufacturer_id INTEGER NOT NULL REFERENCES manufacturer(id)
);

CREATE TABLE manufacturer_country (
    manufacturer_id INTEGER NOT NULL REFERENCES manufacturer(id),
    country_id INTEGER NOT NULL REFERENCES country(id),
    PRIMARY KEY (manufacturer_id, country_id)
);
