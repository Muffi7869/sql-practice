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

-- appointments (part 1)
INSERT INTO appointments (id, patient_id, doctor_id, scheduled_at, status, fee) VALUES
  (1, 1, 1, '2026-07-01 09:30', 'completed', 500), (2, 2, 4, '2026-07-01 10:00', 'completed', 600),
  (3, 3, 5, '2026-07-02 11:15', 'completed', 1500), (4, 4, 7, '2026-07-02 12:00', 'cancelled', 0),
  (5, 5, 5, '2026-07-03 09:00', 'completed', 1500), (6, 6, 4, '2026-07-03 15:30', 'no_show', 0),
  (7, 7, 3, '2026-07-04 10:45', 'completed', 1200), (8, 8, 1, '2026-07-05 16:00', 'completed', 500);

-- appointments (part 2)
INSERT INTO appointments (id, patient_id, doctor_id, scheduled_at, status, fee) VALUES
  (9, 1, 6, '2026-07-08 09:15', 'completed', 1400), (10, 3, 5, '2026-07-09 11:00', 'completed', 1500),
  (11, 5, 2, '2026-07-10 14:20', 'completed', 450), (12, 2, 4, '2026-07-12 10:30', 'completed', 600),
  (13, 7, 3, '2026-07-15 13:00', 'completed', 1200), (14, 8, 7, '2026-07-16 17:10', 'completed', 800),
  (15, 4, 1, '2026-07-18 09:45', 'scheduled', 500), (16, 6, 4, '2026-07-20 11:30', 'scheduled', 600);

-- prescriptions
INSERT INTO prescriptions (id, appointment_id, drug, days) VALUES
  (1, 1, 'Paracetamol', 5), (2, 3, 'Atorvastatin', 90), (3, 3, 'Aspirin', 30), (4, 5, 'Metoprolol', 60),
  (5, 7, 'Ibuprofen', 10), (6, 9, 'Atorvastatin', 90), (7, 10, 'Aspirin', 30), (8, 13, 'Ibuprofen', 7),
  (9, 14, 'Tretinoin', 45), (10, 12, 'Amoxicillin', 7);
