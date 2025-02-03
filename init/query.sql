SELECT * FROM reservation;

SELECT * FROM table_info WHERE restaurant_id = 1;

CALL get_available_restaurant('2025-02-03 15:30');

CALL reserve_table('test3@email.com', 1, '2S1', '2025-02-03 15:30', 2);
CALL reserve_table('test3@email.com', 1, '2S2', '2025-02-03 15:30', 2);
CALL reserve_table('test3@email.com', 1, '2S1', '2025-02-03 16:45', 2);
CALL reserve_table('test3@email.com', 1, '2S2', '2025-02-03 17:00', 2);
CALL reserve_table('test2@email.com', 1, '4S1', '2025-02-03 15:00', 2);


SELECT * FROM get_available_restaurant_table(1,'2025-02-03 18:00:00');
SELECT * FROM is_table_available(1,'4S1','2025-02-04 22:59:59');

SELECT COUNT(*) FROM reservation
WHERE user_email = 'test3@email.com' AND reserve_time >= now()
AND (approval_status = 'pending' OR approval_status = 'approved');

SELECT * FROM restaurant;

SELECT * FROM table_info;

update reservation
SET approval_status = 'canceled'
WHERE reserve_time = '2025-02-07 00:00:00'
