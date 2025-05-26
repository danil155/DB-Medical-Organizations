-- Пациенты, которые проходили как стационарное, так и амбулаторное лечение (Имя, Фамилия, Отчество)
SELECT p.name, p.surname, p.patronymic
FROM Patient p
WHERE EXISTS (
    SELECT 1 FROM InpatientTreatment i WHERE i.patient_id = p.id
)
AND EXISTS (
    SELECT 1 FROM OutpatientTreatment o WHERE o.patient_id = p.id
);
