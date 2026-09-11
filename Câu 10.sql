/*Câu 10:
Top 5 ngành hàng (merchant_category) có tổng giá trị giao dịch thành công
lớn nhất.*/
select 
	m.merchant_category,
	sum(t.amount) filter (where t.status = 'SUCCESS' ) as total_amount
from transactions t 
join merchants m on m.merchant_id = t.merchant_id 
group by 1
order by 2 desc