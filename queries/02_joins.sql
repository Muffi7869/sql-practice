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

-- left join: every department even if no appointments
SELECT dep.name, COUNT(a.id) AS visits
FROM departments dep
LEFT JOIN doctors d ON d.department_id = dep.id
LEFT JOIN appointments a ON a.doctor_id = d.id AND a.status = 'completed'
GROUP BY dep.name ORDER BY visits DESC;

-- patients who never had a completed visit (anti join)
SELECT p.name FROM patients p
LEFT JOIN appointments a ON a.patient_id = p.id AND a.status = 'completed'
WHERE a.id IS NULL;

-- prescriptions with the doctor who wrote them
SELECT pr.drug, pr.days, d.name AS doctor, p.name AS patient
FROM prescriptions pr
JOIN appointments a ON a.id = pr.appointment_id
JOIN doctors d ON d.id = a.doctor_id
JOIN patients p ON p.id = a.patient_id;

-- self join: doctors in the same department
SELECT a.name AS doctor_a, b.name AS doctor_b, a.department_id
FROM doctors a JOIN doctors b ON a.department_id = b.department_id AND a.id < b.id;

-- patients who saw more than one department
SELECT p.name, COUNT(DISTINCT d.department_id) AS depts
FROM patients p
JOIN appointments a ON a.patient_id = p.id
JOIN doctors d ON d.id = a.doctor_id
GROUP BY p.name HAVING COUNT(DISTINCT d.department_id) > 1;
