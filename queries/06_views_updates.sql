-- views, updates, deletes, transactions

-- view: appointment report used by the dashboard
CREATE VIEW appointment_report AS
SELECT a.id, p.name AS patient, d.name AS doctor, dep.name AS department, a.scheduled_at, a.status, a.fee
FROM appointments a
JOIN patients p ON p.id = a.patient_id
JOIN doctors d ON d.id = a.doctor_id
JOIN departments dep ON dep.id = d.department_id;
