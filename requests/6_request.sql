-- Последнее амбулаторное лечение для каждого пациента (оконная функция: айди лечения, айди пациента, айди клиники, начало лечения, конец лечения)
SELECT *
FROM (
    SELECT ot.*, 
           ROW_NUMBER() OVER (PARTITION BY patient_id ORDER BY begin_date DESC) AS rn
    FROM OutpatientTreatment ot
) t
WHERE rn = 1;
