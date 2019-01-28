USE sakila;

/*1a*/
SELECT first_name, last_name FROM actor;

/*1b*/
SELECT CONCAT(UPPER(first_name), ' ', UPPER(last_name)) AS 'Actor Name' FROM actor;

/*2a*/
SELECT actor_id, first_name, last_name FROM actor WHERE first_name = 'Joe';

/*2b*/
SELECT * FROM actor WHERE last_name LIKE '%gen%';

/*2c*/
SELECT * FROM actor WHERE last_name LIKE '%li%' ORDER BY first_name, last_name;

/*2d*/
SELECT country_id, country FROM country WHERE country IN ('Afghanistan', 'Bangladesh','China');

/*3a*/
ALTER TABLE actor ADD description BLOB;

/*3b*/
ALTER TABLE actor DROP COLUMN description;

/*4a*/
SELECT last_name, COUNT(last_name) as 'Number of Actors with Last Name' FROM actor GROUP BY last_name;

/*4b*/
SELECT last_name, COUNT(last_name) as 'Number of Actors with Last Name' FROM actor GROUP BY last_name HAVING COUNT(last_name) > 1;

/*4c*/
UPDATE actor SET first_name = 'HARPO' WHERE first_name = 'GROUCHO' AND last_name= 'WILLIAMS';

/*4d*/
UPDATE actor SET first_name = 'GROUCHO' WHERE first_name = 'HARPO';

/*5a*/
SHOW CREATE TABLE address;

/*6a*/
SELECT staff.first_name, staff.last_name, address.address 
FROM address
JOIN staff 
ON address.address_id=staff.address_id;

/*6b*/
SELECT staff.first_name, staff.last_name, SUM(payment.amount) as 'Amount Sold in August 2005'
FROM staff
JOIN payment 
ON staff.staff_id=payment.staff_id
WHERE payment_date 
LIKE '2005-08%'
GROUP BY staff.first_name, staff.last_name;

/*6c*/
SELECT film.title, COUNT(film_actor.actor_id) AS 'Number of Actors'
FROM film
INNER JOIN film_actor 
ON film.film_id = film_actor.film_id
GROUP BY film.title;

/*6d*/
SELECT COUNT(*) AS 'Copies of Hunchback Impossible' FROM inventory WHERE film_id IN 
(
	SELECT film_id 
    FROM film
    WHERE title = 'Hunchback Impossible'
);

/*6e*/
SELECT customer.first_name, customer.last_name, SUM(payment.amount) as 'Total Amount Paid'
FROM payment
JOIN customer
ON customer.customer_id=payment.customer_id
GROUP BY customer.first_name, customer.last_name
ORDER BY customer.last_name;

/*7a*/
SELECT title FROM film WHERE (title LIKE 'K%' OR title LIKE 'Q%') AND language_id IN
(
	SELECT language_id 
    FROM language
    WHERE name='English'
);

/*7b*/
SELECT CONCAT(first_name, ' ', last_name) AS 'Actors in Alone Trip' FROM actor WHERE actor_id IN 
(
	SELECT actor_id FROM film_actor WHERE film_id IN
    (	
		SELECT film_id FROM film WHERE title = 'Alone Trip'
	)
);

/*7c*/
SELECT first_name, last_name, email FROM customer WHERE address_id IN 
(
	SELECT address_id FROM address WHERE city_id IN
    (
		SELECT city_id FROM city WHERE country_id IN
        (
			SELECT country_id FROM country WHERE country = 'Canada'
		)
	)
);

/*7d*/
SELECT title AS 'Family Films' FROM film WHERE film_id IN
(
	SELECT film_id FROM film_category WHERE category_id IN
    (
		SELECT category_id FROM category WHERE name = 'Family'
	)
);

/*7e*/
SELECT film.title, COUNT(rental.rental_id) AS 'Number of Time Rented' 
FROM ((film INNER JOIN inventory ON film.film_id = inventory.film_id) 
INNER JOIN rental ON inventory.inventory_id = rental.inventory_id)
GROUP BY film.title
ORDER BY COUNT(rental.rental_id) DESC;

/*7f*/
SELECT store.store_id, SUM(payment.amount) AS 'Total Store Business' 
FROM ((payment INNER JOIN customer ON payment.customer_id = customer.customer_id) 
INNER JOIN store ON customer.store_id = store.store_id)
GROUP BY store.store_id;

/*7g*/
SELECT store.store_id, city.city AS 'City', country.country AS 'Country' 
FROM (((store INNER JOIN address ON store.address_id = address.address_id) 
INNER JOIN city ON address.city_id = city.city_id) 
INNER JOIN country ON city.country_id=country.country_id)
GROUP BY store.store_id;

/*7h*/
SELECT category.name AS 'Genre', SUM(payment.amount) AS 'Total Revenue Grossed' FROM
((((payment INNER JOIN rental ON payment.rental_id = rental.rental_id) 
INNER JOIN inventory ON rental.inventory_id = inventory.inventory_id) 
INNER JOIN film_category ON inventory.film_id = film_category.film_id)
INNER JOIN category ON film_category.category_id = category.category_id)
GROUP BY category.name
ORDER BY SUM(payment.amount) DESC
LIMIT 5;

/*8a*/
CREATE VIEW Top_Genres AS 
SELECT category.name AS 'Genre', SUM(payment.amount) AS 'Total Revenue Grossed' FROM
((((payment INNER JOIN rental ON payment.rental_id = rental.rental_id) 
INNER JOIN inventory ON rental.inventory_id = inventory.inventory_id) 
INNER JOIN film_category ON inventory.film_id = film_category.film_id)
INNER JOIN category ON film_category.category_id = category.category_id)
GROUP BY category.name
ORDER BY SUM(payment.amount) DESC
LIMIT 5;

/*8b*/
SELECT * FROM Top_Genres;

/*8c*/
DROP VIEW Top_Genres;