-- interview style practice problems on the same schema

-- second highest salary (null if there isn't one)
SELECT MAX(salary) AS second_highest FROM doctors WHERE salary < (SELECT MAX(salary) FROM doctors);

-- departments where every doctor earns over 150k
SELECT dep.name FROM departments dep JOIN doctors d ON d.department_id = dep.id
GROUP BY dep.name HAVING MIN(d.salary) > 150000;

-- duplicate check: patients sharing a birth year and city
SELECT city, SUBSTR(birth_date, 1, 4) AS yr, COUNT(*) AS n FROM patients GROUP BY city, yr HAVING COUNT(*) > 1;

-- doctors with no appointments at all
SELECT d.name FROM doctors d WHERE NOT EXISTS (SELECT 1 FROM appointments a WHERE a.doctor_id = d.id);

-- each patient's most expensive visit
SELECT p.name, MAX(a.fee) AS max_fee FROM patients p JOIN appointments a ON a.patient_id = p.id GROUP BY p.name ORDER BY max_fee DESC;

-- consecutive visits by the same patient within 10 days
SELECT a1.patient_id, a1.scheduled_at AS first, a2.scheduled_at AS second
FROM appointments a1 JOIN appointments a2 ON a1.patient_id = a2.patient_id AND a2.scheduled_at > a1.scheduled_at
WHERE julianday(a2.scheduled_at) - julianday(a1.scheduled_at) <= 10;
