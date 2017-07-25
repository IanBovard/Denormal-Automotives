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

SELECT DISTINCT model_title
FROM car_models
WHERE make_code = 'VOLKS';