--task1
DELETE FROM stud_hobby
WHERE record_book IN (
	SELECT record_book
	FROM student s
	WHERE s.date_birth IS NULL
	);

DELETE FROM student
WHERE date_birth IS NULL;



--task2
UPDATE student
SET date_birth = '01-01-1999'
WHERE date_birth IS NULL;

--task3
DELETE FROM stud_hobby
WHERE record_book = 21;

DELETE FROM student
WHERE record_book = 21;

--task4
WITH t AS (
	SELECT h.hobby_name, count(*)
	FROM student as s JOIN stud_hobby sh USING(record_book)
	JOIN hobby as h USING(hobby_id)
	GROUP BY h.hobby_name
	ORDER BY count DESC
	LIMIT 1
	)
UPDATE hobby AS h
SET risk = h.risk - 0.1
FROM t
WHERE h.hobby_name = t.hobby_name;

--task5
WITH t AS (
	SELECT s.record_book
	FROM student as s JOIN stud_hobby sh USING(record_book)
	JOIN hobby as h USING(hobby_id)
	WHERE sh.date_start IS NOT NULL AND sh.date_finish IS NULL
	GROUP BY s.record_book
	)
UPDATE student AS s
SET avg_score = s.avg_score + 0.01
FROM t
WHERE s.record_book = t.record_book;

--task6
WITH t AS (
	SELECT sh.stud_hobby_id
	FROM student as s JOIN stud_hobby sh USING(record_book)
	JOIN hobby as h USING(hobby_id)
	WHERE sh.date_finish IS NOT NULL
	)
DELETE FROM stud_hobby sh
USING t
WHERE sh.stud_hobby_id = t.stud_hobby_id;

--task7
INSERT INTO stud_hobby(record_book, hobby_id, date_start)
VALUES (4, 5, '11-15-2009');

--task8
WITH t AS (
	SELECT sh.record_book, sh.hobby_id, min(date_start)
    FROM stud_hobby sh
	GROUP BY sh.record_book, sh.hobby_id
    HAVING count(date_start) > 1
	)
DELETE FROM stud_hobby sh
USING t
WHERE sh.record_book = t.record_book AND sh.hobby_id = t.hobby_id 
	AND sh.date_start = t.min
	
--task9
UPDATE stud_hobby
SET hobby_id = 2
WHERE hobby_id = 1;

UPDATE stud_hobby
SET hobby_id = 4
WHERE hobby_id = 5;

--task10
INSERT INTO hobby(hobby_name, risk)
VALUES ('study', 1)

--task11
UPDATE stud_hobby sh
SET hobby_id = 11
FROM student s JOIN stud_hobby sh2 USING(record_book)
WHERE s.avg_score < 3.2 AND sh.stud_hobby_id = sh2.stud_hobby_id 
	AND sh.hobby_id IS NOT NULL;

INSERT INTO stud_hobby(record_book, hobby_id, date_start)
SELECT  s.record_book, 11, now()
FROM student s LEFT JOIN stud_hobby sh ON s.record_book = sh.record_book
WHERE sh.hobby_id IS NULL;

--task12
UPDATE student
SET num_group = 4
WHERE num_group != 4;

--task13
DELETE FROM stud_hobby
WHERE record_book = 2;

DELETE FROM student 
WHERE record_book = 2;

--task14
UPDATE student
SET avg_score = 5.0
WHERE record_book IN (
	SELECT record_book
	FROM stud_hobby sh 
	WHERE (sh.date_finish IS NULL AND sh.date_finish - current_date >= 3650)
		OR (sh.date_finish IS NOT NULL AND sh.date_finish - sh.date_start >= 3650)
	)

--task15
DELETE FROM stud_hobby
WHERE record_book IN (
	SELECT record_book
	FROM student as s JOIN stud_hobby sh USING(record_book)
	WHERE s.date_birth > sh.date_start
	)