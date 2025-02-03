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
INSERT INTO restaurant_admin(admin_email, restaurant_id)
  VALUES (user_email, restaurant_gen_id);
END; $$;

-- ADD RESTAURANT
CREATE OR REPLACE PROCEDURE add_restaurant_admin_by_id(user_email VARCHAR, admin_email VARCHAR, restaurant_id INT)
  LANGUAGE plpgsql
AS $$
BEGIN
  CALL valid_owner_chkerr(user_email,restaurant_id);
  INSERT INTO restaurant_admin(admin_email, restaurant_id)
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

-- HELPER PROCEDURE
CREATE OR REPLACE PROCEDURE valid_owner_chkerr(user_email VARCHAR, restaurant_id INT)
  LANGUAGE plpgsql
AS $$
BEGIN
  IF (
    SELECT restaurant_id FROM restaurant
    WHERE owner_email = user_email AND id = restaurant_id
  ) IS NULL THEN
    RAISE EXCEPTION 'user is not this restaurant owner';
  END IF;
END; $$;

-- HELPER FUNCTION
CREATE OR REPLACE FUNCTION get_restaurant_id(input_name VARCHAR, input_location VARCHAR)
  RETURNS int
  LANGUAGE plpgsql
AS $$
DECLARE
  restaurant_id int;
BEGIN
  SELECT restaurant_id FROM restaurant
  WHERE name = input_name AND location = input_location
  INTO restaurant_id;
  IF restaurant_id IS NULL THEN
    RAISE EXCEPTION 'Invalid restaurant';
  ELSE
    RETURN restaurant_id;
  END IF;
END; $$;
