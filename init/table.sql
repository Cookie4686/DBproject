-- CREATE TABLE
CREATE OR REPLACE PROCEDURE create_table_by_id(user_email VARCHAR, restaurant_id int, table_code VARCHAR, capacity int, average_time int)
  LANGUAGE plpgsql
AS $$
BEGIN
  CALL valid_owner_chkerr(user_email, restaurant_id);
  INSERT INTO table_info(restaurant_id, table_code, capacity, average_time)
  VALUES (restaurant_id, table_code, capacity, average_time);
END; $$;

CREATE OR REPLACE PROCEDURE create_table_by_name_location(user_email VARCHAR, input_name VARCHAR, input_location VARCHAR, table_code VARCHAR, capacity int, average_time int)
  LANGUAGE plpgsql
AS $$
DECLARE
  restaurant_id int;
BEGIN
  SELECT * FROM get_restaurant_id(input_name, input_location) INTO restaurant_id;
  CALL create_table_by_id(user_email,restaurant_id, table_code, capacity, average_time);
END; $$;