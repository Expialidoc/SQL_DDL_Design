-- from the terminal run:
-- psql < outer_space.sql

DROP DATABASE IF EXISTS outer_space;

CREATE DATABASE outer_space;

\c outer_space

CREATE TABLE planets
(
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL
);

CREATE TABLE params
(
  id SERIAL PRIMARY KEY,
  orbital_period_in_years FLOAT NOT NULL,
  orbits_around TEXT NOT NULL,
  galaxy TEXT NOT NULL,
  planets_id INTEGER REFERENCES planets ON DELETE CASCADE
);

CREATE TABLE moons
(
  id SERIAL PRIMARY KEY,
  moons TEXT[],
  planets_id INTEGER REFERENCES planets ON DELETE CASCADE
);

INSERT INTO planets
  (name)
VALUES
  ('Earth'),
  ('Mars'),
  ('Venus'),
  ('Neptune'),
  ('Proxima Centauri b'),
  ('Gliese 876 b');

INSERT INTO params
  (orbital_period_in_years, orbits_around, galaxy,planets_id)
VALUES
  (1.00, 'The Sun', 'Milky Way',1),
  (1.88, 'The Sun', 'Milky Way',2),
  (0.62, 'The Sun', 'Milky Way',3),
  (164.8, 'The Sun', 'Milky Way',4),
  (0.03, 'Proxima Centauri', 'Milky Way',5),
  (0.23, 'Gliese 876', 'Milky Way',6);

INSERT INTO moons
  (moons,planets_id)
VALUES
  ('{"The Moon"}',1),
  ('{"Phobos", "Deimos"}',2),
  ('{}',3),
  ('{"Naiad", "Thalassa", "Despina", "Galatea", "Larissa", "S/2004 N 1", "Proteus", "Triton", "Nereid", "Halimede", "Sao", "Laomedeia", "Psamathe", "Neso"}',4),
  ('{}',5),
  ('{}',6);

-- outer_space=# DELETE FROM planets WHERE name = 'Neptune';
-- outer_space=# SELECT * FROM planets;
--  id |        name
-- ----+--------------------
--   1 | Earth
--   2 | Mars
--   3 | Venus
--   5 | Proxima Centauri b
--   6 | Gliese 876 b
-- (5 rows)

-- outer_space=# SELECT * FROM params;
--  id | orbital_period_in_years |  orbits_around   |  galaxy   | planets_id
-- ----+-------------------------+------------------+-----------+------------
--   1 |                       1 | The Sun          | Milky Way |          1
--   2 |                    1.88 | The Sun          | Milky Way |          2
--   3 |                    0.62 | The Sun          | Milky Way |          3
--   5 |                    0.03 | Proxima Centauri | Milky Way |          5
--   6 |                    0.23 | Gliese 876       | Milky Way |          6
-- (5 rows)

-- outer_space=# SELECT * FROM moons;
--  id |      moons      | planets_id
-- ----+-----------------+------------
--   1 | {"The Moon"}    |          1
--   2 | {Phobos,Deimos} |          2
--   3 | {}              |          3
--   5 | {}              |          5
--   6 | {}              |          6
-- (5 rows)

-- outer_space=# INSERT INTO planets (name) VALUES ('Mercury');
--  INSERT INTO params (orbital_period_in_years, orbits_around, galaxy,planets_id)
--  VALUES (0.41,'The Sun', 'Milky Way',7);
--  INSERT INTO moons (moons,planets_id) VALUES ('{}',7);