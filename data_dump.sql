-- CREATE TABLE customers_services(
-- id serial PRIMARY KEY,
-- customer_id integer REFERENCES customers(id) ON DELETE CASCADE,
-- service_id integer REFERENCES services(id)
-- );
-- ALTER TABLE customers_services ADD CONSTRAINT unique_ids UNIQUE(customer_id, service_id);
-- INSERT INTO customers_services (customer_id, service_id) VALUES
-- (1, 1), (1, 2), (1, 3), (3, 1), (3, 2), (3, 3), (3, 4), (3, 5),
-- (4, 1), (4, 4), (5, 1), (5, 2), (5, 6), (6, 1), (6, 6), (6, 7);

-- SELECT DISTINCT customers.*, services.* FROM customers 
-- LEFT OUTER JOIN customers_services ON customers.id = customers_services.customer_id
-- FULL OUTER JOIN services ON services.id = customers_services.service_id
-- WHERE service_id IS NULL OR price IS NULL;

-- SELECT description FROM customers_services RIGHT OUTER JOIN services ON services.id = customers_services.service_id
-- WHERE customers_services.id IS NULL;

-- SELECT c.name, string_agg(s.description, ', ') FROM customers as c LEFT JOIN customers_services as cs ON c.id = cs.customer_id
-- LEFT JOIN services as s ON s.id = cs.service_id GROUP BY c.name;

-- SELECT description, count(service_id) FROM services INNER JOIN customers_services ON
-- services.id = customers_services.customer_id GROUP BY description HAVING count(service_id) >= 3 ;

-- SUQURIES AND MORE!

-- CREATE TABLE bidders (
-- id serial PRIMARY KEY,
-- name text NOT NULL);

-- CREATE TABLE items (
-- id serial PRIMARY KEY,
-- name text NOT NULL,
-- initial_price numeric(6, 2) NOT NULL CHECK (initial_price BETWEEN 0.01 AND 1000.00),
-- sales_price numeric(6, 2) CHECK (sales_price BETWEEN 0.01 AND 1000.00));

-- CREATE TABLE bids (
-- id serial PRIMARY KEY,
-- bidder_id integer NOT NULL REFERENCES bidders(id) ON DELETE CASCADE,
-- item_id integer NOT NULL REFERENCES items(id) ON DELETE CASCADE,
-- amount numeric(6, 2) NOT NULL CHECK (amount BETWEEN 0.01 AND 1000.00));

-- CREATE INDEX ON bids(bidder_id, item_id);

-- SELECT name FROM bidders WHERE EXISTS (SELECT bidder_id FROM bids);

-- SELECT max(count) FROM (SELECT bidder_id, count(item_id) FROM bids GROUP BY bidder_id) AS fun;

-- SELECT name, (SELECT count(item_id) FROM bids WHERE item_id = items.id ) FROM items;

-- SELECT id FROM items WHERE row(name, initial_price, sales_price) = row('Painting', 100.00, 250.00);

-- INSERT INTO birds(name, age, species) VALUES
-- ('Charlie', 3, 'Finch'),
-- ('Allie', 5, 'Owl'),
-- ('Jennifer', 3, 'Magpie'),
-- ('Jamie', 4, 'Owl'),
-- ('Roy', 8, 'Crow');

-- CREATE TABLE stars(
-- id serial PRIMARY KEY,
-- name varchar(25) NOT NULL UNIQUE,
-- distance integer NOT NULL CHECK (distance > 0),
-- spectral_type char(1) CHECK (spectral_type IN ('O', 'B', 'A', 'F', 'G', 'K', 'M')),
-- companions integer NOT NULL CHECK (companions >= 0)); 

-- CREATE TABLE planets(
-- id serial PRIMARY KEY,
-- designation char(1),
-- mass integer CHECK (mass > 0));

-- CREATE TYPE spectral_data_type AS ENUM ('O', 'B', 'A', 'F', 'G', 'K', 'M');

-- ALTER TABLE stars DROP CONSTRAINT stars_spectral_type_check;

-- ALTER TABLE stars ALTER COLUMN spectral_type TYPE spectral_data_type USING spectral_type::spectral_data_type;

-- CREATE TABLE moons (
-- id serial PRIMARY KEY,
-- designation integer NOT NULL,
-- semi_major_axis numeric CHECK (semi_major_axis > 0),
-- mass numeric CHECK (mass > 0.0));

-- ALTER TABLE moons
-- ADD COLUMN planet_id integer NOT NULL REFERENCES planets(id);

-- CREATE TABLE devices (
-- id serial PRIMARY KEY,
-- name text NOT NULL,
-- created_at timestamp DEFAULT now());

-- CREATE TABLE parts(
-- id serial PRIMARY KEY,
-- part_number integer UNIQUE NOT NULL,
-- device_id integer REFERENCES devices(id));

-- INSERT INTO devices VALUES
-- (DEFAULT, 'Accelerometer'),
-- (DEFAULT, 'Gyroscope');

-- INSERT INTO parts(part_number, device_id) VALUES 
-- (34, 1), (35, 1), (36, 1), (37, 2), (38, 2), (39, 2), (40, 2), (41, 2),
-- (42, NULL), (43, NULL), (44, NULL);

-- CREATE TABLE customers(
-- id serial PRIMARY KEY,
-- name text NOT NULL,
-- payment_token char(8) NOT NULL UNIQUE CHECK (payment_token ~ '^[A-Z]{8}$')
-- );

-- CREATE TABLE services(
-- id serial PRIMARY KEY,
-- description text NOT NULL,
-- price numeric(10, 2) NOT NULL CHECK (price >= 0.00));

-- INSERT INTO customers (name, payment_token)
-- VALUES
--   ('Pat Johnson', 'XHGOAHEQ'),
--   ('Nancy Monreal', 'JKWQPJKL'),
--   ('Lynn Blake', 'KLZXWEEE'),
--   ('Chen Ke-Hua', 'KWETYCVX'),
--   ('Scott Lakso', 'UUEAPQPS'),
--   ('Jim Pornot', 'XKJEYAZA');

-- INSERT INTO services (description, price) VALUES
-- ('Unix Hosting', 5.95), ('DNS', 4.95), ('Whois Registration', 1.95), ('High Bandwidth', 15.00), ('Business Support', 250.00), ('Dedicated Hosting', 50.00), 
-- ('Bulk Email', 250.00), ('One-to-one Training', 999.00);

-- CREATE TABLE customers_services (
-- id serial PRIMARY KEY,
-- customer_id integer NOT NULL REFERENCES customers(id) ON DELETE CASCADE,
-- service_id integer NOT NULL REFERENCES services(id),
-- UNIQUE (customer_id, service_id));

-- INSERT INTO customers_services(customer_id, service_id) VALUES
-- (1, 1), (1, 2), (1, 3), (3, 1), (3, 2), (3, 3), (3, 4), (3, 5),
-- (4, 1), (4, 4), (5, 1), (5, 2), (5, 6), (6, 1), (6, 6), (6, 7);

-- SELECT name, string_agg(description, ',') as services 
--   FROM customers as c 
--   LEFT OUTER JOIN customers_services as cs 
--   ON c.id = cs.customer_id 
--     LEFT OUTER JOIN services as s 
--     ON s.id = cs.service_id GROUP BY name; 

-- SELECT description, count(service_id) FROM services INNER JOIN customers_services ON services.id = service_id GROUP BY description HAVING count(service_id) >= 3;

-- INSERT INTO customers(name, payment_token) VALUES
-- ('John Doe', 'EYODHLCN');

-- INSERT INTO customers_services(customer_id, service_id) VALUES
-- (7, 1), (7, 2), (7, 3);

-- SELECT SUM(price) FROM customers CROSS JOIN services WHERE price > 100;

-- CREATE TABLE bidders (
-- id serial PRIMARY KEY,
-- name text NOT NULL);

-- CREATE TABLE items(
-- id serial PRIMARY KEY,
-- name text NOT NULL,
-- initial_price numeric(6, 2) NOT NULL CHECK (initial_price BETWEEN 0 AND 1001),
-- sales_price numeric(6, 2) CHECK (sales_price >= 0));

-- CREATE TABLE bids(
-- id serial PRIMARY KEY,
-- bidder_id integer NOT NULL REFERENCES bidders(id) ON DELETE CASCADE,
-- item_id integer NOT NULL REFERENCES items(id) ON DELETE CASCADE,
-- amount numeric(6, 2) NOT NULL CHECK (amount BETWEEN 0 AND 1001));


-- CREATE INDEX ON bids (bidder_id, item_id);

-- INSERT INTO people VALUES 
-- ('Abby', 34, 	'biologist'),
-- ('Mu''nisah',	26,	NULL),
-- ('Mirabelle',	40,	'contractor')

-- CREATE TABLE birds(
-- name text,
-- length numeric,
-- wingspan numeric,
-- family text,
-- extinct boolean);

-- INSERT INTO birds VALUES 
-- ('Spotted Towhee', 21.6, 26.7, 	'Emberizidae', false),
-- ('American Robin', 	25.5, 	36.0, 	'Turdidae', 	false),
-- ('Greater Koa Finch', 	19.0, 	24.0, 	'Fringillidae', 	true),
-- ('Carolina Parakeet', 33.0, 	55.8, 	'Psittacidae', 	true),
-- ('Common Kestrel', 	35.5, 	73.5, 	'Falconidae', 	false);

-- CREATE TABLE menu_items(
-- item text,
-- prep_time integer,
-- ingredient_cost numeric(4, 2),
-- sales integer,
-- menu_price numeric(4, 2));

-- INSERT INTO films VALUES
-- ('1984,', 	1956, 	'scifi', 	'Michael Anderson',	90),
-- ('Tinker Tailor Soldier Spy', 2011, 	'espionage', 	'Tomas Alfredson', 	127),
-- ('The Birdcage', 	1996,	'comedy', 'Mike Nichols', 	118);

-- CREATE TABLE temperatures (
-- "date" date NOT NULL,
-- low integer NOT NULL,
-- high integer NOT NULL);

-- INSERT INTO temperatures VALUES
-- ('2016-03-01', 34, 43),
-- ('2016-03-02', 32, 44),
-- ('2016-03-03', 31, 47),
-- ('2016-03-04', 33, 42),
-- ('2016-03-05', 39, 46),
-- ('2016-03-06', 32, 43),
-- ('2016-03-07', 29, 32),
-- ('2016-03-08', 23, 31),
-- ('2016-03-09', 17, 28);

-- INSERT INTO films VALUES 
-- (DEFAULT, 'Wayne''s World', 	1992, 	'comedy',	'Penelope Spheeris', 	95),
-- (DEFAULT, 'Bourne Identity', 	2002, 	'espionage', 'Doug Liman', 	118)

-- SELECT round((count(DISTINCT customer_id)::numeric / count(DISTINCT customers.id)::numeric) * 100, 2) FROM customers LEFT OUTER JOIN tickets ON customers.id = tickets.customer_id;

-- SELECT customers.id, email, count(DISTINCT tickets.event_id) as count 
-- FROM customers 
-- INNER JOIN tickets ON customers.id = tickets.customer_id 
-- GROUP BY customers.id HAVING count(DISTINCT tickets.event_id) = 3; 

-- SELECT events.name, events.starts_at, sections.name, seats.row, seats.number as seat FROM events
-- INNER JOIN tickets ON events.id = tickets.event_id
-- INNER JOIN customers ON tickets.customer_id = customers.id
-- INNER JOIN seats ON tickets.seat_id = seats.id
-- INNER JOIN sections ON seats.section_id = sections.id WHERE email = 'gennaro.rath@mcdermott.co';

-- CREATE TABLE movies (
-- id serial PRIMARY KEY,
-- title text NOT NULL,
-- year integer NOT NULL CHECK (year BETWEEN 1000 AND 10000),
-- run_time integer NOT NULL);

-- INSERT INTO movies (title, year, run_time) VALUES
-- ('Gravity', 2013, 91),
-- ('M*A*S*H', 1970, 116),
-- ('My Fair Lady', 1964, 170),
-- ('Ocean''s Eleven', 2001, 116),
-- ('The Perfect Storm', 2000, 130),
-- ('While You Were Sleeping', 1995, 103),
-- ('2001: A Space Odyssey', 1968, 149);

-- SELECT title as "Movie Title", year as "Released", run_time as "Run Time" From movies
-- WHERE year < 2000 ORDER BY run_time DESC LIMIT 3;

-- CREATE TABLE actors(
-- id serial PRIMARY KEY,
-- name text NOT NULL)

-- INSERT INTO actors (name) VALUES
-- ('Abe Vigoda'),
-- ('Audrey Hepburn'),
-- ('Barbara Billingsley'),
-- ('Elliot Gould'),
-- ('George Clooney'),
-- ('Sandra Bullock');

-- ALTER TABLE actors DROP COLUMN movie_id;

-- CREATE TABLE actors_movies (
-- id serial PRIMARY KEY,
-- movie_id integer REFERENCES movies (id),
-- actor_id integer REFERENCES actors (id));

-- INSERT INTO actors_movies (movie_id, actor_id) VALUES
-- (4, 5), (4, 4), (5, 5), (2, 4), (3, 2), (1, 6), (1, 5), (6, 6);

-- SELECT title FROM actors INNER JOIN actors_movies On actor_id = actors.id INNER JOIN movies ON movie_id = movies.id
-- WHERE name = 'George Clooney';

-- SELECT name as "Actor", count(movie_id) as "Number of Movies" FROM actors INNER JOIN actors_movies ON actor_id = actors. id 
-- GROUP BY name HAVING count(movie_id) >= 2;

-- SELECT title as "Movie Title" FROM movies LEFT OUTER JOIN actors_movies ON movie_id = movies.id WHERE actor_id IS NULL; 

-- ALTER TABLE movies ADD CHECK (year >= 1878);

-- INSERT INTO movies VALUES (DEFAULT, 'HI', 1500, 65);