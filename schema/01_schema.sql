-- hospital database used for all the practice queries
-- runs on sqlite and postgres (mostly standard sql)

-- departments
CREATE TABLE departments (
  id INTEGER PRIMARY KEY,
  name TEXT NOT NULL UNIQUE,
  floor INTEGER NOT NULL
);
