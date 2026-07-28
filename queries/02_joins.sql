-- joins

-- each doctor with their department
SELECT d.name AS doctor, dep.name AS department
FROM doctors d JOIN departments dep ON dep.id = d.department_id;

-- appointment details: patient, doctor, time
SELECT a.id, p.name AS patient, d.name AS doctor, a.scheduled_at, a.status
FROM appointments a
JOIN patients p ON p.id = a.patient_id
JOIN doctors d ON d.id = a.doctor_id
ORDER BY a.scheduled_at;
