--Câu 5 (Self-join hoặc Window function)
--Với bảng transaction_status_history, viết SQL tìm những transaction_id có nhiều hơn 2
--lần đổi trạng thái.
--Với mỗi transaction_id đó, hiển thị chuỗi trạng thái theo thứ tự thời gian (old_status,
--new_status, event_time), sắp xếp theo transaction_id, event_time.
select 
	tsh.transaction_id 
	, tsh.old_status
	, tsh.new_status 
	, tsh.event_time
from transaction_status_history  tsh
join(
	select transaction_id
	from transaction_status_history 
	group by transaction_id
	having count(*)> 2
	) filter on filter.transaction_id = tsh.transaction_id
order by 1,4 asc