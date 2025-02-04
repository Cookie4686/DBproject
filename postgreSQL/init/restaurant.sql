-- GET RESTAURANT LIST
CREATE OR REPLACE FUNCTION get_restaurant(pageNumber int)
  RETURNS TABLE(name VARCHAR, location VARCHAR, phone VARCHAR, open_close_time TEXT)
  LANGUAGE plpgsql
AS $$
BEGIN
  RETURN QUERY
    SELECT R.name, R.location, R.phone, open_time || '-' || close_time AS open_close_time
    FROM restaurant R
    ORDER BY R.name
    OFFSET (pageNumber - 1) * 10
    LIMIT 10;
END; $$;

-- CREATE RESTAURANT
CREATE OR REPLACE PROCEDURE create_restaurant(user_email VARCHAR, name VARCHAR, phone VARCHAR, open_time TIME, close_time TIME, location VARCHAR)
  LANGUAGE plpgsql
AS $$
DECLARE
  restaurant_gen_id int;
BEGIN
INSERT INTO restaurant(name, phone, open_time, close_time, location, owner_email)
  VALUES (name, phone, open_time, close_time, location, user_email)
  RETURNING restaurant_id
INTO restaurant_gen_id;
INSERT INTO restaurant_admin(user_email, restaurant_id)
  VALUES (user_email, restaurant_gen_id);
END; $$;

-- ADD RESTAURANT
CREATE OR REPLACE PROCEDURE add_restaurant_admin_by_id(user_email VARCHAR, admin_email VARCHAR, restaurant_id INT)
  LANGUAGE plpgsql
AS $$
BEGIN
  CALL valid_owner_chkerr(user_email,restaurant_id);
  INSERT INTO restaurant_admin(user_email, restaurant_id)
  VALUES (admin_email, restaurant_id);
END; $$;

CREATE OR REPLACE PROCEDURE add_restaurant_admin_by_name_location(user_email VARCHAR, admin_email VARCHAR, restaurant_name VARCHAR, restaurant_location VARCHAR)
  LANGUAGE plpgsql
AS $$
DECLARE
  restaurant_id int;
BEGIN
  SELECT * FROM get_restaurant_id(restaurant_name, restaurant_location) INTO restaurant_id;
  CALL add_restaurant_admin_by_id(user_email, admin_email, restaurant_id);
END; $$;

-- HELPER FUNCTION
CREATE OR REPLACE FUNCTION get_restaurant_id(input_name VARCHAR, input_location VARCHAR)
  RETURNS int
  LANGUAGE plpgsql
AS $$
DECLARE
  restaurant_id int;
BEGIN
  SELECT R.restaurant_id FROM restaurant R
  WHERE name = input_name AND location = input_location
  INTO restaurant_id;
  IF restaurant_id IS NULL THEN
    RAISE EXCEPTION 'Invalid restaurant';
  ELSE
    RETURN restaurant_id;
  END IF;
END; $$;

-- HELPER PROCEDURE
CREATE OR REPLACE PROCEDURE valid_owner_chkerr(user_email VARCHAR, input_restaurant_id INT)
  LANGUAGE plpgsql
AS $$
BEGIN
  IF (
    SELECT restaurant_id FROM restaurant R
    WHERE owner_email = user_email AND restaurant_id = input_restaurant_id
  ) IS NULL THEN
    RAISE EXCEPTION 'user is not this restaurant owner';
  END IF;
END; $$;

CREATE OR REPLACE PROCEDURE valid_admin_chkerr(input_user_email VARCHAR, input_restaurant_id INT)
  LANGUAGE plpgsql
AS $$
BEGIN
  IF (
    SELECT user_email FROM restaurant_admin
    WHERE user_email = input_user_email AND restaurant_id = input_restaurant_id
  ) IS NULL THEN
    RAISE EXCEPTION 'user is not this restaurant admin';
  END IF;
END; $$;