CREATE TABLE user_account(
      email VARCHAR(100) PRIMARY KEY,
      firstname VARCHAR(50) NOT NULL,
      lastname VARCHAR(50) NOT NULL,
      phone VARCHAR(10) NOT NULL,
      password VARCHAR(60) NOT NULL
);
CREATE TABLE restaurant(
      id SERIAL PRIMARY KEY,
      name VARCHAR(100) NOT NULL,
      phone VARCHAR(10) NOT NULL,
      min_price INT,
      max_price INT,
      open_time TIME NOT NULL,
      close_time TIME NOT NULL,
      location VARCHAR(100),
      owner_email VARCHAR(100),
      UNIQUE(name, location),
      CONSTRAINT fk_user FOREIGN KEY(owner_email) REFERENCES user_account(email)
);
CREATE TABLE restaurant_admin(
      restaurant_id SERIAL,
      admin_email VARCHAR(100),
      PRIMARY KEY(restaurant_id, admin_email),
      CONSTRAINT fk_restaurant FOREIGN KEY(restaurant_id) REFERENCES restaurant(id),
      CONSTRAINT fk_user FOREIGN KEY(admin_email) REFERENCES user_account(email)
);
CREATE TABLE table_info(
      restaurant_id SERIAL,
      id SMALLSERIAL,
      capacity SMALLINT DEFAULT 0,
      average_time SMALLINT DEFAULT 0,
      PRIMARY KEY(restaurant_id, id),
      CONSTRAINT fk_restaurant FOREIGN KEY(restaurant_id) REFERENCES restaurant(id)
);
CREATE TYPE reservation_approval_status AS ENUM('pending','rejected', 'approved');
CREATE TABLE reservation(
      user_email VARCHAR(100),
      restaurant_id SERIAL,
      table_id SERIAL,
      reservation_date DATE NOT NULL,
      reservation_time TIME NOT NULL,
      amount SMALLINT,
      approval_status reservation_approval_status DEFAULT 'pending',
      payment_status BOOLEAN DEFAULT FALSE,
      PRIMARY KEY(user_email, restaurant_id, table_id),
      CONSTRAINT fk_user FOREIGN KEY(user_email) REFERENCES user_account(email),
      CONSTRAINT fk_table FOREIGN KEY(restaurant_id, table_id) REFERENCES table_info(restaurant_id, id)
);