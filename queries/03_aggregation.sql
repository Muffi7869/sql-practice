-- group by, having, aggregates

-- revenue per doctor
SELECT d.name, SUM(a.fee) AS revenue, COUNT(*) AS visits
FROM appointments a JOIN doctors d ON d.id = a.doctor_id
WHERE a.status = 'completed'
GROUP BY d.name ORDER BY revenue DESC;
