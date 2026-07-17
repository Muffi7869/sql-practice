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

-- patients
CREATE TABLE patients (
  id INTEGER PRIMARY KEY,
  name TEXT NOT NULL,
  birth_date DATE NOT NULL,
  city TEXT NOT NULL,
  insurance TEXT
);

-- appointments
CREATE TABLE appointments (
  id INTEGER PRIMARY KEY,
  patient_id INTEGER NOT NULL REFERENCES patients(id),
  doctor_id INTEGER NOT NULL REFERENCES doctors(id),
  scheduled_at TIMESTAMP NOT NULL,
  status TEXT NOT NULL CHECK (status IN ('scheduled', 'completed', 'cancelled', 'no_show')),
  fee NUMERIC NOT NULL DEFAULT 0
);
