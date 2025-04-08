-- 5 самых тяжелых стационарных случаев по температуре, начиная со второй пятерки (Имя, Фамилия, температура, диагноз)
SELECT p.name, p.surname, it.patient_temperature, it.diagnosis
FROM InpatientTreatment it
JOIN Patient p ON p.id = it.patient_id
ORDER BY it.patient_temperature DESC
LIMIT 5 OFFSET 5;
