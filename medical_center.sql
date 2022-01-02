-- from the terminal run: $psql < medical_center.sql

DROP DATABASE IF EXISTS medical;

CREATE DATABASE medical;

\c medical

CREATE TABLE docs
(
  id SERIAL PRIMARY KEY,
  first_name TEXT NOT NULL,
  last_name TEXT NOT NULL,
  specialty TEXT NOT NULL
);

CREATE TABLE patients
(
  id SERIAL PRIMARY KEY,
  first_name TEXT NOT NULL,
  last_name TEXT NOT NULL,
  sex TEXT
);

CREATE TABLE diagnoses
(
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  patient_id INTEGER REFERENCES patients ON DELETE SET NULL,
  doc_id INTEGER REFERENCES docs ON DELETE SET NULL
);

INSERT INTO docs
  (first_name, last_name, specialty)
VALUES
  ('Jennifer', 'Finch', 'General Practitioner'),
  ('Thadeus', 'Gathercoal', 'Obstetrics/Ginecology'),
  ('Sonja', 'Pauley', 'Psychiatry'),
  ('Erwin', 'Bach', 'General Practitioner');

INSERT INTO patients
  (first_name, last_name, sex)
VALUES
  ('Berkie', 'Wycliff','m'),
  ('Alvin', 'Leathes','m'),
  ('Lisa', 'Ratcliff','f'),
  ('Cory', 'Squibbes','m');

INSERT INTO diagnoses
  (name, patient_id, doc_id)
VALUES
  ('femoral hernia', 1, 1),
  ('generalized anxiety disorder', 2, 3),
  ('ecsema', 2, 4),
  ('pregnant', 3, 2),
  ('pregnant', 3, 1),
  ('obesity', 4, 1),
  ('depression', 4, 3);

--medical=# UPDATE patients SET sex='f' WHERE first_name='Alvin';
/*UPDATE 1
medical=# SELECT * FROM patients;
 id | first_name | last_name | sex
----+------------+-----------+-----
  1 | Berkie     | Wycliff   | m
  3 | Lisa       | Ratcliff  | f
  4 | Cory       | Squibbes  | m
  2 | Alvin      | Leathes   | f
(4 rows)*/

--medical=# SELECT * FROM diagnoses;
--  id |             name             | patient_id | doc_id
-- ----+------------------------------+------------+--------
--   1 | femoral hernia               |          1 |      1
--   2 | generalized anxiety disorder |          2 |      3
--   3 | ecsema                       |          2 |      4
--   4 | pregnant                     |          3 |      2
--   5 | pregnant                     |          3 |      1
--   6 | obesity                      |          4 |      1
--   7 | depression                   |          4 |      3
-- (7 rows)

-- medical=# UPDATE diagnoses SET name='grumpy' WHERE id=5;
-- UPDATE 1
-- medical=# SELECT * FROM diagnoses;
--  id |             name             | patient_id | doc_id
-- ----+------------------------------+------------+--------
--   1 | femoral hernia               |          1 |      1
--   2 | generalized anxiety disorder |          2 |      3
--   3 | ecsema                       |          2 |      4
--   4 | pregnant                     |          3 |      2
--   6 | obesity                      |          4 |      1
--   7 | depression                   |          4 |      3
--   5 | grumpy                       |          3 |      1
-- (7 rows)

-- medical=# DELETE FROM patients WHERE first_name = 'Alvin';
-- DELETE 1
-- medical=# SELECT * FROM patients;
--  id | first_name | last_name | sex | diag_id
-- ----+------------+-----------+-----+---------
--   1 | Berkie     | Wycliff   | m   |       1
--   3 | Lisa       | Ratcliff  | f   |       3
--   4 | Cory       | Squibbes  | m   |       4
-- (3 rows)

-- medical=# SELECT * FROM diagnoses;
--  id |      name      | patient_id | doc_id
-- ----+----------------+------------+--------
--   1 | femoral hernia |          1 |      1
--   4 | pregnant       |          3 |      2
--   5 | pregnant       |          3 |      1
--   6 | obesity        |          4 |      1
--   7 | depression     |          4 |      3
-- (5 rows)