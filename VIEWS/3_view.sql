-- Представление для статистики по заболеваниям
CREATE OR REPLACE VIEW disease_statistics AS
SELECT 
    d.name AS disease_name,
    d.icd_code,
    COUNT(DISTINCT it.id) AS inpatient_cases,
    COUNT(DISTINCT ot.id) AS outpatient_cases,
    COUNT(DISTINCT CASE WHEN it.end_date IS NULL OR it.end_date >= CURRENT_DATE THEN it.id END) AS current_inpatient_cases,
    COUNT(DISTINCT CASE WHEN ot.end_date IS NULL OR ot.end_date >= CURRENT_DATE THEN ot.id END) AS current_outpatient_cases
FROM 
    Disease d
LEFT JOIN 
    InpatientTreatment it ON it.diagnosis = d.name
LEFT JOIN 
    OutpatientTreatment ot ON ot.id IN (
        SELECT ot2.id 
        FROM OutpatientTreatment ot2
        JOIN Clinic c ON ot2.clinic_id = c.id
        JOIN Hospital h ON c.hospital_id = h.id
        JOIN HospitalBuilding hb ON hb.hospital_id = h.id
        JOIN Department dep ON dep.hospital_building_id = hb.id
        JOIN DiseaseToDepartment dtd ON dtd.department_id = dep.id
        WHERE dtd.disease_id = d.id
    )
GROUP BY 
    d.id, d.name, d.icd_code;
	