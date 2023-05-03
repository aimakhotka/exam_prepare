CREATE MATERIALIZED VIEW joined_data AS
SELECT c.id as country_id, c.name as country_name, c.language as country_language,
       m.id as manufacturer_id, m.name as manufacturer_name, m.founded as manufacturer_founded,
       p.id as product_id, p.name as product_name, p.price as product_price
FROM country c
JOIN manufacturer m ON c.id = m.country_id
JOIN product p ON m.id = p.manufacturer_id
JOIN manufacturer_country mc ON m.id = mc.manufacturer_id AND c.id = mc.country_id;

CREATE UNIQUE INDEX joined_data_idx ON joined_data (country_id, manufacturer_id, product_id);
