/* Câu 7 :
 Top 10 chi nhánh có nhiều tài khoản ĐANG MỞ nhất. Hiển thị tên chi
nhánh, thành phố và số tài khoản.*/

select 
	b.branch_name
	, b.city 
	, count(distinct a.customer_id) as count_customers
	, count(distinct a.account_id ) as count_accounts
from accounts a
join branches b on a.branch_id = b.branch_id 
group by 1,2
order by 3 desc
limit 10