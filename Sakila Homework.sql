USE sakila;

-- 1a
SELECT 
    first_name, last_name
FROM
    actor;
    
-- 1b
ALTER TABLE actor ADD COLUMN `Actor Name` VARCHAR(50);

UPDATE actor 
SET 
    `Actor Name` = CONCAT(first_name, ' ', last_name);

UPDATE actor 
SET 
    `Actor Name` = UPPER(`Actor Name`);
    
-- 2a
SELECT 
    actor_id, first_name, last_name
FROM
    actor
WHERE
    first_name = 'Joe';

-- 2b
SELECT 
    actor_id, first_name, last_name
FROM
    actor
WHERE
    last_name LIKE '%gen%';

-- 2c
SELECT 
    last_name, first_name
FROM
    actor
WHERE
    last_name LIKE '%LI%';

-- 2d
SELECT 
    country_id, country
FROM
    country
WHERE
    country IN ('Afghanistan' , 'Bangladesh', 'China');

-- 3a 
ALTER TABLE actor
  ADD description blob;
  
-- 3b
Alter Table actor drop description;

-- 4a
SELECT 
    last_name, COUNT(last_name) AS 'Actors by Last Name'
FROM
    actor
GROUP BY last_name;

-- 4b
SELECT 
    last_name, COUNT(last_name) AS 'Actors by Last Name'
FROM
    actor
GROUP BY last_name
HAVING COUNT(last_name) > 1;

-- 4c
UPDATE actor 
SET 
    first_name = 'Harpo'
WHERE
    first_name = 'Groucho'
        AND last_name = 'Williams';
     
-- 4d
UPDATE actor 
SET 
    first_name = 'Groucho'
WHERE
    first_name = 'Harpo'
        AND last_name = 'Williams';
     
-- 5a
CREATE SCHEMA address;

-- 6a
SELECT 
    staff.first_name, staff.last_name, address.address
FROM
    staff
        LEFT JOIN
    address ON staff.address_id = address.address_id;
    
 -- 6b


-- 6c
SELECT 
    title, COUNT(actor_id) AS `Actor Count`
FROM
    film_actor
        INNER JOIN
    film ON film.film_id = film_actor.film_id
GROUP BY title;

-- 6d
SELECT 
    COUNT(inventory_id) AS `Number of Hunchback Impossible`
FROM
    inventory
WHERE
    film_id IN (SELECT 
            film_id
        FROM
            film
        WHERE
            title = 'Hunchback Impossible');

-- 6e
SELECT 
    customer.last_name,
    customer.first_name,
    SUM(payment.amount) AS `Total Paid`
FROM
    customer
        LEFT JOIN
    payment ON customer.customer_id = payment.customer_id
GROUP BY customer.last_name , customer.first_name;
    
-- 7a
SELECT 
    title
FROM
    film
WHERE
    language_id IN (SELECT 
            language_id
        FROM
            language
        WHERE
            name = 'English')
        AND title LIKE 'K%'
        OR title LIKE 'Q%';

-- 7b 
SELECT 
    first_name, last_name
FROM
    actor
WHERE
    actor_id IN (SELECT 
            actor_id
        FROM
            film_actor
        WHERE
            film_id IN (SELECT 
                    film_id
                FROM
                    film
                WHERE
                    title = 'Alone Trip'));

-- 7c
SELECT 
    customer.first_name, customer.last_name, customer.email
FROM
    customer
        LEFT JOIN
    address ON customer.address_id = address.address_id
        LEFT JOIN
    city ON address.city_id = city.city_id
        LEFT JOIN
    country ON city.country_id = country.country_id
WHERE
    country = 'Canada';

-- 7d 
SELECT 
    film.title
FROM
    film
        LEFT JOIN
    film_category ON film_category.film_id = film.film_id
        LEFT JOIN
    category ON category.category_id = film_category.category_id
WHERE
    name = 'Family';

-- 7e 
SELECT 
    title, COUNT(rental_id) AS 'Number of Rentals'
FROM
    film
        LEFT JOIN
    inventory ON inventory.film_id = film.film_id
        LEFT JOIN
    rental ON rental.inventory_id = inventory.inventory_id
GROUP BY title
ORDER BY `Number of Rentals` DESC;
    
-- 7f 
SELECT 
    staff_id AS Store, SUM(amount) AS Total
FROM
    payment
GROUP BY staff_id;
    
-- 7g 
	SELECT 
    store.store_id, city.city, country.country
FROM
    store
        LEFT JOIN
    address ON address.address_id = store.address_id
        LEFT JOIN
    city ON city.city_id = address.city_id
        LEFT JOIN
    country ON country.country_id = city.country_id;
    
-- 7h 
SELECT 
    category.name, SUM(amount) AS 'Gross Revenue'
FROM
    category
        LEFT JOIN
    film_category ON film_category.category_id = category.category_id
        LEFT JOIN
    inventory ON inventory.film_id = film_category.film_id
        LEFT JOIN
    rental ON rental.inventory_id = inventory.inventory_id
        LEFT JOIN
    payment ON payment.rental_id = rental.rental_id
GROUP BY name
ORDER BY `Gross Revenue` DESC
LIMIT 5;

-- 8a
CREATE VIEW `Top 5 Gross Revenue` AS
    SELECT 
        category.name, SUM(amount) AS 'Gross Revenue'
    FROM
        category
            LEFT JOIN
        film_category ON film_category.category_id = category.category_id
            LEFT JOIN
        inventory ON inventory.film_id = film_category.film_id
            LEFT JOIN
        rental ON rental.inventory_id = inventory.inventory_id
            LEFT JOIN
        payment ON payment.rental_id = rental.rental_id
    GROUP BY name
    ORDER BY `Gross Revenue` DESC
    LIMIT 5;

-- 8b
SELECT 
    *
FROM
    `Top 5 Gross Revenue`;

-- 8c
drop view `Top 5 Gross Revenue`;