-- subqueries and common table expressions

-- doctors paid above the overall average
SELECT name, salary FROM doctors WHERE salary > (SELECT AVG(salary) FROM doctors);

-- doctors paid above their own department average (correlated)
SELECT d.name, d.salary FROM doctors d
WHERE d.salary > (SELECT AVG(d2.salary) FROM doctors d2 WHERE d2.department_id = d.department_id);
