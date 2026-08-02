-- subqueries and common table expressions

-- doctors paid above the overall average
SELECT name, salary FROM doctors WHERE salary > (SELECT AVG(salary) FROM doctors);
