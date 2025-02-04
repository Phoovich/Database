SELECT product_id, product_description 
FROM product 
WHERE product_id = (
    SELECT product_id FROM order_line 
    GROUP BY product_id 
    ORDER BY COUNT(*) DESC 
    LIMIT 1
);
