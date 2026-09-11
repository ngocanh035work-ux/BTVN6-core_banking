--Câu 3 (JOIN, CTE, Window Function)
--Viết SQL liệt kê 20 giao dịch có amount cao nhất, kèm theo branch_name (join với
--branches qua branch_id). Hiển thị transaction_reference, amount, branch_name,
--transaction_time.

with rn_transaction as (
	select 
		transaction_reference
		, amount
		, branch_id
		, transaction_time
		, dense_rank() over(order by amount desc) as rank_amount
	from transactions
)
select 
	t.transaction_reference
	, t.amount
	, b.branch_name
	, t.transaction_time
from rn_transaction t
join branches b on b.branch_id = t.branch_id 
where t.rank_amount <= 20
order by 2 desc