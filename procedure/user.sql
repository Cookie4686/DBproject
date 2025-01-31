CREATE OR REPLACE PROCEDURE register_admin(name VARCHAR, phone VARCHAR, email VARCHAR, password VARCHAR)
  LANGUAGE plpgsql
AS $$
BEGIN
  INSERT INTO user_account(name, phone, email, password, role)
  VALUES (name, phone, email, password, 'admin');
END; $$
