select o.order_id, o.order_date
from customer c natural join ordert o
where c.customer_id = 10001;
