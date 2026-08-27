-- interview style practice problems on the same schema

-- second highest salary (null if there isn't one)
SELECT MAX(salary) AS second_highest FROM doctors WHERE salary < (SELECT MAX(salary) FROM doctors);
