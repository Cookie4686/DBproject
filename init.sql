CREATE TYPE user_role AS ENUM ('customer', 'admin');
CREATE TABLE user_account(
      email VARCHAR(100) PRIMARY KEY,
      firstname VARCHAR(50) NOT NULL,
      lastname VARCHAR(50) NOT NULL,
      phone VARCHAR(10) NOT NULL,
      password VARCHAR(60) NOT NULL,
      role user_role NOT NULL DEFAULT 'customer'
);
CREATE TABLE restaurant(
      restaurant_id SERIAL PRIMARY KEY,
      name VARCHAR(100) NOT NULL,
      phone VARCHAR(10) NOT NULL,
      min_price INT,
      max_price INT,
      open_time TIME NOT NULL,
      close_time TIME NOT NULL,
      location VARCHAR(100),
      UNIQUE(name, location)
);
CREATE TABLE restaurant_owner(
      restaurant_id SERIAL,
      email VARCHAR(100),
      PRIMARY KEY(restaurant_id, email),
      CONSTRAINT fk_restaurant FOREIGN KEY(restaurant_id) REFERENCES restaurant(restaurant_id),
      CONSTRAINT fk_user FOREIGN KEY(email) REFERENCES user_account(email)
);
CREATE TABLE restaurant_admin(
      restaurant_id SERIAL,
      email VARCHAR(100),
      PRIMARY KEY(restaurant_id, email)
);
CREATE TABLE table_info(
      restaurant_id SERIAL,
      table_id SMALLSERIAL,
      capacity SMALLINT DEFAULT 0,
      vacancy BOOLEAN DEFAULT TRUE,
      average_time SMALLINT DEFAULT 0,
      PRIMARY KEY(restaurant_id, table_id)
);
CREATE TYPE reservation_status AS ENUM('pending', 'on_payment', 'approved');
CREATE TABLE reservation(
      email VARCHAR(100),
      restaurant_id SERIAL,
      table_id SERIAL,
      reservation_date DATE NOT NULL,
      reservation_time TIME NOT NULL,
      amount SMALLINT,
      status reservation_status DEFAULT 'pending',
      PRIMARY KEY(email, restaurant_id, table_id),
      CONSTRAINT fk_user FOREIGN KEY(email) REFERENCES user_account(email),
      CONSTRAINT fk_table FOREIGN KEY(restaurant_id, table_id) REFERENCES table_info(restaurant_id, table_id)
);