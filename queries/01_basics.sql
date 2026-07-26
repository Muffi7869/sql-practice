-- select, where, order by, limit

-- all patients from bardoli
SELECT name, birth_date FROM patients WHERE city = 'Bardoli' ORDER BY name;

-- patients without insurance
SELECT name, city FROM patients WHERE insurance IS NULL;
