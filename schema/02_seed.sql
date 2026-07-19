-- seed data (made up)

-- departments
INSERT INTO departments (id, name, floor) VALUES
  (1, 'General Medicine', 1), (2, 'Orthopedics', 2), (3, 'Pediatrics', 2), (4, 'Cardiology', 3), (5, 'Dermatology', 1);

-- doctors
INSERT INTO doctors (id, name, department_id, hired_on, salary) VALUES
  (1, 'Dr. Desai', 1, '2015-06-01', 180000), (2, 'Dr. Kapoor', 1, '2020-01-15', 150000),
  (3, 'Dr. Nair', 2, '2012-09-10', 240000), (4, 'Dr. Iyer', 3, '2018-03-22', 170000),
  (5, 'Dr. Shah', 4, '2010-11-05', 310000), (6, 'Dr. Mehta', 4, '2021-07-19', 260000),
  (7, 'Dr. Rao', 5, '2019-02-11', 160000);

-- patients
INSERT INTO patients (id, name, birth_date, city, insurance) VALUES
  (1, 'Aarav Patel', '1990-04-12', 'Bardoli', 'StarHealth'), (2, 'Diya Shah', '2015-08-30', 'Surat', NULL),
  (3, 'Kabir Mehta', '1978-01-05', 'Bardoli', 'HDFC Ergo'), (4, 'Isha Joshi', '2001-12-19', 'Navsari', 'StarHealth'),
  (5, 'Rohan Desai', '1965-07-23', 'Surat', 'LIC'), (6, 'Anaya Rao', '2019-03-14', 'Bardoli', NULL),
  (7, 'Vihaan Kumar', '1985-10-02', 'Vyara', 'HDFC Ergo'), (8, 'Sara Khan', '1995-05-27', 'Surat', 'StarHealth');
