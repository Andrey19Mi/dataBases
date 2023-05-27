--получение id рабочего места по отделу и должности
SELECT p.id 
FROM post p 
WHERE p.department = 'qqwerty' AND p.work_place = 'abcd';

----получение id зоны по строению и входу
SELECT z.id 
FROM zone z
WHERE z.building = 'qqwerty' AND z.entery = 'abcd';

----получение id сотрудника по фио
SELECT p.id 
FROM peaple p
WHERE p.name ='n' AND p.surname = 'f' AND p.patronymic = 'o';

----получение id уровня доступа по сутруднику и его доступу
SELECT al.id 
FROM access_level al
WHERE al.peaple_id = 1 AND al.zone_id =1;

----получение id камеры по названию и зоне в которой находится
SELECT c.id 
FROM camera c
WHERE c.name = 'n' AND c.zone_id = 1;
