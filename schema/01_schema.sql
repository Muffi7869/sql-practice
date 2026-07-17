-- hospital database used for all the practice queries
-- runs on sqlite and postgres (mostly standard sql)

-- departments
CREATE TABLE departments (
  id INTEGER PRIMARY KEY,
  name TEXT NOT NULL UNIQUE,
  floor INTEGER NOT NULL
);

-- doctors
CREATE TABLE doctors (
  id INTEGER PRIMARY KEY,
  name TEXT NOT NULL,
  department_id INTEGER NOT NULL REFERENCES departments(id),
  hired_on DATE NOT NULL,
  salary NUMERIC NOT NULL CHECK (salary > 0)
);
