/* câu 8:
tỷ lệ giao dịch thất bại của từng kênh là bao nhiêu phần trăm? kênh nào
đáng lo nhất? */

select 
    c.channel_name
    , count(*) as total_transactions
    , count(*) filter (where t.status = 'FAILED') as total_failed
    , round(
        100.0 * count(*) filter (where t.status = 'FAILED') 
        / count(*)
        , 2
    ) as fail_rate
    , round(
        100.0 * count(*) filter (where t.status = 'FAILED' and t.destination_account_id is not null) 
        / count(*)
        , 2
    ) as fail_transfer_rate
    , round(
        100.0 * count(*) filter (where t.status = 'FAILED' and t.destination_account_id is null) 
        / count(*)
        , 2
    ) as fail_receiving_rate
    , round(
        100.0 * count(*) filter (where t.status = 'FAILED' and t.failure_reason = 'LOI_HE_THONG_NGAN_HANG') 
        / count(*)
        , 2
    ) as fail_system_rate
    , round(
        100.0 * count(*) filter (where t.status = 'FAILED' and t.failure_reason = 'KHONG_DU_SO_DU') 
        / count(*)
        , 2
    ) as fail_insufficient_funds_rate
    , round(
        100.0 * count(*) filter (where t.status = 'FAILED' and t.failure_reason = 'VUOT_HAN_MUC') 
        / count(*)
        , 2
    ) as fail_limit_exceeded_rate
from transactions t 
join channels c on t.channel_id = c.channel_id
group by 1
order by fail_rate desc

/*
 Tỷ lệ fail giữa các kênh giao dịch phân bổ khá đều và không chênh nhau quá lớn. Ngoài các lỗi như vượt
qua hạn mức, số dư không đủ thì lỗi do hệ thống ngân hàng cũng có tỷ lệ tương đương, nhưng lỗi này
lại gây khó chịu và có khả năng khiến khách hàng rời bỏ cao nhất nên chú ý các lỗi hệ thống này và cố 
gắng khắc phục (nếu có thể).
Dựa vào bản chất vận hành và nhu cầu sử dụng, kỳ vọng của người dùng khi sử dụng các kênh thì cần chú ý
theo thứ tự các kênh sau:
1. VCB Digibank Mobile: do nhu cầu thanh toán, chuyển khoản gần như là ngay lập tức, app lỗi sẽ gây 
ức chế hơn khi phải chờ đợi tại quầy.
2. POS the Vietcombank: máy pos lỗi ảnh hưởng đến trải nghiêm trọng đến trải nghiệm mua sắm, tính tiện dụng
vốn của có của phương pháp, gây ảnh hưởng trực tiếp đến doanh nghiệp đối tác và tạo rào cản tâm lý cho khách 
hàng khi sử dụng tiếp dịch vụ của ngân hàng
3. ATM Vietcombank: Gây bức xúc cục bộ (đặc biệt vào dịp lễ/tết khi nhu cầu rút tiền mặt cao).
4. VCB Digibank Web: Khách hàng chủ yếu là doanh nghiệp (chuyển tiền lương/lô lớn) hoặc người dùng PC, dễ dàng
 có phương án back-up.
 5. Quầy giao dich: Giao dịch viên có thể xử lý thủ công, hẹn khách hoặc chuyển đổi trạng thái nội bộ mà khách 
 hàng không nhận ra ngay lập tức.
 */



