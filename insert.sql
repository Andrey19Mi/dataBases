--добавление сотрудников
INSERT INTO peaple(name, surname, patronymic, mail, phone, workplace_id, shift_start, shift_finish, salary) VALUES
('Петя', 'Петров','Петровович','qwerty1@gmail.com','8 999 999 99 91', 1,'08:00:00', '16:00:00', 20000);

--добавление рабочих мест
INSERT INTO post(department, work_place) VALUES
('производсвенный отдел', 'стажер');

--добавление зон
INSERT INTO zone(building, entery) VALUES
(1, 1);

--добавление доступов сотрудникам
INSERT INTO access_level(peaple_id, zone_id) VALUES
(1, 1);

--добавление камер
INSERT INTO camera(name, link, zone_id) VALUES
('1', 'link1',1 );

--добавление нарушений
INSERT INTO event(camera_id, description, photo, zone_id, peaple_id) VALUES
(1, 'fdsd', '\xDEADBEEF', 1, 1);

----добавление точек для тепловой карты
INSERT INTO trace_point(camera_id, x, y) VALUES
(1, 0.1212, 0.3221);