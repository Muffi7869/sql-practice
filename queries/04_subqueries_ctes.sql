-- subqueries and common table expressions

-- doctors paid above the overall average
SELECT name, salary FROM doctors WHERE salary > (SELECT AVG(salary) FROM doctors);

-- doctors paid above their own department average (correlated)
SELECT d.name, d.salary FROM doctors d
WHERE d.salary > (SELECT AVG(d2.salary) FROM doctors d2 WHERE d2.department_id = d.department_id);

-- patients who were prescribed atorvastatin
SELECT name FROM patients WHERE id IN (
  SELECT a.patient_id FROM appointments a JOIN prescriptions pr ON pr.appointment_id = a.id WHERE pr.drug = 'Atorvastatin'
);

-- exists: departments with at least one cancelled appointment
SELECT dep.name FROM departments dep WHERE EXISTS (
  SELECT 1 FROM doctors d JOIN appointments a ON a.doctor_id = d.id
  WHERE d.department_id = dep.id AND a.status = 'cancelled'
);

-- cte: revenue per department then filter
WITH dept_rev AS (
  SELECT d.department_id, SUM(a.fee) AS revenue
  FROM appointments a JOIN doctors d ON d.id = a.doctor_id
  WHERE a.status = 'completed' GROUP BY d.department_id
)
SELECT dep.name, r.revenue FROM dept_rev r JOIN departments dep ON dep.id = r.department_id
WHERE r.revenue > 1000 ORDER BY r.revenue DESC;

-- chained ctes: patient age then age buckets
WITH ages AS (
  SELECT name, CAST((julianday('2026-08-01') - julianday(birth_date)) / 365.25 AS INTEGER) AS age FROM patients
), buckets AS (
  SELECT name, age, CASE WHEN age < 18 THEN 'child' WHEN age < 60 THEN 'adult' ELSE 'senior' END AS grp FROM ages
)
SELECT grp, COUNT(*) AS n, MIN(age) AS youngest, MAX(age) AS oldest FROM buckets GROUP BY grp;

-- recursive cte: generate the days of a week and count appointments per day (including zero days)
WITH RECURSIVE days(d) AS (
  SELECT DATE('2026-07-01')
  UNION ALL SELECT DATE(d, '+1 day') FROM days WHERE d < '2026-07-07'
)
SELECT days.d, COUNT(a.id) AS appts FROM days
LEFT JOIN appointments a ON DATE(a.scheduled_at) = days.d
GROUP BY days.d ORDER BY days.d;
