--Câu 2 (GROUP BY + COUNT)
--Viết SQL đếm số lượng giao dịch (transactions) theo từng status, sắp xếp giảm dần
--theo số lượng.
--Hiển thị status, so_luong.
select 
	status
	, count(*) as so_luong
from transactions 
group by 1
order by 2 desc