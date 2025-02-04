SELECT c.customer_id, c.customer_name, COUNT(o.order_id) AS order_count 
FROM customer c
LEFT JOIN ordert o ON c.customer_id = o.customer_id 
GROUP BY c.customer_id, c.customer_name 
ORDER BY order_count DESC;
