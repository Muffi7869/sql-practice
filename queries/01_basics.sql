-- select, where, order by, limit

-- all patients from bardoli
SELECT name, birth_date FROM patients WHERE city = 'Bardoli' ORDER BY name;

-- patients without insurance
SELECT name, city FROM patients WHERE insurance IS NULL;

-- doctors hired after 2018, newest first
SELECT name, hired_on FROM doctors WHERE hired_on >= '2018-01-01' ORDER BY hired_on DESC;

-- top 3 highest paid doctors
SELECT name, salary FROM doctors ORDER BY salary DESC LIMIT 3;

-- appointments in a date range that actually happened
SELECT id, scheduled_at, fee FROM appointments
WHERE status = 'completed' AND scheduled_at BETWEEN '2026-07-01' AND '2026-07-07 23:59';

-- pattern matching on names
SELECT name FROM patients WHERE name LIKE '%Shah%' OR name LIKE 'K%';
