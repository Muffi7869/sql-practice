-- interview style practice problems on the same schema

-- second highest salary (null if there isn't one)
SELECT MAX(salary) AS second_highest FROM doctors WHERE salary < (SELECT MAX(salary) FROM doctors);

-- departments where every doctor earns over 150k
SELECT dep.name FROM departments dep JOIN doctors d ON d.department_id = dep.id
GROUP BY dep.name HAVING MIN(d.salary) > 150000;
