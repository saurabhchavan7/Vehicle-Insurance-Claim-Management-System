use insurance;

-- Query 1: query to retrieve the details of all customers from the customer table:

SELECT 
    *
FROM
    customer;


-- Query 2: Calculate the average amount of disbursed claims.

SELECT 
    AVG(issued_amount) AS Average_Disbursed_Amount
FROM
    claim;
    
    
-- 	Query 3: This query will provide information about customers who have been involved in accidents, along with the details of the accidents.

SELECT 
    c.*, a.*
FROM
    customer c
        INNER JOIN
    accident a ON c.customer_id = a.customer_id;
    
    
-- Query 4: This query will provide information about customers who have purchased policies with a sum insured greater than the average sum insured.

SELECT customer_id, first_name, last_name
FROM customer
WHERE customer_id IN (
    SELECT pt.customer_id
    FROM PolicyTransactions pt
    JOIN policy p ON pt.policy_no = p.policy_no
    WHERE p.sum_insured > (
        SELECT AVG(sum_insured)
        FROM policy
    )
);


                    
-- Query 5: This correlated query will provide information about customers who have purchased multiple policies.

SELECT DISTINCT c.customer_id, c.first_name, c.last_name
FROM customer c
WHERE EXISTS (
    SELECT 1
    FROM PolicyTransactions pt1
    JOIN PolicyTransactions pt2 ON pt1.customer_id = pt2.customer_id AND pt1.policy_no <> pt2.policy_no
    WHERE pt1.customer_id = c.customer_id
);


-- Query 6: Using NOT EXISTS to find customers who have not purchased any policies.

SELECT c.customer_id, c.first_name, c.last_name
FROM customer c
WHERE NOT EXISTS (
    SELECT 1
    FROM PolicyTransactions pt
    WHERE pt.customer_id = c.customer_id
);

-- Query 7: This query retrieves the customer_id from the customer table along with the total number of accidents associated with each customer.

SELECT customer_id,
       (SELECT COUNT(*) FROM accident WHERE accident.customer_id = customer.customer_id) AS total_accidents
FROM customer;

-- Query 8: Using UNION to combine the results of two SELECT statements.

SELECT customer_id, first_name, last_name
FROM customer
UNION
SELECT a.customer_id, NULL AS first_name, NULL AS last_name
FROM accident a;






