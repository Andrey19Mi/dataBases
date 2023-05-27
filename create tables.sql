-- таблица с отделами и рабочеми местами на них
CREATE TABLE IF NOT EXISTS post(
	id serial PRIMARY KEY,
	department varchar(255) NOT NULL, -- отдел
	work_place varchar(255) NOT NULL, -- рабочее место
	UNIQUE(department, work_place)
);

-- таблица со строениями и входами в них 
CREATE TABLE IF NOT EXISTS zone(
	id serial PRIMARY KEY,
	building int NOT NULL, -- строение
	entery int NOT NULL, --вход
	UNIQUE(building, entery)
);

--таблица с работниками
CREATE TABLE IF NOT EXISTS peaple(
	id serial PRIMARY KEY,
	name varchar(32) NOT NULL, -- имя сотрудника
	surname varchar(32) NOT NULL, -- фамилия сотрудника
	patronymic varchar(32), -- отчество сотрудника
	mail varchar(255) UNIQUE,-- почта сотрудника
	phone varchar(16) NOT NULL UNIQUE,-- телефон сотрудника
	workplace_id int,-- рабочее место сотрудника
	shift_start time NOT NULL,--начало смены сотрудника
	shift_finish time NOT NULL,-- конец смены сотрудника
	dismissed bool DEFAULT FALSE, -- уволен ли
	salary int CHECK (salary > 0), -- зарплата сотрудника
	FOREIGN KEY(workplace_id) REFERENCES post(id) ON DELETE RESTRICT
);

-- таблица с доступами в зону
CREATE TABLE IF NOT EXISTS access_level(
	id serial PRIMARY KEY,
	peaple_id int, -- id сотрудника
	zone_id int, -- id зоны в которую доступ разрешен
	UNIQUE(peaple_id, zone_id),
	FOREIGN KEY(peaple_id) REFERENCES peaple(id) ON DELETE CASCADE,
	FOREIGN KEY(zone_id) REFERENCES zone(id) ON DELETE CASCADE
);


-- таблица с камерами
CREATE TABLE IF NOT EXISTS camera
(
	id serial PRIMARY KEY,
	name varchar(24) NOT NULL, -- имя камеры
	processDelay int DEFAULT 5, -- раз в сколько кадров нейросеть обробатывает поток
	link varchar(255) NOT NULL UNIQUE, -- ссылка на камеру
	areas text, --массив массивов с массивами точек, которые формируют области в которые нельзья заходить
	zone_id int, -- в какой зоне находится камера
	FOREIGN KEY(zone_id) REFERENCES zone(id) ON DELETE CASCADE,
	UNIQUE(name, zone_id)
);
-- таблица с событиями
CREATE TABLE IF NOT EXISTS event 
(
	id serial PRIMARY KEY,
	camera_id int, -- камера
	description text NOT NULL, --описание нпрушения, описание формируется на сервере
	time_stamp timestamp DEFAULT current_timestamp, -- время нарушения
	photo bytea NOT NULL, --фото нарушения
	zone_id int, -- в какой зоне произошло на рушение
	peaple_id int, -- кто нарушил
	FOREIGN KEY(camera_id) REFERENCES camera(id) ON DELETE CASCADE,
	FOREIGN KEY(zone_id) REFERENCES zone(id) ON DELETE CASCADE,
	FOREIGN KEY(peaple_id) REFERENCES peaple(id) ON DELETE CASCADE

);
-- таблица координатами детектов людей для постоения тепловой карты
CREATE TABLE IF NOT EXISTS trace_point
(
	id serial PRIMARY KEY,
	camera_id int NOT NULL,
	x decimal NOT NULL,
	y decimal NOT NULL,
	time_stamp timestamp DEFAULT current_timestamp,
	FOREIGN KEY(camera_id) REFERENCES camera(id) ON DELETE CASCADE
);
--тригер-функия отправет в канал id нарушения
CREATE OR REPLACE FUNCTION notify_realtime() 
	RETURNS trigger as $BODY$
		BEGIN
		PERFORM pg_notify('add_event', NEW.id::varchar);
		RETURN NULL;
		END;
	$BODY$
LANGUAGE plpgsql;
--тригер на добовление нарушения в таблицу
CREATE OR REPLACE TRIGGER updated_realtime_trigger_event AFTER INSERT ON event
FOR EACH ROW EXECUTE PROCEDURE notify_realtime();

----тригер-функия отправет в канал id камеры
CREATE OR REPLACE FUNCTION camera_realtime() 
	RETURNS trigger as $BODY$
		BEGIN
		PERFORM pg_notify('add_camera', NEW.id::varchar);
		RETURN NULL;
		END;
	$BODY$
LANGUAGE plpgsql;
--тригер на добовление камеры в таблицу
CREATE OR REPLACE TRIGGER updated_realtime_trigger_camera AFTER INSERT ON camera
FOR EACH ROW EXECUTE PROCEDURE camera_realtime();
