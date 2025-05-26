-- Представление для пациентов со стационарным лечением и их диагнозами
CREATE OR REPLACE VIEW inpatient_patients_with_diagnoses AS
SELECT 
    p.id AS patient_id,
    p.name || ' ' || p.surname AS patient_name,
    d.name AS department_name,
    hb.name AS building_name,
    hr.type_room AS room_type,
    it.diagnosis,
    it.begin_date,
    it.end_date
FROM 
    InpatientTreatment it
JOIN 
    Patient p ON it.patient_id = p.id
JOIN 
    HospitalRoom hr ON it.hospital_room_id = hr.id
JOIN 
    Department d ON hr.department_id = d.id
JOIN 
    HospitalBuilding hb ON d.hospital_building_id = hb.id
