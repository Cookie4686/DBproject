-- REQUIREMENT 1
-- The system shall allow a user to register by specifying the name, telephone number, email, and password. 
CALL register_user('Jake', 'Li', '0331009005', 'test5@email.com', 'jakecool');
SELECT * FROM user_account;

-- REQUIREMENT 2 ??
-- After registration, the user becomes a registered user, and the system shall allow the
-- user to log in to use the system by specifying the email and password.
-- The system shall allow a registered user to log out.
SELECT * FROM checkPassword('test5@email.com','jakecool');

-- REQUIREMENT 3 (TODO)
-- After login, the system shall allow the registered user to reserve up to 3 tables by
-- specifying the date and the preferred restaurant. The restaurant list is also provided
-- to the user. A restaurant information includes the name, address, telephone number, and open-close time

-- REQUIREMENT 4
-- The system shall allow the registered user to view his/her restaurant reservation.
SELECT * FROM get_user_reservation('test5@email.com');