CREATE TYPE user_role AS ENUM ('customer', 'admin');
CREATE TABLE user_account(
      email VARCHAR(100) PRIMARY KEY,
      firstname VARCHAR(50) NOT NULL,
      lastname VARCHAR(50) NOT NULL,
      phone VARCHAR(10) NOT NULL,
      password VARCHAR(60) NOT NULL,
      role user_role NOT NULL
);
CREATE TABLE restaurant(
      restaurant_id SERIAL PRIMARY KEY,
      name VARCHAR(100) NOT NULL,
      phone VARCHAR(10) NOT NULL,
      min_price INT,
      max_price INT,
      open_time TIME NOT NULL,
      close_time TIME NOT NULL,
      location VARCHAR(100)
);
CREATE TABLE table_info(
      restaurant_id SERIAL,
      table_id SERIAL,
      capacity SMALLINT DEFAULT 0,
      vacancy BOOLEAN DEFAULT TRUE,
      average_time SMALLINT DEFAULT 0,
      PRIMARY KEY(restaurant_id, table_id)
);