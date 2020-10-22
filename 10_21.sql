-- INNER JOIN on the Actor and Film_Actor Table
SELECT actor.actor_id, first_name,last_name,film_id
FROM actor
INNER JOIN film_actor
ON actor.actor_id = film_actor.actor_id;

-- LEFT Join on the Actor and Film_Actor Table
SELECT actor.actor_id, first_name,last_name,film_id
FROM film_actor
LEFT JOIN actor
ON actor.actor_id = film_actor.actor_id
WHERE first_name IS NULL AND last_name IS NULL;

-- Join that will produce info about a customer 
-- From the country of Angola
SELECT customer.first_name,customer.last_name,customer.email,country
FROM customer
INNER JOIN address
ON customer.address_id = address.address_id
INNER JOIN city
ON address.city_id = city.city_id
INNER JOIN country 
ON city.country_id = country.country_id
WHERE country = 'Angola';

-- SubQuery Examples

-- Two queries split apart (which will become a subquery later)

-- Find a customer_id that has an amount 
-- Greater than 175 in total payments
SELECT customer_id
FROM payment
GROUP BY customer_id
HAVING SUM(amount) > 175
ORDER BY SUM(amount) DESC;

-- Find ALL customer info
SELECT *
FROM customer;

-- Subquery to find the 6 customers that have
-- A total amount of payments greater than 175

SELECT store_id,first_name,last_name
FROM customer
WHERE customer_id IN(
	SELECT customer_id
	FROM payment
	GROUP BY customer_id
	HAVING SUM(amount) > 175
	ORDER BY SUM(amount) DESC
);

-- Basic Subquery
-- Find all files with a language of 'English'
SELECT *
FROM film
WHERE language_id IN (
	SELECT language_id
	FROM language
	WHERE name = 'English'
);


--Homework 10/21

--1. List all customers who live in Texas (use JOINs)
SELECT first_name,last_name,district
FROM customer
JOIN address
ON address.address_id = customer.address_id
WHERE district = 'Texas';

--2. Get all payments above $6.99 with the Customer's Full Name
SELECT *
FROM payment

SELECT first_name,last_name,amount
FROM customer
JOIN payment
ON customer.customer_id = payment.customer_id
WHERE amount > 6.99
ORDER BY amount ASC;

--3 Show all customers names who have made payments over $175(use subqueries)
SELECT *
FROM customer

SELECT store_id,first_name,last_name
FROM customer
WHERE customer_id IN (
	SELECT customer_id
	FROM payment
	GROUP BY customer_id
	HAVING SUM(amount) > 175
	ORDER BY SUM(amount) DESC
);

-- 4 List all customers that live in Nepal (use the city
-- table)
SELECT *
FROM city

SELECT first_name,last_name,city
FROM customer
JOIN city
ON customer.customer_id = city.city_id
WHERE city = 'Nepal';

-- 5 Which staff member had the most
-- transactions?
SELECT *
FROM payment

SELECT staff_id, COUNT(staff_id)
FROM payment
GROUP BY staff_id
ORDER BY staff_id;

-- 6 How many movies of each rating are
-- there?

SELECT *
FROM film

SELECT rating, COUNT(rating)
FROM film
GROUP BY rating
ORDER BY rating ASC;

-- 7 Show all customers who have made a single payment
-- above $6.99 (Use Subqueries)
SELECT *
FROM customer

SELECT first_name,last_name
FROM customer
WHERE customer_id IN (
	SELECT customer_id
	FROM payment
	GROUP BY customer_id,amount
	HAVING amount > 6.99 
	ORDER BY amount DESC
);

-- 8 How many free rentals did our stores give away
SELECT *
FROM payment
WHERE amount = 0.00

SELECT *
FROM store

SELECT store_id,first_name,last_name,amount
FROM customer
JOIN payment
ON customer.customer_id = payment.customer_id
WHERE amount = 0.00
ORDER BY amount ASC;









	