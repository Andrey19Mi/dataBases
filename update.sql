--обновление почты, если сотрудник ее поменял или ее небыло
UPDATE peaple
SET mail = 'absd@gmail.com'
WHERE id = 1;

--обновление телефона, если сотрудник его поменял
UPDATE peaple
SET phone = '8 900 900 90 90'
WHERE id = 1;

--сотрудника перевели на новое рабочее место
BEGIN;

UPDATE peaple
SET workplace_id = 2
WHERE id = 1;

UPDATE peaple
SET salary = 40000
WHERE id = 1;

COMMIT;

--сотруднику меняют рабочую смену
BEGIN;

UPDATE peaple
SET shift_start = '16:00:00'
WHERE id = 1;

UPDATE peaple
SET shift_finish = '24:00:00'
WHERE id = 1;

COMMIT;

--сотрудника уволили 
UPDATE peaple
SET dismissed = TRUE
WHERE id = 1;

----сотруднику меняют зарплату
UPDATE peaple
SET salary = 40000
WHERE id = 1;

--изминение названия камеры
UPDATE camera
SET name = 'abcd'
WHERE id = 1;

--изминение ссылки на камеры
UPDATE camera
SET areas = NULL
WHERE id = 1;

UPDATE camera
SET link = 'qwert'
WHERE id = 1;

COMMIT;

--изминение нахождния камеры
BEGIN;

UPDATE camera
SET areas = NULL
WHERE id = 1;

UPDATE camera
SET zone_id = 'qwert'
WHERE id = 1;

COMMIT;

--изменение запртных зон камеры
UPDATE camera
SET areas = '((0.2133, 0.2313),(0.5633, 0.21342),(0.65432,0.13234)),((0.3133, 0.4313),(0.6633, 0.71342),(0.85432,0.93234))'
WHERE id = 1;