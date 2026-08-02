-- group by, having, aggregates

-- revenue per doctor
SELECT d.name, SUM(a.fee) AS revenue, COUNT(*) AS visits
FROM appointments a JOIN doctors d ON d.id = a.doctor_id
WHERE a.status = 'completed'
GROUP BY d.name ORDER BY revenue DESC;

-- average salary per department
SELECT dep.name, ROUND(AVG(d.salary), 0) AS avg_salary, MIN(d.salary) AS min_salary, MAX(d.salary) AS max_salary
FROM doctors d JOIN departments dep ON dep.id = d.department_id
GROUP BY dep.name;

-- appointment status breakdown
SELECT status, COUNT(*) AS n, ROUND(100.0 * COUNT(*) / (SELECT COUNT(*) FROM appointments), 1) AS pct
FROM appointments GROUP BY status ORDER BY n DESC;

-- cities with more than one patient
SELECT city, COUNT(*) AS patients FROM patients GROUP BY city HAVING COUNT(*) > 1;

-- busiest day
SELECT DATE(scheduled_at) AS day, COUNT(*) AS appts
FROM appointments GROUP BY DATE(scheduled_at) ORDER BY appts DESC, day LIMIT 1;
