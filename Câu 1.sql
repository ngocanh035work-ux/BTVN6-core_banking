--Viết SQL liệt kê tất cả khách hàng (customers) ở thành phố Hà Nội, sắp xếp theo
--created_at giảm dần.
--Hiển thị customer_code, full_name, city, customer_segment.
select  
	customer_code
	, full_name
	, city
	, customer_segment
from customers 
where city = 'Ha Noi'
order by created_at desc

