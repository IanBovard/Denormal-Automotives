\c radlad

DROP DATABASE IF EXISTS normal_cars;
DROP USER IF EXISTS normal_user;

CREATE USER normal_user;
CREATE DATABASE normal_cars WITH OWNER normal_user;

\c normal_cars;

DROP TABLE IF EXISTS make;
DROP TABLE IF EXISTS model;
DROP TABLE IF EXISTS yearDictionary;
DROP TABLE IF EXISTS model_year;

CREATE TABLE make (
  id SERIAL PRIMARY KEY NOT NULL,
  make_code character varying(125) NOT NULL,
  make_title character varying(125) NOT NULL
);

CREATE TABLE model (
  id SERIAL PRIMARY KEY NOT NULL,
  model_code character varying(125) NOT NULL,
  model_title character varying(125) NOT NULL
  make_id INT REFERENCES make(id)
);

CREATE TABLE yearDictionary (
  id SERIAL PRIMARY KEY NOT NULL,
  year integer NOT NULL
);

CREATE TABLE model_year (
  model_id INT REFERENCES model (id),
  year_id INT REFERENCES year(id)
);
