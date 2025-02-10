-- REQUIREMENT 1
-- The system shall allow a user to register by specifying the name, telephone number, email, and password. 
CALL register_user('Adam', 'Smith', '0331009001', 'test1@email.com', 'adamcool');
CALL register_user('David', 'Ricardo', '0331009002', 'test2@email.com', 'davidcool');
CALL register_user('John', 'Keynes', '0331009003', 'test3@email.com', 'johncool');
CALL register_user('Joe', 'Dart', '0331009004', 'test4@email.com', 'joecool');
CALL register_user('Jake', 'Li', '0331009005', 'test5@email.com', 'jakecool');
SELECT * FROM user_account;

-- REQUIREMENT 2 ??
-- After registration, the user becomes a registered user, and the system shall allow the
-- user to log in to use the system by specifying the email and password.
-- The system shall allow a registered user to log out.
SELECT * FROM checkPassword('test5@email.com','jakecool');

-- REQUIREMENT FROM DESCRIPTION (currently supports only add)
-- the administrator can add, update, and delete the restaurant’s overall information, table’s information. An administrator can add as many restaurants as needed.
CALL create_restaurant('test1@email.com','MACROEAT','101','08:00:00','16:00:00','Engineering Faculty, Chula');
CALL create_restaurant('test1@email.com','Classic Chips','101','08:00:00','17:00:00','Engineering Faculty, Chula');
CALL create_restaurant('test4@email.com','Test','102','04:00:00','22:00:00','Engineering Faculty, Chula');

-- REQUIREMENT FROM DESCRIPTION (currently supports only browsing)
-- without login, a user can browse and search for a restaurant with the restaurant ’s name, area, rating, and type of food.
SELECT * FROM get_restaurant(1);

-- NOT IN REQUIREMENT BUT ADDED FOR FUN
CALL add_restaurant_admin_by_name_location('test1@email.com','test2@email.com','MACROEAT','Engineering Faculty, Chula');
CALL add_restaurant_admin_by_name_location('test1@email.com','test2@email.com','Classic Chips','Engineering Faculty, Chula');
CALL add_restaurant_admin_by_name_location('test4@email.com','test3@email.com','Test','Engineering Faculty, Chula');
SELECT * FROM restaurant_admin;

-- ADD TABLE TO RESTAURANT
CALL create_table_by_name_location('test1@email.com','MACROEAT','Engineering Faculty, Chula','2S1',2,20);
CALL create_table_by_name_location('test1@email.com','MACROEAT','Engineering Faculty, Chula','2S2',2,20);
CALL create_table_by_name_location('test1@email.com','MACROEAT','Engineering Faculty, Chula','4S1',4,35);
CALL create_table_by_name_location('test1@email.com','Classic Chips','Engineering Faculty, Chula','1S1',1,15);
SELECT * FROM table_info;

-- REQUIREMENT 3
-- After login, the system shall allow the registered user to reserve up to 3 tables by
-- specifying the date and the preferred restaurant. The restaurant list is also provided
-- to the user. A restaurant information includes the name, address, telephone number, and open-close time
CALL reserve_table_by_name_location('test1@email.com', 'MACROEAT','Engineering Faculty, Chula', '2S1', '2025-05-02 17:00:00', 2);
CALL reserve_table_by_name_location('test2@email.com', 'MACROEAT','Engineering Faculty, Chula', '4S1', '2025-05-02 16:30:00', 4);
SELECT * FROM reservation;

SELECT * FROM get_available_restaurant('2025-05-02 17:00:00');

-- REQUIREMENT 4,5,6
-- The system shall allow the registered user to view/edit/delete/ his/her restaurant reservation.
SELECT * FROM get_user_reservation('test2@email.com');
CALL edit_user_reservation('test2@email.com',1,'4S1','2025-05-02 16:30:00',1,'2S2','2025-05-02 16:30:00',2);
SELECT * FROM get_user_reservation('test2@email.com');
CALL delete_user_reservation('test2@email.com',1,'2S2','2025-05-02 16:30:00');
SELECT * FROM get_user_reservation('test2@email.com');

-- REQUIREMENT 7,8,9
-- The system shall allow the admin to view/edit/delete any restaurant reservation.
CALL reserve_table_by_name_location('test2@email.com', 'MACROEAT','Engineering Faculty, Chula', '2S1', '2025-05-02 18:30:00', 2);
SELECT * FROM get_restaurant_reservation('test1@email.com','MACROEAT','Engineering Faculty, Chula');
CALL edit_restaurant_reservation('test1@email.com', 'test2@email.com', 1, '2S1', '2025-05-02 18:30:00', 'approved');
SELECT * FROM get_restaurant_reservation('test2@email.com','MACROEAT','Engineering Faculty, Chula');
CALL delete_restaurant_reservation('test1@email.com', 'test2@email.com', 1, '2S1', '2025-05-02 18:30:00');
SELECT * FROM get_restaurant_reservation('test2@email.com','MACROEAT','Engineering Faculty, Chula');
