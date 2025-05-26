-- Пациенты с температурой выше 39.0 при стационарном лечении (Имя, Фамилия, температура, диагноз)
SELECT p.name, p.surname, it.patient_temperature, it.diagnosis
FROM InpatientTreatment it
JOIN Patient p ON p.id = it.patient_id
WHERE it.patient_temperature > 39.0
ORDER BY it.patient_temperature DESC;
