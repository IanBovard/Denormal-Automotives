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

INSERT INTO make VALUES (
 denormal_cars.make_code,
 denormal_cars.make_title
);

CREATE TABLE model (
  id SERIAL PRIMARY KEY NOT NULL,
  model_code character varying(125) NOT NULL,
  model_title character varying(125) NOT NULL
  make_id INT REFERENCES make(id)
);

INSERT INTO model (
  denormal_cars.model_code,
  denormal_cars.model_title
);

CREATE TABLE year_dictionary (
  id SERIAL PRIMARY KEY NOT NULL,
  year integer NOT NULL
);

INSERT INTO year_dictionary (
  (2000), (2001), (2002), (2003), (2004), (2005), (2006), (2007), (2008), (2009), (2010), (2011), (2012), (2013), (2014), (2015), (2016)
);

CREATE TABLE model_year (
  model_id INT REFERENCES model(id),
  year_id INT REFERENCES year(id)
);
