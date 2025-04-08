-- Средняя температура пациентов по каждому диагнозу (диагноз, средняя температура)
SELECT diagnosis, ROUND(AVG(patient_temperature), 2) AS avg_temp
FROM InpatientTreatment
GROUP BY diagnosis
ORDER BY avg_temp DESC;
