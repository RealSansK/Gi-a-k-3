
CREATE DATABASE IF NOT EXISTS schooll;
USE schooll;

CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,   -- luu SHA-256 hash
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO users (username, password)
VALUES ('admin', SHA2('123456', 256));

CREATE TABLE IF NOT EXISTS records (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    course VARCHAR(100) NOT NULL,
    fee DECIMAL(10,2) NOT NULL
);

INSERT INTO records (name, course, fee) VALUES
('Nguyen Van A', 'Java Web', 1500000),
('Tran Thi B', 'Database', 1200000),
('Le Van C', 'Network', 1000000);

SELECT * FROM users;
SELECT * FROM records;
