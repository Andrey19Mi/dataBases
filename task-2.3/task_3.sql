SELECT s.*
FROM student s

SELECT sh.*
FROM stud_hobby sh

SELECT h.*
FROM hobby h

INSERT INTO hobby(hobby_name, risk)
VALUES('shooting', 0.95)

INSERT INTO stud_hobby(record_book, hobby_id, d)

SELECT t.*
FROM (student as s JOIN stud_hobby as s_h 
	ON s.record_book = s_h.record_book 
	JOIN hobby as h
	ON s_h.hobby_id = h.hobby_id) t

--task 1
SELECT s.student_name, s.surname, h.hobby_name
FROM student as s JOIN stud_hobby as s_h 
	ON s.record_book = s_h.record_book 
	JOIN hobby as h
	ON s_h.hobby_id = h.hobby_id

--task 2
SELECT s.*, h.hobby_name, t2.days
FROM student as s JOIN stud_hobby as s_h 
	ON s.record_book = s_h.record_book 
	JOIN hobby as h
	ON s_h.hobby_id = h.hobby_id,
	--max_count_days
	(SELECT MAX(t.days) as days
	FROM (SELECT s_h.stud_hobby_id,
		CASE
			WHEN (s_h.date_finish IS NULL) THEN current_date - s_h.date_start
			WHEN (s_h.date_finish IS NOT NULL) THEN s_h.date_finish - s_h.date_start
			END as days
		FROM stud_hobby s_h) t) t2
	--
WHERE s_h.date_finish - s_h.date_start = t2.days OR current_date - s_h.date_start = t2.days

--task 3
SELECT s.student_name, s.surname, s.record_book, s.date_birth
FROM student s,
	--avg_score_all_students
	--table t1, prop avg_sc
	(SELECT AVG(s.avg_score) as avg_sc
	FROM student s) t1,
	--sum_risks_for_students
	--table t2, prop sum_risk
	(SElECT s_h.record_book, SUM(h.risk) as sum_risk
	FROM student as s JOIN stud_hobby as s_h 
		ON s.record_book = s_h.record_book 
		JOIN hobby as h
		ON s_h.hobby_id = h.hobby_id
	GROUP BY s_h.record_book) t2
	
WHERE s.record_book = t2.record_book AND t2.sum_risk >= 0.9 AND s.avg_score >= t1.avg_sc

--task4

SELECT s.surname, s.student_name, s.record_book, s.date_birth, h.hobby_name, 
	 (sh.date_finish - sh.date_start)/30 as interv
FROM student as s JOIN stud_hobby as sh 
		ON s.record_book = sh.record_book 
		JOIN hobby as h
		ON sh.hobby_id = h.hobby_id
WHERE sh.date_finish IS NOT NULL
	
--task5
SELECT s.surname, s.student_name, s.record_book, s.date_birth
FROM student as s JOIN stud_hobby as sh 
		ON s.record_book = sh.record_book 
WHERE extract(year from age(s.date_birth)) >= 21 AND sh.date_finish IS NOT NULL

--task6
SELECT avg(avg_score), s.num_group
FROM student as s JOIN stud_hobby as sh 
		ON s.record_book = sh.record_book 
WHERE sh.date_finish IS NOT NULL
GROUP BY num_group

--task7
SELECT h.hobby_name, h.risk, (sh.date_finish - sh.date_start)/30 as interv,
	s.record_book
FROM student as s JOIN stud_hobby as sh 
		ON s.record_book = sh.record_book 
		JOIN hobby as h
		ON sh.hobby_id = h.hobby_id,
		(SELECT sh.date_finish - sh.date_start as max_t
		FROM stud_hobby sh
		WHERE sh.date_finish IS NOT NULL
		ORDER BY max_t DESC
		LIMIT 1) t
WHERE t.max_t = sh.date_finish - sh.date_start

--task8
SELECT h.hobby_name
FROM student as s JOIN stud_hobby as sh 
		ON s.record_book = sh.record_book 
		JOIN hobby as h
		ON sh.hobby_id = h.hobby_id,
		(SELECT s.avg_score as max_t
		FROM student s
		ORDER BY max_t DESC
		LIMIT 1) t
WHERE t.max_t = s.avg_score

--task9
SELECT h.hobby_name
FROM student as s JOIN stud_hobby as sh 
		ON s.record_book = sh.record_book 
		JOIN hobby as h
		ON sh.hobby_id = h.hobby_id
WHERE (s.avg_score between 2.5 and 3.5) AND s.num_group::text like '2%'

--task10
SELECT substr(s.num_group::text,1,1)
FROM student as s JOIN stud_hobby as sh 
		ON s.record_book = sh.record_book 
		JOIN hobby as h
		ON sh.hobby_id = h.hobby_id,
		(SELECT substr(s.num_group::text,1,1), COUNT(s.num_group)
		 FROM student as s JOIN stud_hobby as sh 
				ON s.record_book = sh.record_book 
		 WHERE sh.date_finish IS NOT NULL
		 GROUP BY substr(s.num_group::text,1,1)) t,
		(SELECT substr(s.num_group::text,1,1), COUNT(s.num_group)
		 FROM student s 
		 GROUP BY substr(s.num_group::text,1,1)) t2
WHERE t.substr = substr(s.num_group::text,1,1) AND t.substr = t2.substr AND t.count >= t2.count/2
GROUP BY substr(s.num_group::text,1,1)

--task11
SELECT s.num_group
FROM student s,
		(SELECT s.num_group, COUNT(s.num_group)
		 FROM student s
		 WHERE s.avg_score >= 4
		 GROUP BY num_group) t,
		(SELECT s.num_group, COUNT(s.num_group)
		 FROM student s
		 GROUP BY num_group) t2
WHERE t.num_group = t2.num_group AND t2.num_group = s.num_group AND t.count >= t2.count * 0.6
GROUP BY s.num_group

--task12
SELECT substr(s.num_group::text,1,1), COUNT(DISTINCT hobby_id) 
FROM student as s JOIN stud_hobby as sh 
		ON s.record_book = sh.record_book 
WHERE sh.date_finish IS NULL
GROUP BY substr(s.num_group::text,1,1)

--task13
SELECT s.record_book, s.surname, s.student_name, s.date_birth, substring(s.num_group::text, 1,1)
FROM student as s JOIN stud_hobby as sh 
		ON s.record_book = sh.record_book 
WHERE sh.date_finish IS NULL AND s.avg_score >= 4.5
ORDER BY s.num_group, s.date_birth DESC

--task14
CREATE VIEW abc AS
	SELECT *
	FROM student as s NATURAL JOIN stud_hobby as sh
		NATURAL JOIN hobby as h
	WHERE sh.date_finish IS NOT NULL AND (sh.date_finish - sh.date_start)/365 >= 5;
	
SELECT * FROM abc 
	
--task15
SELECT h.hobby_name, COUNT(s.record_book)
FROM student as s JOIN stud_hobby as sh 
		ON s.record_book = sh.record_book 
		JOIN hobby as h
		ON sh.hobby_id = h.hobby_id
GROUP BY h.hobby_name

--task16
SELECT h.hobby_id
FROM hobby h,
		(SELECT h.hobby_name, COUNT(s.record_book) as c
		FROM student as s JOIN stud_hobby as sh 
		ON s.record_book = sh.record_book 
		JOIN hobby as h
		ON sh.hobby_id = h.hobby_id
		GROUP BY h.hobby_name
		ORDER BY c DESC
		LIMIT 1) t
WHERE t.hobby_name = h.hobby_name
--task17
SELECT *
FROM student as s JOIN stud_hobby as sh 
		ON s.record_book = sh.record_book 
		JOIN hobby as h
		ON sh.hobby_id = h.hobby_id,
		(SELECT h.hobby_id
		FROM hobby h,
			(SELECT h.hobby_name, COUNT(s.record_book) as c
			FROM student as s JOIN stud_hobby as sh 
			ON s.record_book = sh.record_book 
			JOIN hobby as h
			ON sh.hobby_id = h.hobby_id
			GROUP BY h.hobby_name
			ORDER BY c DESC
			LIMIT 1) t
		WHERE t.hobby_name = h.hobby_name)t
WHERE t.hobby_id = h.hobby_id

--task18
SELECT h.hobby_id
FROM hobby h,
		(SELECT h.hobby_name, MAX(h.risk) as c
		FROM student as s JOIN stud_hobby as sh 
		ON s.record_book = sh.record_book 
		JOIN hobby as h
		ON sh.hobby_id = h.hobby_id
		GROUP BY h.hobby_name
		ORDER BY c DESC
		LIMIT 3) t
WHERE t.hobby_name = h.hobby_name

--task19
SELECT *,
	CASE
		WHEN (s_h.date_finish IS NULL) THEN current_date - s_h.date_start
		WHEN (s_h.date_finish IS NOT NULL) THEN s_h.date_finish - s_h.date_start
		END as days
FROM student as s JOIN stud_hobby as s_h 
	ON s.record_book = s_h.record_book 
	JOIN hobby as h
	ON s_h.hobby_id = h.hobby_id
ORDER BY days DESC
LIMIT 10
 
--task20
SELECT t.num_group
FROM 
	(SELECT *,
		CASE
			WHEN (s_h.date_finish IS NULL) THEN current_date - s_h.date_start
			WHEN (s_h.date_finish IS NOT NULL) THEN s_h.date_finish - s_h.date_start
			END as days
	FROM student as s JOIN stud_hobby as s_h 
		ON s.record_book = s_h.record_book 
		JOIN hobby as h
		ON s_h.hobby_id = h.hobby_id
	ORDER BY days DESC
	LIMIT 10) t
GROUP BY t.num_group 
--task21
CREATE VIEW abc2 AS
	SELECT s.record_book, s.student_name, s.surname
	FROM student s
	ORDER BY s.avg_score;
	
SELECT * FROM abc2

--task22
CREATE VIEW abc3 AS
	with t as (SELECT substr(s.num_group::text,1,1) as course, h.hobby_name,  COUNT(h.hobby_name)
		FROM student as s NATURAL JOIN stud_hobby as sh
		NATURAL JOIN hobby as h
		GROUP BY substr(s.num_group::text,1,1), h.hobby_name)

	SELECT t.course, t.hobby_name
	FROM  (SELECT t.course, MAX(t.count)
		  FROM t
		  GROUP BY t.course) t2, 
		  t
	WHERE t.course = t2.course AND t2.max = t.count
	ORDER BY t.course;
		
SELECT * FROM abc3

--task23
CREATE VIEW abc4 AS
	with t as (SELECT substr(s.num_group::text,1,1) as course, h.hobby_name,  MAX(h.risk)
		FROM student as s NATURAL JOIN stud_hobby as sh
		NATURAL JOIN hobby as h
		GROUP BY substr(s.num_group::text,1,1), h.hobby_name)

	SELECT t.course, t.hobby_name
	FROM  (SELECT t.course, MAX(t.max)
		  FROM t
		  GROUP BY t.course) t2, 
		  t
	WHERE t.course = t2.course AND t2.course = '2' AND t2.max = t.max
	ORDER BY t.course;
		
SELECT * FROM abc4

--task24
CREATE VIEW abc5 AS
	with t1 as (SELECT substr(s.num_group::text,1,1) as course, COUNT(s.record_book)
		FROM student as s
		GROUP BY substr(s.num_group::text,1,1)), 
		
		t2 as (SELECT substr(s.num_group::text,1,1) as course, COUNT(s.record_book) as count2
		FROM student as s
		WHERE s.avg_score >= 4.5
		GROUP BY substr(s.num_group::text,1,1))
		
	SELECT *
	FROM t1 LEFT OUTER JOIN t2 USING(course);
	
SELECT * FROM abc5

--task25
--Представление: самое популярное хобби среди всех студентов.
CREATE VIEW abc6 AS
	with t as (SELECT h.hobby_name as h, COUNT(*)
		FROM stud_hobby as sh JOIN hobby as h USING(hobby_id)
		GROUP BY h.hobby_name
		ORDER BY count DESC
		LIMIT 1)
	
	SELECT t.h
	FROM t;
	
SELECT * FROM abc6

--task26
--Создать обновляемое представление
CREATE VIEW abc7 AS
	SELECT s.surname, s.avg_score
	FROM student s;

SELECT * FROM abc7

--task27
SELECT substr(s.student_name,1,1), MIN(s.avg_score),
	AVG(s.avg_score), MAX(s.avg_score)
FROM student s
WHERE avg_score > 3.6
GROUP BY substr

--task28
with t AS (SELECT substr(s.num_group::varchar,1,1), s.surname
	FROM student s
	GROUP BY substr, s.surname)
	
SELECT t.substr, t.surname, MAX(s.avg_score), MIN(s.avg_score)
FROM t JOIN student s 
	ON t.substr = substr(s.num_group::varchar,1,1) AND t.surname = s.surname
GROUP BY t.substr, t.surname
ORDER BY t.substr DESC, t.surname

--task29
SELECT EXTRACT(YEAR FROM s.date_birth), COUNT(sh.date_start)
FROM student as s JOIN stud_hobby as sh USING(record_book)
GROUP BY extract

--task30
SELECT substr(s.student_name,1,1), MIN(h.risk), MAX(h.risk)
FROM student as s JOIN stud_hobby as sh USING(record_book)
	JOIN hobby as h USING(hobby_id)
GROUP BY substr

--task31
SELECT extract(month from s.date_birth), AVG(s.avg_score)
FROM student as s JOIN stud_hobby as sh USING(record_book)
	JOIN hobby as h USING(hobby_id)
WHERE h.hobby_name = 'football'
GROUP BY extract

--task32
SELECT s.student_name as name, s.surname as surname, s.num_group as group_
FROM student s JOIN stud_hobby sh USING(record_book)
WHERE sh.date_start IS NOT NULL

--task33
SELECT s.surname,
	CASE 
		WHEN strpos(s.surname, 'ov') != 0 then strpos(s.surname, 'ov')::text
		WHEN strpos(s.surname, 'ov') = 0 then 'not found'
	END
FROM student s

--task34
CREATE VIEW abc34 AS
	SELECT s.surname,
		CASE 
			WHEN length(s.surname) >= 10 then s.surname
			ELSE rpad(s.surname, 10, '#')
		END
	FROM student s

--task35
SELECT btrim(t.surname, '#')
FROM abc34 t

--task36
SELECT extract('day' from 
			   date_trunc('month', '2018-04-01'::date)+'
			   1 month'::interval-'1 day'::interval)

--task37
SELECT CASE
	   WHEN date_part('dow', current_date) <= 5 then date_trunc('week', current_date) + interval '5 days'
	   ELSE date_trunc('week', current_date) + interval '12 days'
	   END;

--task38
SELECT extract(century from current_date), extract(week from current_date),
	extract(doy from current_date)
	
--task39
SELECT s.student_name, s.surname, h.hobby_name,
	CASE 
		WHEN sh.date_finish IS NULL THEN 'закончил'
		ELSE 'занимается'
	END
FROM student as s JOIN stud_hobby sh USING(record_book)
	JOIN hobby as h USING(hobby_id)


