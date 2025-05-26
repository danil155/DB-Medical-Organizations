-- Болезни, которые не являются хроническими и лечатся хотя бы в одном отделении (название болезни)
SELECT name
FROM Disease
WHERE chronic = FALSE AND id IN (
    SELECT disease_id FROM DiseaseToDepartment
);
