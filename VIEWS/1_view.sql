-- Представление для текущих амбулаторных пациентов
CREATE OR REPLACE VIEW current_outpatient_treatments AS
SELECT 
    p.id AS patient_id,
    p.name || ' ' || p.surname AS patient_name,
    c.name AS clinic_name,
    ot.begin_date,
    ot.end_date
FROM 
    OutpatientTreatment ot
JOIN 
    Patient p ON ot.patient_id = p.id
JOIN 
    Clinic c ON ot.clinic_id = c.id
WHERE 
    ot.end_date IS NULL OR ot.end_date >= CURRENT_DATE;