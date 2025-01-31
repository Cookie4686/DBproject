CREATE OR REPLACE PROCEDURE create_restaurant(user_email VARCHAR, name VARCHAR, phone VARCHAR, open_time TIME, close_time TIME, location VARCHAR)
  LANGUAGE plpgsql
AS $$
DECLARE
  restaurant_gen_id int;
BEGIN
IF (SELECT email FROM user_account WHERE email = user_email) IS NULL THEN
  RAISE EXCEPTION 'user email does not exist';
END IF;
INSERT INTO restaurant(name, phone, open_time, close_time, location)
  VALUES (name, phone, open_time, close_time, location)
  RETURNING id
INTO restaurant_gen_id;
INSERT INTO restaurant_admin(email, restaurant_id)
  VALUES (user_email, restaurant_gen_id);
END; $$

-- TODO
CREATE OR REPLACE PROCEDURE add_restaurant_admin(user_email VARCHAR, restaurant_id INT)
  LANGUAGE plpgsql
AS $$
BEGIN
  INSERT INTO restaurant_admin(email, restaurant_id)
  VALUES (user_email, restaurant_id);
END; $$

-- TODO
CREATE OR REPLACE PROCEDURE add_restaurant_table(email VARCHAR, restaurant_id INT)
  LANGUAGE plpgsql
AS $$
BEGIN
  CALL valid_admin_chkerr(email, restaurant_id);
  INSERT INTO restaurant_admin(email, restaurant_id)
  VALUES (email, restaurant_id);
END; $$;

CREATE OR REPLACE PROCEDURE valid_admin_chkerr(user_email VARCHAR, restaurant_id INT)
  LANGUAGE plpgsql
AS $$
BEGIN
  IF (
    SELECT email FROM restaurant_admin
    WHERE email = user_email AND restaurant_id = restaurant_id
  ) IS NULL THEN
    RAISE EXCEPTION 'user is not this restaurant admin';
  END IF;
END; $$;


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
