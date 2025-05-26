-- Количество амбулаторных обращений в каждую поликлиннику (имя поликлинники, количество обращений)
SELECT c.name AS clinic_name, COUNT(ot.id) AS visit_count
FROM OutpatientTreatment ot
JOIN Clinic c ON ot.clinic_id = c.id
GROUP BY c.name
ORDER BY visit_count DESC;
