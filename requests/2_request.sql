-- Названия отеделений, где лечат более 2-ух болезней (название отеделения, количество болезней)
SELECT d.name AS department_name, COUNT(DISTINCT dd.disease_id) AS disease_count
FROM Department d
JOIN DiseaseToDepartment dd ON d.id = dd.department_id
GROUP BY d.name
HAVING COUNT(DISTINCT dd.disease_id) > 2;
