CREATE OR REPLACE PROCEDURE create_restaurant(email VARCHAR, name VARCHAR, phone VARCHAR, open_time TIME, close_time TIME, location VARCHAR)
  LANGUAGE plpgsql
AS $$
DECLARE
  restaurant_gen_id int;
BEGIN
CALL check_admin(email);
INSERT INTO restaurant(name, phone, open_time, close_time, location)
  VALUES (name, phone, open_time, close_time, location)
  RETURNING restaurant_id
INTO restaurant_gen_id;
INSERT INTO restaurant_admin(email, restaurant_id)
  VALUES (email, restaurant_gen_id);
END; $$

CREATE OR REPLACE PROCEDURE add_restaurant_admin(user_email VARCHAR, restaurant_id INT)
  LANGUAGE plpgsql
AS $$
BEGIN
  CALL check_admin(user_email);
  INSERT INTO restaurant_admin(email, restaurant_id)
  VALUES (user_email, restaurant_id);
END; $$

CREATE OR REPLACE PROCEDURE check_admin(user_email VARCHAR)
  LANGUAGE plpgsql
AS $$
BEGIN
  IF (SELECT email FROM user_account WHERE email = user_email AND role = 'admin') IS NULL THEN
    RAISE EXCEPTION 'user is not an admin';
  END IF;
END; $$