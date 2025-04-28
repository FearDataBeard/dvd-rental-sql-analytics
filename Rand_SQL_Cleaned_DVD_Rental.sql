------------------------DVDrental Database------------------------
------------------------PGAdmin v9.2 (POSTGRESQL)------------------------
--maintaining data integrity and confidentiality throguh data control and discipline
------------
--CORE BUSINESS QUERIES
------------
--Total customers, total active, total inactive customers
SELECT
store_id,
COUNT(*) AS total_customers,
COUNT(CASE WHEN activebool = true THEN 1 END) AS active_members,
COUNT(CASE WHEN activebool = false THEN 1 END) AS inactive_members
FROM customer
GROUP BY store_id;

--Search name WITH wild cards BEFORE and after
SELECT first_name, last_name, email
FROM customer
WHERE email like '%max%';

-- Top 5 customers by revenue
SELECT customer_id, SUM(amount) AS total_revenue
FROM payment
GROUP BY customer_id
ORDER BY total_revenue DESC
LIMIT 5;

-- total revenue by store
SELECT s.store_id, SUM(p.amount) AS total_revenue
FROM payment AS p
LEFT JOIN staff AS s ON s.staff_id = p.staff_id
GROUP BY store_id;

--advanced CTE/JOIN find the number 1 customer and their favorite category
--and THEN created INTO a VIEW
DROP MATERIALIZED VIEW IF EXISTS total_spending;
CREATE MATERIALIZED VIEW total_spending AS
WITH total_spending AS (
	SELECT customer_id,
	SUM(amount) AS total_spending
	FROM payment
	GROUP BY customer_id
),
top_customer AS(
	SELECT customer_id
	FROM total_spending
	ORDER BY total_spending DESC
	LIMIT 1
),
customer_categories AS(
	SELECT c.customer_id,
		ct.name AS category_name,
		COUNT(*) AS rental_count
	FROM customer AS c
	JOIN payment AS p ON c.customer_id = p.customer_id
	JOIN rental AS r ON p.rental_id = r.rental_id
	JOIN inventory AS i ON r.inventory_id = i.inventory_id
	JOIN film AS f ON i.film_id = f.film_id
	JOIN film_category AS fc ON f.film_id = fc.film_id
	JOIN category AS ct ON fc.category_id = ct.category_id
	WHERE c.customer_id = (SELECT c.customer_id FROM top_customer)
	GROUP BY c.customer_id, ct.name
)
SELECT customer_id, 
category_name,
rental_count
FROM customer_categories
ORDER BY rental_count DESC
LIMIT 1;

------------
--INDEXING SECTION
------------
--INDEX Total_spending
CREATE index idx_total_spending_rental_count
ON total_spending (rental_count DESC);

--Refresh MV and INDEX
refresh MATERIALIZED VIEW concurrently total_spending;

------------
--TRIGGERS SECTION
------------
-- CREATE TRIGGER FUNCTION with COMMIT
BEGIN;
CREATE or replace FUNCTION set_creation_date()
RETURNS TRIGGER AS $$
BEGIN
	NEW.creation_date := NOW();
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- DROP TRIGGER IF already EXISTS
DROP TRIGGER IF EXISTS before_customer_insert ON customer;
--CREATE NEW TRIGGER
CREATE TRIGGER before_customer_insert
BEFORE INSERT ON customer
FOR EACH ROW
EXECUTE FUNCTION set_creation_date();

COMMIT;

------------
--TESTING FIELD
------------
BEGIN;

DELETE FROM customer WHERE customer_id = 9999;

-- Imagine this was a mistake...
ROLLBACK;
-- or COMMIT;

------------
--DATA CONTROL (FAILSAFE OPTIONS)
------------
-- SAVE ACTION
BEGIN;
COMMIT;
-- RESTORE ACTION
ROLLBACK;


------------
--FINAL RESULTS SECTION
------------
-- Final result: Top category of the highest spending customer
SELECT * FROM total_spending;