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
