CREATE OR REPLACE PROCEDURE create_table_by_id(user_email VARCHAR, input_restaurant_id int, capacity int, average_time int)
  LANGUAGE plpgsql
AS $$
BEGIN
  CALL valid_owner_chkerr(user_email,input_restaurant_id);
  INSERT INTO table_info(restaurant_id, capacity, average_time)
  VALUES (input_restaurant_id, capacity, average_time);
END; $$;

CREATE OR REPLACE PROCEDURE create_table_by_name_location(user_email VARCHAR, restaurant_name VARCHAR, restaurant_location VARCHAR, capacity int, average_time int)
  LANGUAGE plpgsql
AS $$
DECLARE
  restaurant_id int;
BEGIN
  SELECT * FROM get_restaurant_id(restaurant_name, restaurant_location) INTO restaurant_id;
  CALL create_table_by_id(user_email,restaurant_id, capacity, average_time);
END; $$;