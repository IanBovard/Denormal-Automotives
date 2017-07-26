\c radlad

DROP DATABASE IF EXISTS normal_cars;
DROP USER IF EXISTS normal_user;

CREATE USER normal_user;
CREATE DATABASE normal_cars WITH OWNER normal_user;

\c normal_cars;
\i scripts/denormal_data.sql;

DROP TABLE IF EXISTS car_models
DROP TABLE IF EXISTS car_make;
DROP TABLE IF EXISTS car_model;
DROP TABLE IF EXISTS year_dictionary;
DROP TABLE IF EXISTS model_year;

CREATE TABLE car_make (
  id SERIAL PRIMARY KEY NOT NULL,
  make_code character varying(125) NOT NULL,
  make_title character varying(125) NOT NULL
);

INSERT INTO car_make (make_code, make_title)
SELECT DISTINCT make_code, make_title
FROM car_models;

CREATE TABLE car_model (
  id SERIAL PRIMARY KEY NOT NULL,
  model_code character varying(125) NOT NULL,
  model_title character varying(125) NOT NULL,
  car_make_id INT REFERENCES car_make(id) NOT NULL
);

INSERT INTO car_model (model_code, model_title, car_make_id)
SELECT DISTINCT model_code, model_title, (
  SELECT id
  FROM car_make cma
  WHERE old_data.make_title = cma.make_title
  AND   old_data.make_code = cma.make_code
  )
FROM car_models AS old_data;

CREATE TABLE year_dictionary (
  id SERIAL PRIMARY KEY NOT NULL,
  year integer NOT NULL
);

INSERT INTO year_dictionary (year)
SELECT DISTINCT year
FROM car_models;

CREATE TABLE model_year (
  car_model_id INT REFERENCES car_model(id) NOT NULL,
  year_id INT REFERENCES year_dictionary(id) NOT NULL
);

INSERT INTO model_year (car_model_id, year_id)
SELECT car_model.id , year_dictionary.id
FROM car_models old_data
JOIN year_dictionary
ON year_dictionary.year = old_data.year
JOIN car_model
ON car_model.model_title = old_data.model_title
AND car_model.model_code = old_data.model_code;

SELECT make_title
FROM car_make;

SELECT cma.make_title
FROM car_make cma
JOIN car_model cmo
ON cmo.car_make_id = cma.id
WHERE make_code = 'VOLKS';

SELECT make_title, make_code, model_title, year
FROM car_make
JOIN car_model
ON car_model.car_make_id = car_make.id
JOIN model_year
ON model_year.car_model_id = car_model.id
JOIN year_dictionary
ON model_year.year_id = year_dictionary.id
WHERE car_make.make_code = 'LAM';

SELECT make_title, make_code, model_title, model_code
FROM car_make
JOIN car_model
ON car_model.car_make_id = car_make.id
JOIN model_year
ON model_year.car_model_id = car_model.id
JOIN year_dictionary
ON model_year.year_id = year_dictionary.id
WHERE year_dictionary.year BETWEEN '2010' AND '2015';