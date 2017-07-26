\c radlad

DROP DATABASE IF EXISTS denormal_cars;
DROP USER IF EXISTS denormal_user;

CREATE USER denormal_user;
CREATE DATABASE denormal_cars WITH OWNER denormal_user;

\c denormal_cars;

DROP TABLE IF EXISTS car_models;

\i scripts/denormal_data.sql;

SELECT DISTINCT make_title
FROM car_models;
-- STEP 1

SELECT DISTINCT model_title
FROM car_models
WHERE make_code = 'VOLKS';
-- STEP 2

SELECT DISTINCT make_code, model_title, year
FROM car_models
WHERE make_code = 'LAM';
-- STEP 3

SELECT DISTINCT make_code, make_title, year, model_code, model_title
FROM car_models
WHERE  year BETWEEN '2010' AND 2015;