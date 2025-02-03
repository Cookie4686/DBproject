CREATE TABLE user_account(
      user_email VARCHAR(100) PRIMARY KEY,
      firstname VARCHAR(50) NOT NULL,
      lastname VARCHAR(50) NOT NULL,
      phone VARCHAR(10) NOT NULL,
      password VARCHAR(60) NOT NULL
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
      owner_email VARCHAR(100) REFERENCES user_account(user_email),
      UNIQUE(name, location)
);
CREATE TABLE restaurant_admin(
      restaurant_id SERIAL REFERENCES restaurant(restaurant_id),
      user_email VARCHAR(100) REFERENCES user_account(user_email),
      PRIMARY KEY(restaurant_id, user_email)
);
CREATE TABLE table_info(
      restaurant_id SERIAL REFERENCES restaurant(restaurant_id),
      table_code VARCHAR,
      capacity SMALLINT DEFAULT 0,
      average_time SMALLINT DEFAULT 0,
      PRIMARY KEY(restaurant_id, table_code)
);
CREATE TYPE reservation_approval_status AS ENUM('pending','canceled','rejected', 'approved');
CREATE TABLE reservation(
      user_email VARCHAR(100) REFERENCES user_account(user_email),
      restaurant_id SERIAL,
      table_code VARCHAR,
      reserve_time TIMESTAMP,
      person_count SMALLINT,
      approval_status reservation_approval_status DEFAULT 'pending',
      payment_status BOOLEAN DEFAULT FALSE,
      reserved_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
      PRIMARY KEY(user_email, restaurant_id, table_code, reserve_time),
      FOREIGN KEY(restaurant_id, table_code) REFERENCES table_info(restaurant_id, table_code)
);