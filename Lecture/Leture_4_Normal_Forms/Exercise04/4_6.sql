SELECT customer_id, customer_name 
FROM customer 
WHERE customer_id = (
    SELECT customer_id FROM ordert 
    GROUP BY customer_id 
    ORDER BY COUNT(*) DESC 
    LIMIT 1
);
