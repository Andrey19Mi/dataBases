/*
люди(
	имя
	фамилия
	номер телефона
	почта 
	FK должность
	смена начало
	смена конец
	количесво штрафов
	работает ли
	зарплата
	FK уровень доступа
	)

должность(
	отдел
	должность
	)

уровень достуапа(

)
зона(
	помещениями
	номер входа
	FK уровень доступа
	)
*/
--insert, delete, update, select для всех таблиц
--trigger на количесво штрафов
CREATE TABLE IF NOT EXISTS peaple
(
	id serial PRIMARY KEY,
	name varchar(32),
	surname varchar(32),
	phone varchar(11),
	email varchar(32),
	shift_start timestamp,
	shift_end timestamp,

);

CREATE TABLE IF NOT EXISTS camera
(
	id serial PRIMARY KEY,
	name varchar(24) NOT NULL,
	processDelay int DEFAULT 5,
	link varchar(255) NOT NULL,
	areas text
	--FK зона
);

CREATE TABLE IF NOT EXISTS event 
(
	id serial PRIMARY KEY,
	camera_id int,
	description text NOT NULL,
	time_stamp timestamp DEFAULT current_timestamp,
	photo bytea NOT NULL,
	FOREIGN KEY(camera_id) REFERENCES camera(id)
	--FK зона
	--FK личность
);

CREATE TABLE IF NOT EXISTS trace_point
(
	id serial PRIMARY KEY,
	camera_id int NOT NULL,
	x int NOT NULL,
	y int NOT NULL,
	time_stamp timestamp DEFAULT current_timestamp,
	FOREIGN KEY(camera_id) REFERENCES camera(id)
);

CREATE OR REPLACE FUNCTION notify_realtime() 
	RETURNS trigger as $BODY$
		BEGIN
		PERFORM pg_notify('add_event',(NEW.description, NEW.time_stamp,
			(SELECT c.name FROM camera c WHERE NEW.camera_id = c.id), NEW.photo)::varchar);
		RETURN NULL;
		END;
	$BODY$
LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER updated_realtime_trigger_event AFTER INSERT ON event
FOR EACH ROW EXECUTE PROCEDURE notify_realtime();

CREATE OR REPLACE FUNCTION camera_realtime() 
	RETURNS trigger as $BODY$
		BEGIN
		PERFORM pg_notify('add_camera', NEW.id::varchar);
		RETURN NULL;
		END;
	$BODY$
LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER updated_realtime_trigger_camera AFTER INSERT ON camera
FOR EACH ROW EXECUTE PROCEDURE camera_realtime();
