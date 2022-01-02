-- from the terminal run:
-- psql < music.sql

DROP DATABASE IF EXISTS music;

CREATE DATABASE music;

\c music

CREATE TABLE artists
(
  id SERIAL PRIMARY KEY,
  artists TEXT[] NOT NULL
);

CREATE TABLE albums
(
  id SERIAL PRIMARY KEY,
  release_date DATE NOT NULL,
  album TEXT NOT NULL,
  producers TEXT[] NOT NULL,
  artist_id INTEGER NOT NULL REFERENCES artists ON DELETE CASCADE
);

CREATE TABLE songs
(
  id SERIAL PRIMARY KEY,
  title TEXT NOT NULL,
  duration_in_seconds INTEGER NOT NULL,
  artist_id INTEGER NOT NULL REFERENCES artists ON DELETE CASCADE,
  album_id INTEGER NOT NULL REFERENCES albums ON DELETE SET NULL
);

INSERT INTO artists
  ( artists )
VALUES
  ('{"Hanson"}'),
  ('{"Queen"}'),
  ('{"Mariah Cary", "Boyz II Men"}'),
  ('{"Lady Gaga", "Bradley Cooper"}'),
  ('{"Nickelback"}'),
  ('{"Jay Z", "Alicia Keys"}'),
  ('{"Katy Perry", "Juicy J"}'),
  ('{"Maroon 5", "Christina Aguilera"}'),
  ('{"Avril Lavigne"}'),
  ('{"Destiny''s Child"}');

INSERT INTO albums
  (release_date, album, producers,artist_id)
VALUES
  ('04-15-1997','Middle of Nowhere', '{"Dust Brothers", "Stephen Lironi"}',1),
  ('10-31-1975', 'A Night at the Opera', '{"Roy Thomas Baker"}',2),
  ('11-14-1995', 'Daydream', '{"Walter Afanasieff"}',3),
  ('09-27-2018', 'A Star Is Born', '{"Benjamin Rice"}',4),
  ('08-21-2001', 'Silver Side Up', '{"Rick Parashar"}',5),
  ('10-20-2009', 'The Blueprint 3', '{"Al Shux"}',6),
  ('12-17-2013', 'Prism', '{"Max Martin", "Cirkut"}',7),
  ('06-21-2011', 'Hands All Over', '{"Shellback", "Benny Blanco"}',8),
  ('05-14-2002', 'Let Go', '{"The Matrix"}',9),
  ('11-07-1999', 'The Writing''s on the Wall', '{"Darkchild"}',10);

INSERT INTO songs
  (title, duration_in_seconds,artist_id,album_id)
VALUES
  ('MMMBop', 238,1,1),
  ('Bohemian Rhapsody', 355,2,2),
  ('One Sweet Day', 282,3,3),
  ('Shallow', 216,4,4),
  ('How You Remind Me', 223,5,5),
  ('New York State of Mind', 276,6,6),
  ('Dark Horse', 215,7,7),
  ('Moves Like Jagger', 201,8,8),
  ('Complicated', 244,9,9),
  ('Say My Name', 240,10,10);

-- music=# DELETE FROM artists WHERE artists = '{"Queen"}';
-- DELETE 1
-- music=# SELECT * FROM songs;
--  id |         title          | duration_in_seconds | artist_id | album_id
-- ----+------------------------+---------------------+-----------+----------
--   1 | MMMBop                 |                 238 |         1 |        1
--   3 | One Sweet Day          |                 282 |         3 |        3
--   4 | Shallow                |                 216 |         4 |        4
--   5 | How You Remind Me      |                 223 |         5 |        5
--   6 | New York State of Mind |                 276 |         6 |        6
--   7 | Dark Horse             |                 215 |         7 |        7
--   8 | Moves Like Jagger      |                 201 |         8 |        8
--   9 | Complicated            |                 244 |         9 |        9
--  10 | Say My Name            |                 240 |        10 |       10
-- (9 rows)

-- music=# SELECT * FROM albums;
--  id | release_date |           album           |             producers              | artist_id
-- ----+--------------+---------------------------+------------------------------------+-----------
--   1 | 1997-04-15   | Middle of Nowhere         | {"Dust Brothers","Stephen Lironi"} |         1
--   3 | 1995-11-14   | Daydream                  | {"Walter Afanasieff"}              |         3
--   4 | 2018-09-27   | A Star Is Born            | {"Benjamin Rice"}                  |         4
--   5 | 2001-08-21   | Silver Side Up            | {"Rick Parashar"}                  |         5
--   6 | 2009-10-20   | The Blueprint 3           | {"Al Shux"}                        |         6
--   7 | 2013-12-17   | Prism                     | {"Max Martin",Cirkut}              |         7
--   8 | 2011-06-21   | Hands All Over            | {Shellback,"Benny Blanco"}         |         8
--   9 | 2002-05-14   | Let Go                    | {"The Matrix"}                     |         9
--  10 | 1999-11-07   | The Writing's on the Wall | {Darkchild}                        |        10
-- (9 rows)