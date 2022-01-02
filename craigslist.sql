-- from the terminal run: $psql < craigslist.sql

DROP DATABASE IF EXISTS clist;

CREATE DATABASE clist;

\c clist

CREATE TABLE regions
(
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL
);

CREATE TABLE categories
(
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL
);

CREATE TABLE users
(
  id SERIAL PRIMARY KEY,
  first_name TEXT NOT NULL,
  last_name TEXT NOT NULL,
  region_id INTEGER NOT NULL REFERENCES regions,
  post_id INTEGER NOT NULL
);

CREATE TABLE posts
(
  id SERIAL PRIMARY KEY,
  title TEXT NOT NULL,
  post TEXT NOT NULL,
  user_id INTEGER REFERENCES users ON DELETE SET NULL,
  region_id INTEGER NOT NULL REFERENCES regions,
  category_id INTEGER REFERENCES categories
);

INSERT INTO regions
  (name)
VALUES
  ('San Francisco'),
  ('Atlanta'),
  ('Seattle'),
  ('Houston');

INSERT INTO categories
  (name)
VALUES
  ('Furniture'),
  ('Cars'),
  ('Music'),
  ('Misc');

INSERT INTO users
  (first_name, last_name, region_id, post_id)
VALUES
  ('Berkie', 'Wycliff',1, 1),
  ('Alvin', 'Leathes',3, 2),
  ('Lisa', 'Ratcliff',4, 3),
  ('Cory', 'Squibbes',2, 4),
  ('Jennifer', 'Finch',3, 5);

INSERT INTO posts
  (title, post, user_id, region_id, category_id)
VALUES
  ('My bed', 'OMG! Look at my superbed!', 1, 1, 1),
  ('My car', 'OMG! Look at my funny car!', 2, 3, 2),
  ('My song', 'This song was born to the plight of my bleeding heart', 3, 4, 3),
  ('Cardan shaft for sale', 'Just for $800.99', 4, 2, 2),
  ('Chicken puzzle!', 'Contains 300 pieces!', 5, 3, 4);

/*  ALTER TABLE users
ADD --CONSTRAINT constraint_fk
FOREIGN KEY (post_id)
REFERENCES posts (id)
ON DELETE SET NULL; */