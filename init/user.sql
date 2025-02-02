-- REQUIREMENT 01
-- The system shall allow a user to register by specifying the name, telephone number, email, and password
CREATE OR REPLACE PROCEDURE register_user(firstname VARCHAR,lastname VARCHAR, phone VARCHAR, email VARCHAR, password VARCHAR)
  LANGUAGE plpgsql
AS $$
BEGIN
  INSERT INTO user_account(firstname, lastname, phone, email, password)
  VALUES (firstname, lastname, phone, email, password);
END; $$;

-- REQUIREMENT 02
-- THIS MAY NOT BE NEEDED (seem like a software level requirements
-- for database just return encryptedpassword back for backend to compare)
-- After registration, the user becomes a registered user,
-- and the system shall allow the user to log in to use the system by
-- specifying the email and password. The system shall allow a registered user to log out.
CREATE OR REPLACE FUNCTION checkPassword(input_email VARCHAR, input_password VARCHAR)
  RETURNS BOOLEAN
  LANGUAGE plpgsql
AS $$
BEGIN
  IF (SELECT email FROM user_account WHERE email = input_email AND password = input_password) IS NULL THEN
    RETURN FALSE;
  ELSE
    RETURN TRUE;
  END IF;
END; $$;