select postal_code,count(customer_name) as customer_numbers
from customer
group by postal_code having count(customer_name) > 1
order by customer_numbers desc;
