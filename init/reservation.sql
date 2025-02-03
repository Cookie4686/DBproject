-- TODO
-- REQUIREMENT 3.1
-- After login, the system shall allow the registered user to reserve up to 3 tables by
-- specifying the date and the preferred restaurant.
-- REQUIREMENT 3.2 The restaurant list is also provided to the user.
-- A restaurant information includes the name, address, telephone number, and open-close time.
CREATE OR REPLACE FUNCTION get_available_restaurant_list(pageNumber int)
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
CREATE OR REPLACE FUNCTION get_available_restaurant_list(pageNumber int)
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

CREATE OR REPLACE PROCEDURE reserve_table(user_email VARCHAR, restaurant_id INT, table_id INT, reservation_time TIMESTAMP, person_count int)
  LANGUAGE plpgsql
AS $$
BEGIN
  INSERT INTO reservation(user_email, restaurant_id,table_id, time,person_count)
  VALUES (user_email, restaurant_id, table_id, reservation_time, person_count);
END; $$;

-- REQUIREMENT 4
-- The system shall allow the registered user to view his/her restaurant reservation.
CREATE OR REPLACE FUNCTION get_user_reservation(input_user_email VARCHAR)
  RETURNS TABLE(
    restaurant_name VARCHAR, restaurant_location VARCHAR, table_id int,
    reservation_time TIMESTAMP, person_count SMALLINT,
    approval_status reservation_approval_status, payment_status BOOLEAN, reserved_on TIMESTAMP)
  LANGUAGE plpgsql
AS $$
BEGIN
  RETURN QUERY
  SELECT
    name AS restaurant_name, location AS restaurant_location, A.table_id,
    A.time::timestamp AS reservation_time, A.person_count,
    A.approval_status, A.payment_status, A.reserved_on
  FROM reservation A JOIN restaurant B
  ON A.restaurant_id = B.id
  WHERE user_email = input_user_email
  ORDER BY time DESC;
END; $$;

-- REQUIREMENT 7
-- The system shall allow the admin to view any restaurant reservation.
CREATE OR REPLACE FUNCTION get_restaurant_reservation(user_email VARCHAR, input_restaurant_id int)
  RETURNS SETOF reservation
  LANGUAGE plpgsql
AS $$
BEGIN
  CALL valid_owner_chkerr(user_email,input_restaurant_id);
  RETURN QUERY
  SELECT * FROM reservation
  WHERE restaurant_id = input_restaurant_id
  ORDER BY time DESC;
END; $$;

-- REQUIREMENT 8
-- The system shall allow the admin to edit any restaurant reservation.
CREATE OR REPLACE PROCEDURE edit_restaurant_reservation(input_user_email VARCHAR, input_restaurant_id int, input_table_id int, input_reserve_time TIME, input_approval_status VARCHAR)
  LANGUAGE plpgsql
AS $$
BEGIN
  CALL valid_owner_chkerr(input_user_email,input_restaurant_id);
  UPDATE reservation 
  SET approval_status = input_approval_status
  WHERE user_email = input_user_email AND restaurant_id = input_restaurant_id AND table_id = input_table_id AND reserve_time = input_reserve_time;
END; $$;



-- REQUIREMENT 9
-- The system shall allow the admin to edit any restaurant reservation.


-- CREATE OR REPLACE FUNCTION restaurant_available_table(input_restaurant_id int, input_time TIMESTAMP)
-- RETURNS TABLE(name VARCHAR, location VARCHAR, phone VARCHAR, available_time TEXT)
--   LANGUAGE plpgsql
-- AS $$
-- BEGIN
--   RETURN QUERY
--     SELECT * FROM table_info
--     WHERE
--       SELECT * FROM table_info A JOIN reservation B
--       ON A.restaurant_id = B.restaurant_id
--       WHERE restaurant_id = input_restaurant_id;
-- END; $$;