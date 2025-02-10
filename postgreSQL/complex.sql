DELETE FROM reservation;

CALL create_table_by_id('test1@email.com',1,'t1',2,20);
CALL create_table_by_id('test1@email.com',2,'t2',2,20);
CALL create_table_by_id('test4@email.com',3,'t3',2,20);

-- Change this to 1 week period when going to run
INSERT INTO RESERVATION(restaurant_id, reserve_time, approval_status, person_count, user_email,table_code)
VALUES
  (1, '2025-02-02 12:00:00', 'rejected', 2,  'test4@email.com','t1'),
  (1, '2025-02-03 15:00:00', 'rejected', 2,  'test4@email.com','t1'),
  (1, '2025-02-04 13:00:00', 'rejected', 2,  'test4@email.com','t1'),
  (1, '2025-02-04 19:00:00', 'approved', 2,  'test5@email.com','t1'),
  (2, '2025-02-04 16:00:00', 'approved', 3,  'test5@email.com','t2'),
  (2, '2025-02-04 17:25:00', 'canceled', 1,  'test5@email.com','t2'),
  (2, '2025-02-05 10:30:00', 'approved', 3,  'test4@email.com','t2'),
  (2, '2025-02-09 10:30:00', 'approved', 4,  'test5@email.com','t2'),
  (2, '2025-02-10 10:40:00', 'approved', 1,  'test4@email.com','t2'),
  (3, '2025-02-02 13:00:00', 'canceled', 2,  'test5@email.com','t3'),
  (3, '2025-02-03 13:00:00', 'rejected', 4,  'test5@email.com','t3'),
  (3, '2025-02-04 13:00:00', 'canceled', 2,  'test5@email.com','t3'),
  (3, '2025-02-06 13:00:00', 'approved', 5,  'test5@email.com','t3'),
  (3, '2025-02-08 13:00:00', 'approved', 2,  'test4@email.com','t3'),
  (3, '2025-02-10 13:00:00', 'approved', 1,  'test4@email.com','t3');

SELECT restaurant_id, reserve_time, approval_status FROM reservation;

SELECT firstname, lastname, canceled_count, rejected_count, approved_count, total_seat_served
FROM user_account JOIN (
  SELECT
    owner_email,
    COUNT(CASE WHEN approval_status = 'canceled' THEN 1 ELSE NULL END) AS canceled_count,
    COUNT(CASE WHEN approval_status = 'rejected' THEN 1 ELSE NULL END) AS rejected_count,
    COUNT(CASE WHEN approval_status = 'approved' THEN 1 ELSE NULL END) AS approved_count,
    SUM(CASE WHEN approval_status = 'approved' THEN person_count ELSE NULL END) AS total_seat_served
  FROM reservation JOIN restaurant R USING(restaurant_id)
  WHERE reserve_time < CURRENT_DATE AND reserve_time >= CURRENT_DATE - INTERVAL'7 days'
  GROUP BY owner_email
) ceo_flex
ON user_email = owner_email
ORDER BY total_seat_served DESC;