INSERT INTO user_account(email,firstname,lastname,phone,password)
VALUES 
  ('test1@email.com', 'Adam', 'Smith', '0331009001', 'adamcool'),
  ('test2@email.com', 'David', 'Ricardo', '0331009002', 'davidcool'),
  ('test3@email.com', 'John', 'Keynes', '0331009003', 'johncool'),
  ('test4@email.com', 'Joe', 'Dart', '0331009004', 'joecool');

CALL create_restaurant('test1@email.com','MACROEAT','101','08:00:00','16:00:00','Engineering Faculty, Chula');
CALL create_restaurant('test4@email.com','Test','102','04:00:00','22:00:00','Engineering Faculty, Chula');
CALL create_restaurant('test1@email.com','Classic Chips','101','08:00:00','17:00:00','Engineering Faculty, Chula');