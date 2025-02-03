-- REQUIREMENT 3
-- After login, the system shall allow the registered user to reserve up to 3 tables by
-- specifying the date and the preferred restaurant. The restaurant list is also provided
-- to the user. A restaurant information includes the name, address, telephone number, and open-close time
CREATE OR REPLACE FUNCTION get_available_restaurant(input_time TIMESTAMP)
  RETURNS SETOF restaurant
  LANGUAGE plpgsql
AS $$
BEGIN
  RETURN QUERY
  SELECT * FROM restaurant
  WHERE is_restaurant_available(restaurant_id, input_time);
END; $$;

-- RESERVE TABLE
CREATE OR REPLACE PROCEDURE reserve_table_by_id(input_user_email VARCHAR, restaurant_id INT, table_code VARCHAR, reservation_time TIMESTAMP, person_count int)
  LANGUAGE plpgsql
AS $$
BEGIN
  IF (SELECT COUNT(*) FROM reservation
    WHERE user_email = input_user_email AND reserve_time >= now()
    AND (approval_status = 'pending' OR approval_status = 'approved')
  ) >= 3 THEN
    RAISE EXCEPTION 'reservation limit reached';
    RETURN;
  END IF;
  INSERT INTO reservation(user_email, restaurant_id,table_code, reserve_time, person_count)
  VALUES (input_user_email, restaurant_id, table_code, reservation_time, person_count);
END; $$;

CREATE OR REPLACE PROCEDURE reserve_table_by_name_location(input_user_email VARCHAR, restaurant_name VARCHAR, restaurant_location VARCHAR, table_code VARCHAR, reservation_time TIMESTAMP, person_count int)
LANGUAGE plpgsql
AS $$
DECLARE
  restaurant_id int;
BEGIN
  SELECT * FROM get_restaurant_id(restaurant_name, restaurant_location) INTO restaurant_id;
  CALL reserve_table_by_id(input_user_email, restaurant_id, table_code, reservation_time, person_count);
END; $$;


-- REQUIREMENT 4
-- The system shall allow the registered user to view his/her restaurant reservation.
CREATE OR REPLACE FUNCTION get_user_reservation(input_user_email VARCHAR)
  RETURNS TABLE(
    restaurant_name VARCHAR, restaurant_location VARCHAR, table_code VARCHAR,
    reserve_time TIMESTAMP, person_count SMALLINT,
    approval_status reservation_approval_status, payment_status BOOLEAN, reserved_on TIMESTAMP)
  LANGUAGE plpgsql
AS $$
BEGIN
  RETURN QUERY
  SELECT
    name AS restaurant_name, location AS restaurant_location, A.table_code,
    A.reserve_time, A.person_count,
    A.approval_status, A.payment_status, A.reserved_on
  FROM reservation A JOIN restaurant USING(restaurant_id)
  WHERE user_email = input_user_email
  ORDER BY reserve_time DESC;
END; $$;

-- REQUIREMENT 7
-- The system shall allow the admin to view any restaurant reservation.
CREATE OR REPLACE FUNCTION get_restaurant_reservation(user_email VARCHAR, restaurant_name VARCHAR, restaurant_location VARCHAR)
  RETURNS SETOF reservation
  LANGUAGE plpgsql
AS $$
DECLARE
  local_restaurant_id int;
BEGIN
  SELECT * FROM get_restaurant_id(restaurant_name, restaurant_location) INTO local_restaurant_id;
  CALL valid_admin_chkerr(user_email,local_restaurant_id);
  RETURN QUERY
  SELECT * FROM reservation
  WHERE restaurant_id = local_restaurant_id
  ORDER BY reserve_time DESC;
END; $$;

-- TODO
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


-- HELPER FUNCTION
CREATE OR REPLACE FUNCTION get_available_restaurant_table(input_restaurant_id int, input_time TIMESTAMP)
  RETURNS SETOF table_info
  LANGUAGE plpgsql
AS $$
BEGIN
  RETURN QUERY
  SELECT * FROM table_info
  WHERE restaurant_id = input_restaurant_id
  AND is_table_available(input_restaurant_id, table_code, input_time) = TRUE;
END; $$;

CREATE OR REPLACE FUNCTION is_restaurant_available(input_restaurant_id int, input_time TIMESTAMP)
  RETURNS BOOLEAN
  LANGUAGE plpgsql
AS $$
BEGIN
  RETURN(
    SELECT table_code FROM table_info
    WHERE restaurant_id = input_restaurant_id
    AND is_table_available(input_restaurant_id, table_code, input_time)
  ) IS NOT NULL;
END; $$;

CREATE OR REPLACE FUNCTION is_table_available(input_restaurant_id int, input_table_code VARCHAR, input_time TIMESTAMP)
  RETURNS BOOLEAN
  LANGUAGE plpgsql
AS $$
BEGIN
  RETURN (
    SELECT reserve_time FROM reservation
    WHERE restaurant_id = input_restaurant_id AND table_code = input_table_code
    AND input_time - reserve_time <= '1 hour' AND input_time - reserve_time >= '-1 hour'
  ) IS NULL;
END; $$;