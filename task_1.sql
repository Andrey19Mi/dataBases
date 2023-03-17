CREATE DATABASE students_2;

CREATE TABLE student (
    record_book SERIAL,
    student_name VARCHAR(255) NOT NULL,
    surname VARCHAR(255) NOT NULL,
    num_group INT NOT NULL,
    avg_score NUMERIC(3,2),
    address VARCHAR(255),
    date_birth DATE,
    email VARCHAR(255) UNIQUE,
	PRIMARY KEY(record_book)
);

CREATE TABLE hobby (
    hobby_id SERIAL,
    hobby_name VARCHAR(255) NOT NULL,
    risk NUMERIC(3,2) NOT NULL CHECK (risk >= 0 AND risk <=1),
	PRIMARY KEY(hobby_id)
);

CREATE TABLE stud_hobby (
	stud_hobby_id SERIAL,
	record_book INT NOT NULL,
	hobby_id INT NOT NULL,
	date_start DATE NOT NULL,
	date_finish DATE,
	PRIMARY KEY(stud_hobby_id),
	FOREIGN KEY(record_book) REFERENCES student(record_book)
	ON DELETE CASCADE,
	FOREIGN KEY(hobby_id) REFERENCES hobby(hobby_id)
);

INSERT INTO student(student_name, surname, num_group, avg_score, address, date_birth, email)
VALUES ('Andrey', 'Udalov', 2255, 4.0, 'street_1, 14', '2002-11-19', 'email_1'),
('Moris', 'Vlasov', 2111, 3.0, 'street_2, 17', '2001-12-18', 'email_2'),
('Boris', 'Smirnov', 1111, 3.1, 'street_3, 21', '2004-01-21', 'email_3'),
('Alisa', 'Udalova', 4251, 5.0, 'street_1, 14', '2000-08-26', 'email_4'),
('Masha', 'Romanova', 3114, 4.9, 'street_2, 23', '2001-11-14', 'email_5'),
('Anton', 'Udalov', 3468, 4.8, 'street_3, 3', '2001-05-16', 'email_6'),
('Roma', 'Fet', 1211, 3.7, 'small_street_1, 14', '2002-06-06', 'email_7'),
('Kira', 'Sammers', 2271, 3.6, 'big_street_1, 43', '2002-11-19', 'email_8'),
('Yana', 'Vagner', 3211, 2.0, 'street_11, 12', '2001-10-20', 'email_9'),
('Gleb', 'Fet', 2255, 2.1, 'street_10, 30', '2002-12-30', 'email_10');

INSERT INTO hobby(hobby_name, risk)
VALUES ('football', 0.3),
('basketball', 0.3),
('skiing', 0.4),
('running', 0.2),
('painting', 0.01),
('danceing', 0.2),
('listening music', 0.01),
('reading', 0.3),
('rafting', 0.6),
('camping', 0.5);

INSERT INTO stud_hobby(record_book, hobby_id, date_start, date_finish)
VAlUES (1, 2, '2010-11-21', '2020-02-23'),
(2, 10, '2015-11-21', '2022-07-13'),
(2, 9, '2022-10-25', '2023-07-13'),
(3, 6, '2018-11-21', '2021-05-25'),
(4, 2, '2016-11-21', '2019-02-23'),
(5, 10, '2020-11-21', '2020-12-14'),
(6, 4, '2022-11-21', '2022-12-23'),
(7, 6, '2021-11-21', '2022-04-26'),
(8, 10, '2011-11-21', '2020-02-23'),
(9, 9, '2023-11-21', '2023-11-23'),
(10, 1, '2019-11-21', '2020-03-26'),
(1, 3, '2018-11-21', '2020-01-22');

SELECT *
FROM student;
SELECT *
FROM hobby;
SELECT *
FROM stud_hobby;
