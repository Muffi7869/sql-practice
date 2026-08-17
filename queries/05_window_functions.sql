-- window functions

-- rank doctors by salary inside each department
SELECT name, department_id, salary,
  RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) AS dept_rank
FROM doctors;

-- running total of revenue by date
SELECT DATE(scheduled_at) AS day, SUM(fee) AS revenue,
  SUM(SUM(fee)) OVER (ORDER BY DATE(scheduled_at)) AS running_total
FROM appointments WHERE status = 'completed'
GROUP BY DATE(scheduled_at);

-- each patient's visits numbered in order
SELECT patient_id, scheduled_at,
  ROW_NUMBER() OVER (PARTITION BY patient_id ORDER BY scheduled_at) AS visit_no
FROM appointments;

-- days since the patient's previous visit (lag)
SELECT patient_id, scheduled_at,
  julianday(scheduled_at) - julianday(LAG(scheduled_at) OVER (PARTITION BY patient_id ORDER BY scheduled_at)) AS days_since_last
FROM appointments ORDER BY patient_id, scheduled_at;

-- salary vs department average without a subquery
SELECT name, salary,
  ROUND(AVG(salary) OVER (PARTITION BY department_id), 0) AS dept_avg,
  salary - ROUND(AVG(salary) OVER (PARTITION BY department_id), 0) AS diff
FROM doctors;

-- top earning doctor per department using a window + cte
WITH ranked AS (
  SELECT name, department_id, salary, ROW_NUMBER() OVER (PARTITION BY department_id ORDER BY salary DESC) AS rn FROM doctors
)
SELECT dep.name AS department, r.name, r.salary FROM ranked r JOIN departments dep ON dep.id = r.department_id WHERE rn = 1;

-- 3 visit moving average of fees
SELECT id, scheduled_at, fee,
  ROUND(AVG(fee) OVER (ORDER BY scheduled_at ROWS BETWEEN 2 PRECEDING AND CURRENT ROW), 1) AS moving_avg
FROM appointments WHERE status = 'completed';
