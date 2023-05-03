INSERT INTO country (name, language) VALUES
    ('Россия', 'русский'),
    ('Беларусь', 'белорусский'),
    ('Германия', 'немецкий'),
    ('Китай', 'китайский');

INSERT INTO manufacturer (name, founded, country_id) VALUES
    ('Apple', '1976-04-01', 4),
    ('Xiaomi', '2001-04-06', 1),
    ('Samsung', '1938-03-01', 2),
    ('Siemens', '1847-10-12', 3),
    ('Yandex', '2010-08-01', 1),
    ('Belarusian Knitwear', '2001-02-22', 2);

INSERT INTO product (name, price, manufacturer_id) VALUES
    ('Смартфон iPhone 13', 99999, 1),
    ('Умная колонка Алиса', 6000, 5),
    ('Платье летнее Бабушкинское', 500, 6),
    ('Смартфон Mi 11', 30999, 2),
    ('Смартфон Samsung Galaxy S21', 79900, 3),
    ('Ноутбук Samsung Galaxy Book S', 59900, 3),
    ('Кофемашина Siemens EQ.9 plus connect s500', 194990, 4);

INSERT INTO manufacturer_country(manufacturer_id, country_id)
VALUES (1, 4),
    (2, 1),
    (3, 2),
    (4, 3),
    (5, 1),
    (6, 2);
