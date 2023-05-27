--удаление рабочего места
BEGIN;

UPDATE peaple as p
SET workplace_id = NULL
WHERE workplace_id = 1;

DELETE FROM post
WHERE id = 1;

COMMIT;

--удаление зон
DELETE FROM zone
WHERE id = 1;

--удаление сотрудников
DELETE FROM peaple
WHERE id = 1;

--удаление допуска сотрудника в зону
DELETE FROM access_level
WHERE id = 1;

--удаление камеры
DELETE FROM camera
WHERE id = 1;

--удаление нарушений за промежуток времени
DELETE FROM event
WHERE time_stamp BETWEEN 2023-04-01 00:00:00 AND 2023-05-01 00:00:00;

--удаление точек отслеживания за промежуток времени
DELETE FROM event
WHERE time_stamp BETWEEN 2023-04-01 00:00:00 AND 2023-05-01 00:00:00;

