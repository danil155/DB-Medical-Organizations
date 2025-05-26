-- Пациенты, у которых было стационарное лечение в более чем 1 палате (Имя, Фамилия, Отчество, количество палат)
SELECT p.name, p.surname, p.patronymic, COUNT(DISTINCT it.hospital_room_id) AS room_count
FROM InpatientTreatment it
JOIN Patient p ON p.id = it.patient_id
GROUP BY p.id, p.name, p.surname, p.patronymic
HAVING COUNT(DISTINCT it.hospital_room_id) > 1
ORDER BY room_count DESC;
