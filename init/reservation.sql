-- REQUIREMENT 3.1
-- After login, the system shall allow the registered user to reserve up to 3 tables by
-- specifying the date and the preferred restaurant.

CREATE OR REPLACE PROCEDURE reserve_table(user_email VARCHAR, restaurant_id INT, reservation_date DATE, table_id INT)
  LANGUAGE plpgsql
AS $$
BEGIN
IF (SELECT COUNT(*) FROM user_account WHERE email = owner_email) IS NULL THEN
  RAISE EXCEPTION 'user_email does not exist';
END IF;
INSERT INTO restaurant(name, phone, open_time, close_time, location)
  VALUES (name, phone, open_time, close_time, location)
  RETURNING restaurant_id
INTO restaurant_gen_id;
INSERT INTO restaurant_admin(email, restaurant_id)
  VALUES (owner_email, restaurant_gen_id);
END; $$
