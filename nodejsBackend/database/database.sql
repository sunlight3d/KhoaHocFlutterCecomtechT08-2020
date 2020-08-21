CREATE DATABASE NodejsBackend;
USE NodejsBackend;
DROP TABLE User;
CREATE TABLE IF NOT EXISTS User(
	id INT AUTO_INCREMENT PRIMARY KEY,
	email VARCHAR(400) NOT NULL,
	password VARCHAR(400) NOT NULL,
	fullName VARCHAR(400) DEFAULT '',
	createdDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	expiredDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	tokenKey VARCHAR(400),
	role INT DEFAULT 1,	
	isActive INT,
	UNIQUE (email)	
);

CREATE TABLE IF NOT EXISTS Product(
	id INT AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(400) NOT NULL,
	url VARCHAR(400),
	year int DEFAULT 2000,
	price float DEFAULT 0.0,
	quantity int DEFAULT 0,
	UNIQUE (name)	
);
INSERT INTO Product(name, year, price, url, quantity)
VALUES('iphone 44', 2020, 120, 'https://upload.wikimedia.org/wikipedia/commons/0/0b/Cat_poster_1.jpg', 5);
Product(id: 1,
      name: 'iphone 44',
      year: 2020,
      price: 123,
      url: 'https://upload.wikimedia.org/wikipedia/commons/0/0b/Cat_poster_1.jpg',
      quantity: 5
  ),
  Product(id: 2,
      name: 'iphone 55',
      year: 2019,
      price: 1234,
      url: 'https://upload.wikimedia.org/wikipedia/commons/0/0b/Cat_poster_1.jpg',
      quantity: 66
  ),
  Product(id: 1,
      name: 'iphone 44',
      year: 2020,
      price: 123,
      url: 'https://upload.wikimedia.org/wikipedia/commons/0/0b/Cat_poster_1.jpg',
      quantity: 5
  ),
  Product(id: 2,
      name: 'iphone 55',
      year: 2019,
      price: 1234,
      url: 'https://upload.wikimedia.org/wikipedia/commons/0/0b/Cat_poster_1.jpg',
      quantity: 66
  ),
  Product(id: 1,
      name: 'iphone 44',
      year: 2020,
      price: 123,
      url: 'https://upload.wikimedia.org/wikipedia/commons/0/0b/Cat_poster_1.jpg',
      quantity: 5
  ),
  Product(id: 2,
      name: 'iphone 55',
      year: 2019,
      price: 1234,
      url: 'https://upload.wikimedia.org/wikipedia/commons/0/0b/Cat_poster_1.jpg',
      quantity: 66
  ),
  Product(id: 1,
      name: 'iphone 44',
      year: 2020,
      price: 123,
      url: 'https://upload.wikimedia.org/wikipedia/commons/0/0b/Cat_poster_1.jpg',
      quantity: 5
  ),
  Product(id: 2,
      name: 'iphone 55',
      year: 2019,
      price: 1234,
      url: 'https://upload.wikimedia.org/wikipedia/commons/0/0b/Cat_poster_1.jpg',
      quantity: 66
  ),
  Product(id: 1,
      name: 'iphone 44',
      year: 2020,
      price: 123,
      url: 'https://upload.wikimedia.org/wikipedia/commons/0/0b/Cat_poster_1.jpg',
      quantity: 5
  ),
  Product(id: 2,
      name: 'iphone 55',
      year: 2019,
      price: 1234,
      url: 'https://upload.wikimedia.org/wikipedia/commons/0/0b/Cat_poster_1.jpg',
      quantity: 66
  )