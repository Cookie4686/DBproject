CALL register_user('Adam', 'Smith', '0331009001', 'test1@email.com', 'adamcool');
CALL register_user('David', 'Ricardo', '0331009002', 'test2@email.com', 'davidcool');
CALL register_user('John', 'Keynes', '0331009003', 'test3@email.com', 'johncool');
CALL register_user('Joe', 'Dart', '0331009004', 'test4@email.com', 'joecool');

CALL create_restaurant('test1@email.com','MACROEAT','101','08:00:00','16:00:00','Engineering Faculty, Chula');
CALL create_restaurant('test1@email.com','Classic Chips','101','08:00:00','17:00:00','Engineering Faculty, Chula');
CALL create_restaurant('test4@email.com','Test','102','04:00:00','22:00:00','Engineering Faculty, Chula');

CALL add_restaurant_admin_by_name_location('test1@email.com','test2@email.com','MACROEAT','Engineering Faculty, Chula');
CALL add_restaurant_admin_by_name_location('test1@email.com','test2@email.com','Classic Chips','Engineering Faculty, Chula');