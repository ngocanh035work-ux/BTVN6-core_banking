/* Câu 6: 
 * Ngân hàng đang có bao nhiêu khách hàng ở mỗi phân khúc
(customer_segment)? Sắp xếp giảm dần theo số lượng.*/

select 
	customer_segment 
	, count(distinct customer_id) as count_customers
from customers 
group by 1
order by 2 desc