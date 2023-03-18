SELECT s.*
FROM student s;
SELECT sh.*
FROM stud_hobby sh
--task 2.1.1
SELECT s.student_name, s.surname
FROM student s
WHERE s.avg_score > 3.99 AND s.avg_score < 4.51;

SELECT s.student_name, s.surname
FROM student s
WHERE s.avg_score BETWEEN 4 AND 4.51;

SELECT s.student_name, s.surname
FROM student s
WHERE s.avg_score IN (4, 4.01, 4.02, 4.03, 4.04, 4.05, 4.06, 4.07, 4.08, 4.09, 4.10, 4.11, 4.12, 4.13, 4.14, 4.15, 4.16, 4.17, 4.18, 4.19, 4.20, 4.21, 4.22, 4.23, 4.24, 4.25, 4.26, 4.27, 4.28, 4.29, 4.30, 4.31, 4.32, 4.33, 4.34, 4.35, 4.36, 4.37, 4.38, 4.39, 4.40, 4.41, 4.42, 4.43, 4.44, 4.45, 4.46, 4.47, 4.48, 4.49, 4.50);

SELECT s.student_name, s.surname
FROM student s
WHERE s.avg_score = 4 OR s.avg_score = 4.01 OR s.avg_score = 4.02 OR s.avg_score = 4.03 OR s.avg_score = 4.04 OR s.avg_score = 4.05 OR s.avg_score = 4.06 OR s.avg_score = 4.07 OR s.avg_score = 4.08 OR s.avg_score = 4.09 OR s.avg_score = 4.10 OR s.avg_score = 4.11 OR s.avg_score = 4.12 OR s.avg_score = 4.13 OR s.avg_score = 4.14 OR s.avg_score = 4.15 OR s.avg_score = 4.16 OR s.avg_score = 4.17 OR s.avg_score = 4.18 OR s.avg_score = 4.19 OR s.avg_score = 4.20 OR s.avg_score = 4.21 OR s.avg_score = 4.22 OR s.avg_score = 4.23 OR s.avg_score = 4.24 OR s.avg_score = 4.25 OR s.avg_score = 4.26 OR s.avg_score = 4.27 OR s.avg_score = 4.28 OR s.avg_score = 4.29 OR s.avg_score = 4.30 OR s.avg_score = 4.31 OR s.avg_score = 4.32 OR s.avg_score = 4.33 OR s.avg_score = 4.34 OR s.avg_score = 4.35 OR s.avg_score = 4.36 OR s.avg_score = 4.37 OR s.avg_score = 4.38 OR s.avg_score = 4.39 OR s.avg_score = 4.40 OR s.avg_score = 4.41 OR s.avg_score = 4.42 OR s.avg_score = 4.43 OR s.avg_score = 4.44 OR s.avg_score = 4.45 OR s.avg_score = 4.46 OR s.avg_score = 4.47 OR s.avg_score = 4.48 OR s.avg_score = 4.49 OR s.avg_score = 4.50;

--task 2.1.2
SELECT s.*
FROM student s
WHERE num_group::varchar LIKE '2%'

--task 2.1.3

SELECT s.*
FROM student s
ORDER BY s.num_group DESC, s.student_name

--task 2.1.4
SELECT s.* 
FROM student s
WHERE s.avg_score > 4
ORDER BY s.avg_score DESC;

--task 2.1.5
SELECT h.hobby_name, h.risk
FROM hobby h
LIMIT 2;

--task 2.1.6
SELECT sh.hobby_id, sh.record_book
FROM stud_hobby sh
WHERE sh.date_start BETWEEN '2015-01-01' AND '2020-12-31' AND sh.date_finish IS NULL;

--task 2.1.7
SELECT s.* 
FROM student s
WHERE s.avg_score > 4.5
ORDER BY s.avg_score DESC;

-- task 2.1.8

SELECT s.* 
FROM student s
WHERE s.avg_score > 4.5
ORDER BY s.avg_score DESC
LIMIT 5;

SELECT t.*
FROM (SELECT s.* 
	FROM student s
	WHERE s.avg_score > 4.5
	ORDER BY s.avg_score DESC) t
LIMIT 5;

--task 2.1.9
SELECT h.*,
CASE
WHEN h.risk >= 0.8 THEN 'very hight'
WHEN h.risk BETWEEN 0.6 AND 0.8 THEN 'hight'
WHEN h.risk BETWEEN 0.4 AND 0.6 THEN 'middle'
WHEN h.risk BETWEEN 0.2 AND 0.4 THEN 'low'
WHEN h.risk < 02 THEN 'very low'
END AS risk
FROM hobby h;

--task 2.1.10
SELECT h.*
FROM hobby h
ORDER BY h.risk DESC
LIMIT 3;

--task 2.2.1
SELECT s.num_group, COUNT(s)
FROM student s
GROUP BY s.num_group;

--task 2.2.2
SELECT s.num_group, MAX(avg_score)
FROM student s
GROUP BY s.num_group;

--task 2.2.3
SELECT s.surname, COUNT(s.surname)
FROM student s
GROUP BY s.surname;

--task 2.2.4
SELECT EXTRACT(YEAR FROM s.date_birth), COUNT(*)
FROM student s
GROUP BY EXTRACT(YEAR FROM s.date_birth);

--task 2.2.5
SELECT SUBSTRING(s.num_group::varchar, 1, 1) AS course, AVG(s.avg_score) AS avg_score
FROM student s
GROUP BY SUBSTRING(s.num_group::varchar, 1, 1);

--task 2.2.6
SELECT s.num_group, MAX(s.avg_score) as max_avg
FROM student s
WHERE SUBSTRING(s.num_group::varchar, 1, 1) = '2'
GROUP BY s.num_group
ORDER BY max_avg DESC
LIMIT 1;

--task 2.2.7
SELECT s.num_group, AVG(s.avg_score) as avg_score1
FROM student s
GROUP BY s.num_group
HAVING AVG(s.avg_score) <= 3.5
ORDER BY avg_score1

--task 2.2.8
SELECT s.num_group, COUNT(s.record_book) AS students, MAX(s.avg_score) AS max_score,
	AVG(s.avg_score) AS avg_score, MIN(s.avg_score) AS min_score
FROM student s
GROUP BY s.num_group;

--task 2.2.9
SELECT s.*
FROM (SELECT s.num_group, MAX(s.avg_score) AS max_score
	FROM student s
	GROUP BY s.num_group) t, student s
WHERE s.num_group = 2255 AND t.num_group = s.num_group AND t.max_score = s.avg_score;

--task 2.2.10
SELECT s.*
FROM (SELECT s.num_group, MAX(s.avg_score) AS max_score
	FROM student s
	GROUP BY s.num_group) t, student s
WHERE t.num_group = s.num_group AND t.max_score = s.avg_score;
