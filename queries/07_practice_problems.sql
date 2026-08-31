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

-- pivot: completed visits per department per week
SELECT dep.name,
  SUM(CASE WHEN a.scheduled_at < '2026-07-08' THEN 1 ELSE 0 END) AS week1,
  SUM(CASE WHEN a.scheduled_at >= '2026-07-08' AND a.scheduled_at < '2026-07-15' THEN 1 ELSE 0 END) AS week2,
  SUM(CASE WHEN a.scheduled_at >= '2026-07-15' THEN 1 ELSE 0 END) AS week3
FROM appointments a JOIN doctors d ON d.id = a.doctor_id JOIN departments dep ON dep.id = d.department_id
WHERE a.status = 'completed' GROUP BY dep.name;

-- median fee of completed visits (no median function in sqlite)
WITH ordered AS (
  SELECT fee, ROW_NUMBER() OVER (ORDER BY fee) AS rn, COUNT(*) OVER () AS cnt FROM appointments WHERE status = 'completed'
)
SELECT AVG(fee) AS median_fee FROM ordered WHERE rn IN ((cnt + 1) / 2, (cnt + 2) / 2);

-- year over year style: revenue change between first and second half of july
SELECT
  SUM(CASE WHEN scheduled_at < '2026-07-16' THEN fee ELSE 0 END) AS first_half,
  SUM(CASE WHEN scheduled_at >= '2026-07-16' THEN fee ELSE 0 END) AS second_half
FROM appointments WHERE status = 'completed';

-- drugs prescribed by more than one doctor
SELECT pr.drug, COUNT(DISTINCT a.doctor_id) AS doctors FROM prescriptions pr JOIN appointments a ON a.id = pr.appointment_id
GROUP BY pr.drug HAVING COUNT(DISTINCT a.doctor_id) > 1;

-- gaps and islands: streaks of days with at least one appointment
WITH days AS (SELECT DISTINCT DATE(scheduled_at) AS d FROM appointments),
grp AS (SELECT d, julianday(d) - ROW_NUMBER() OVER (ORDER BY d) AS g FROM days)
SELECT MIN(d) AS streak_start, MAX(d) AS streak_end, COUNT(*) AS days FROM grp GROUP BY g ORDER BY days DESC;

-- cumulative share of revenue (pareto check)
WITH rev AS (
  SELECT d.name, SUM(a.fee) AS r FROM appointments a JOIN doctors d ON d.id = a.doctor_id WHERE a.status = 'completed' GROUP BY d.name
)
SELECT name, r, ROUND(100.0 * SUM(r) OVER (ORDER BY r DESC) / SUM(r) OVER (), 1) AS cum_pct FROM rev ORDER BY r DESC;
