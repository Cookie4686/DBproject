-- REQUIREMENT 3.2 The restaurant list is also provided to the user.
-- A restaurant information includes the name, address, telephone number, and open-close time.
CREATE OR REPLACE FUNCTION get_restaurant_list(pageNumber int)
  RETURNS TABLE(name VARCHAR, location VARCHAR, phone VARCHAR, available_time TEXT)
  LANGUAGE plpgsql
AS $$
BEGIN
  RETURN QUERY
    SELECT R.name, R.location, R.phone, open_time || '-' || close_time AS available_time FROM restaurant R
    ORDER BY R.name
    OFFSET (pageNumber - 1) * 10
    LIMIT 10;
END; $$;


-- USER CREATE RESTAURANT
CREATE OR REPLACE PROCEDURE create_restaurant(user_email VARCHAR, name VARCHAR, phone VARCHAR, open_time TIME, close_time TIME, location VARCHAR)
  LANGUAGE plpgsql
AS $$
DECLARE
  restaurant_gen_id int;
BEGIN
INSERT INTO restaurant(name, phone, open_time, close_time, location, owner_email)
  VALUES (name, phone, open_time, close_time, location, user_email)
  RETURNING id
INTO restaurant_gen_id;
INSERT INTO restaurant_admin(admin_email, restaurant_id)
  VALUES (user_email, restaurant_gen_id);
END; $$;

-- USE ID
CREATE OR REPLACE PROCEDURE add_restaurant_admin_by_id(user_email VARCHAR, admin_email VARCHAR, restaurant_id INT)
  LANGUAGE plpgsql
AS $$
BEGIN
  CALL valid_owner_chkerr(user_email,restaurant_id);
  INSERT INTO restaurant_admin(admin_email, restaurant_id)
  VALUES (admin_email, restaurant_id);
END; $$;

-- USE NAME, LOCATION
CREATE OR REPLACE PROCEDURE add_restaurant_admin_by_name_location(user_email VARCHAR, admin_email VARCHAR, restaurant_name VARCHAR, restaurant_location VARCHAR)
  LANGUAGE plpgsql
AS $$
DECLARE
  restaurant_id int;
BEGIN
  SELECT id FROM restaurant
  WHERE name = restaurant_name AND location = restaurant_location
  INTO restaurant_id;
  IF restaurant_id IS NULL THEN
    RAISE EXCEPTION 'Invalid restaurant';
  END IF;
  CALL valid_owner_chkerr(user_email,restaurant_id);
  INSERT INTO restaurant_admin(admin_email, restaurant_id)
  VALUES (admin_email, restaurant_id);
END; $$;

CREATE OR REPLACE PROCEDURE valid_owner_chkerr(user_email VARCHAR, restaurant_id INT)
  LANGUAGE plpgsql
AS $$
BEGIN
  IF (
    SELECT id FROM restaurant
    WHERE owner_email = user_email AND id = restaurant_id
  ) IS NULL THEN
    RAISE EXCEPTION 'user is not this restaurant owner';
  END IF;
END; $$;