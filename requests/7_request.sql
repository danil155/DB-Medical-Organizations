-- Список всех болезней и количество отеделений, где они лечатся (имя болезни, количество отделений)
SELECT dis.name, COUNT(dd.department_id) AS departments_count
FROM Disease dis
JOIN DiseaseToDepartment dd ON dis.id = dd.disease_id
GROUP BY dis.name;
