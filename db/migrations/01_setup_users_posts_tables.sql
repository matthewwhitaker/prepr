CREATE TABLE users(id SERIAL PRIMARY KEY, email VARCHAR(60), username VARCHAR(100), password VARCHAR(140));
CREATE TABLE posts(id SERIAL PRIMARY KEY, body VARCHAR(280), title VARCHAR(100), user_id INT NOT NULL, CONSTRAINT fk_group FOREIGN KEY (user_id) REFERENCES users(id));
