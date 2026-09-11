/*Câu 9:
Trong 30 ngày gần nhất, mỗi ngày có bao nhiêu giao dịch và tổng giá trị bao
nhiêu? (Chú ý: dùng đúng cột thời gian nghiệp vụ.)*/
with partitioned_data as (
select 
	cast(transaction_time as date) as transaction_date
	, count(t.transaction_reference ) as count_transaction
	, sum(amount) as total_amount
	, max(cast(transaction_time as date)) over() as max_transaction_date
from transactions t 
group by 1
)
select 
	transaction_date
	, count_transaction 
	, total_amount 
from partitioned_data
where (max_transaction_date- transaction_date) <= 30
order by 1 desc


