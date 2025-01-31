INSERT INTO user_account(email,firstname,lastname,phone,password,role)
VALUES 
  ('test1@email.com', 'Adam', 'Smith', '0331029302', 'adamcool', 'admin'),
  ('test2@email.com', 'David', 'Ricardo', '0331029303', 'davidcool', 'customer'),
  ('test3@email.com', 'John', 'Keynes', '0331029304', 'johncool', 'customer'),
  ('test4@email.com', 'Joe', 'Dart', '0331029305', 'joecool', 'customer');

INSERT INTO restaurant(name, phone, open_time, close_time, location)
VALUES
  ('Today Noodle', '0331029302', '05:00:00','22:00:00','Engineering Faculty, Chula'),
  ('StickChick', '0331029306', '05:00:00','22:00:00','Engineering Faculty, Chula');

INSERT INTO restaurant_admin(restaurant_id, email)
VALUES
  (1,'test1@email.com');