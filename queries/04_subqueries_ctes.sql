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
