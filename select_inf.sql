--вывод основной информации о сотрудниках отдела
SELECT pp.name, pp.surname, pp.patronymic, pp.mail, pp.phone
FROM post p JOIN peaple pp ON p.id = pp.workplace_id
WHERE p.department = 'qwert';

--вывод полной информации о сотрудннике
SELECT p.*
FROM peaple p
WHERE p.id = 1;

--вывод тех кому разрешен вход в зону
SELECT p.name, p.surname, p.patronymic
FROM access_level al JOIN peaple p ON al.peaple_id = p.id
WHERE al.zone_id = 1;

--вывод рабтников работающих в промежутке времени
SELECT p.name, p.surname, p.patronymic
FROM peaple p
WHERE p.shift_start >= '08:00:00' AND p.shift_finish <= '16:00:00';

--уволеные сотрудники
SELECT p.name, p.surname, p.patronymic
FROM peaple p
WHERE p.dismissed;

--список камер в зоне
SELECT c.name
FROM camera c
WHERE c.zone_id = 1;

--запретные зоны камеры
SELECT c.areas
FROM camera c
WHERE c.id = 1;

--нарушения за промежуток времени
SELECT c.name, z.building, z.entery, e.description, e.time_stamp, e.photo, p.name, p.surname, p.patronymic
FROM event e JOIN camera c ON e.camera_id = c.id
	JOIN zone z ON e.zone_id = z.zone
	JOIN peaple p ON e.peaple_id = p.id
WHERE e.time_stamp BETWEEN '08:00:00' AND '16:00:00';

--точки отслеживания за промежуток времени c определенной камеры
SELECT tp.x, tp.y
FROM trace_point tp
WHERE WHERE (tp.time_stamp BETWEEN '08:00:00' AND '16:00:00') AND tp.camera_id = 1

--информация о нарушении по id (для тригер-функции)
SELECT c.name, z.building, z.entery, e.description, e.time_stamp, e.photo, p.name, p.surname, p.patronymic
FROM event e JOIN camera c ON e.camera_id = c.id
	JOIN zone z ON e.zone_id = z.zone
	JOIN peaple p ON e.peaple_id = p.id
WHERE e.id = 1;
--информация о камере по id
SELECT c.name, c.link
FROM camera c