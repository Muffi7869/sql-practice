-- joins

-- each doctor with their department
SELECT d.name AS doctor, dep.name AS department
FROM doctors d JOIN departments dep ON dep.id = d.department_id;
