--Câu 4 (JOIN nhiều bảng + GROUP BY)
--Viết SQL tính tổng amount giao dịch thành công (status = 'SUCCESS') theo từng khách
--hàng, chỉ lấy giao dịch mà khách hàng đó là chủ tài khoản nguồn (source_account_id).
--Join qua transactions → accounts → customers. Hiển thị customer_code, full_name,
--tong_amount, sắp xếp giảm dần, lấy top 10.
select
	c.customer_code
	, c.full_name
	, sum(t.amount) as sum_amount
from transactions t 
join accounts a on a.account_id = t.source_account_id 
join customers c on a.customer_id = c.customer_id 
group by 1,2
order by 3 desc 
limit 10