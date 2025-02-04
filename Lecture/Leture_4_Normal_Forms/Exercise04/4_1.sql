-- 4.1 แสดงจำนวนลูกค้าแยกตาม postal_code โดยเรียงตามจำนวน customers จากมากไปนอย
select postal_code,count(customer_name) as customer_numbers
from customer
group by postal_code
order by customer_numbers desc;
