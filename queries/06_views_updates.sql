-- views, updates, deletes, transactions

-- view: appointment report used by the dashboard
CREATE VIEW appointment_report AS
SELECT a.id, p.name AS patient, d.name AS doctor, dep.name AS department, a.scheduled_at, a.status, a.fee
FROM appointments a
JOIN patients p ON p.id = a.patient_id
JOIN doctors d ON d.id = a.doctor_id
JOIN departments dep ON dep.id = d.department_id;

-- query the view
SELECT department, COUNT(*) AS visits, SUM(fee) AS revenue FROM appointment_report WHERE status = 'completed' GROUP BY department;

-- view: monthly payroll per department
CREATE VIEW monthly_payroll AS
SELECT dep.name AS department, ROUND(SUM(d.salary) / 12.0, 2) AS monthly
FROM doctors d JOIN departments dep ON dep.id = d.department_id GROUP BY dep.name;

-- give cardiology a 5% raise inside a transaction
BEGIN;
UPDATE doctors SET salary = ROUND(salary * 1.05) WHERE department_id = (SELECT id FROM departments WHERE name = 'Cardiology');
COMMIT;

-- mark old scheduled appointments as no_show
UPDATE appointments SET status = 'no_show' WHERE status = 'scheduled' AND scheduled_at < '2026-07-19';

-- upsert a patient (sqlite / postgres syntax)
INSERT INTO patients (id, name, birth_date, city, insurance) VALUES (9, 'Neel Joshi', '2003-02-02', 'Surat', NULL)
ON CONFLICT (id) DO UPDATE SET city = excluded.city;

-- delete cancelled appointments with no prescriptions
DELETE FROM appointments WHERE status = 'cancelled' AND id NOT IN (SELECT appointment_id FROM prescriptions);
