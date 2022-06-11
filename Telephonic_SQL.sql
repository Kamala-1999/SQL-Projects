-- There are multiple rows having same values which increases the performance and memory usage.
-- Also there are columns such as country,state,city etc which are interdependent and hence the table is not normalized.
-- Here not much columns are not having transitive depedency and partial dependency. 
-- But still to get a better performance and easy to understand data , I am deviding the columns to multiple tables w.r.t normalization.
--Based on the data I have devided the columns to multiple tables like on Location,Personal Information,Services they have taken,
--, Billing Information and Churn Information.

create database if not exists tele_data;
--create table City
CREATE TABLE City (
  city_id varchar(11) NOT NULL,
  city_name varchar(55) NOT NULL,
  PRIMARY KEY (city_id) 
);

-- add values to city table
INSERT INTO City (city_id, city_name) 
VALUES 
      ('LA', 'Los Angeles'), 
      ('PA', 'Point Arena'), 
      ('JN', 'Jenner'), 
      ('HL', 'Healdsburg'), 
      ('SF', 'San Francisco'), 
      ('SJ', 'San Jose'), 
      ('SD', 'San Diego');

-- create table State
CREATE TABLE State (
  state_id varchar(2) NOT NULL,
  state_name varchar(55) NOT NULL,
  PRIMARY KEY (state_id)
);

--add values
INSERT INTO State (state_id, state_name)
VALUES 
      ('CA', 'California'),
      ('NV', 'Nevada'),
      ('OR', 'Oregon'),
      ('WA', 'Washington');

-- create table Country
CREATE TABLE Country (
  country_id varchar(2) NOT NULL,
  country_name varchar(55) NOT NULL,
  PRIMARY KEY (country_id)
);

--add values
INSERT INTO Country (country_id, country_name)
VALUES 
      ('US', 'United States'),
      ('MX_2', 'Mexico'),
      ('CA_3', 'Canada'),
      ('AU_4', 'Australia');

--create table Zipcode
CREATE TABLE Zipcode (
  zipcode int(11) NOT NULL,
  Log_Lat varchar(51) NOT NULL,
  Latitude varchar(51) NOT NULL,
  Longitude varchar(51) NOT NULL,
  PRIMARY KEY (zipcode)
);

-- add values to Zipcode table
INSERT INTO Zipcode (zipcode, Log_Lat, Latitude, Longitude)
VALUES 
      (90003,'33.964131, -118.272783','33.964131','-118.272783'),
      (90005,'34.059281, -118.30742','34.059281','-118.307420'),
      (90006,'34.048013, -118.293953','34.048013','-118.293953'),
      (90010,'34.062125, -118.315709','34.062125','-118.315709'),
      (90015,'34.039224, -118.266293','34.039224','-118.266293'),
      (90020,'34.066367, -118.309868','34.066367','-118.309868'),
      (90022,'34.02381, -118.1565820','34.023810','-118.156582'),
      (90024,'34.066303, -118.435479','34.066303','-118.435479'),
      (90028,'34.099869, -118.326843','34.099869','-118.326843'),
      (90029,'34.089953, -118.294824','34.089953','-118.294824');

--create table Address
CREATE TABLE Address (
  customer_id varchar(51) NOT NULL,
  count int(11) NOT NULL,
  city_id varchar(11) NOT NULL,
  state_id varchar(2) NOT NULL,
  country_id varchar(2) NOT NULL,
  zipcode int(11) NOT NULL,
  PRIMARY KEY (customer_id)
);

--add values to Address table
INSERT INTO Address (customer_id, count, city_id, state_id, country_id, zipcode)
VALUES
      ('3668-QPYBK',1,'LA','CA','US',90003),
      ('9237-HQITU',1,'LA','CA','US',90005),
      ('9305-CDSKC',1,'LA','CA','US',90006),
      ('7892-POOKP',1,'LA','CA','US',90010),
      ('0280-XJGEX',1,'LA','CA','US',90015),
      ('4190-MFLUW',1,'LA','CA','US',90020),
      ('8779-QRDMV',1,'LA','CA','US',90024),
      ('1066-JKSGK',1,'LA','CA','US',90028),
      ('6467-CHFZW',1,'LA','CA','US',90028),
      ('8665-UTDHZ',1,'LA','CA','US',90029);
-- Here FOREIGN KEYS are city_id,state_id,country_id,zipcode.

--create table Personal
CREATE TABLE Personal (
  customer_id varchar(51) NOT NULL,
  Gender varchar(11) NOT NULL,
  Snr_ctz varchar(5) NOT NULL,
  partner VARCHAR(5) NOT NULL,
  dependent VARCHAR(5) NOT NULL,
  PRIMARY KEY (customer_id)
);

--add values
INSERT INTO personal (customer_id, Gender, Snr_ctz, partner,dependent)
VALUES
      ('3668-QPYBK','Male', 'No', 'No', 'No'),
      ('9237-HQITU', 'Female', 'No', 'No', 'Yes'),
      ('9305-CDSKC', 'Female', 'No', 'No', 'Yes'),
      ('7892-POOKP', 'Female', 'No', 'Yes', 'Yes'),
      ('0280-XJGEX', 'Male','No', 'No', 'Yes'),
      ('4190-MFLUW', 'Female', 'No', 'Yes', 'No'),
      ('8779-QRDMV', 'Male', 'Yes', 'No', 'No'),
      ('1066-JKSGK', 'Male', 'No', 'No', 'No'),
      ('6467-CHFZW', 'Male', 'No', 'Yes', 'Yes'),
      ('8665-UTDHZ', 'Male', 'No', 'Yes', 'No');
-- Here there is no FOREIGN keys.

--create table Services
CREATE Table Services (
  customer_id VARCHAR(51) NOT NULL,
  Tenure_months INT(51) NOT NULL,
  Phone_service VARCHAR(5),
  Multiple_lines VARCHAR(5),
  Internet_ID VARCHAR(5),
  Online_Security VARCHAR(5),
  Online_Backup VARCHAR(5),
  Device_Protection VARCHAR(5),
  Tech_Support VARCHAR(5),
  Stream_TV VARCHAR(5),
  Stream_Movies VARCHAR(5),
  PRIMARY KEY (customer_id)
);

--add values
INSERT INTO Services (customer_id, Tenure_months, Phone_service, Multiple_lines,Internet_ID,Online_Security,Online_Backup,Device_Protection,Tech_Support,Stream_TV,Stream_Movies)
VALUES
      ('3668-QPYBK',2,'Yes','No','DS', 'Yes', 'Yes', 'No', 'No', 'No', 'No'),
      ('9237-HQITU',12,'Yes','No','FB', 'No', 'No', 'No', 'No', 'No', 'No'),
      ('9305-CDSKC',8,'Yes','Yes', 'FB', 'No','No', 'Yes', 'No', 'Yes', 'Yes'),
      ('7892-POOKP',28,'Yes','Yes', 'FB', 'No', 'No', 'Yes', 'Yes', 'Yes', 'Yes'),
      ('0280-XJGEX',49,'Yes','Yes', 'FB', 'No', 'Yes', 'Yes', 'No', 'Yes', 'Yes'),
      ('4190-MFLUW',10,'No','No', 'DS', 'No', 'No', 'Yes', 'Yes', 'No', 'No'),
      ('8779-QRDMV',1,'Yes','No', 'DS', 'No', 'No', 'Yes', 'No', 'No', 'Yes'),
      ('1066-JKSGK',1,'Yes','No','N/A', 'No', 'No', 'No', 'No', 'No', 'No'),
      ('6467-CHFZW',47,'Yes','Yes', 'FB', 'No','Yes', 'No', 'No', 'Yes', 'Yes'),
      ('8665-UTDHZ',1,'No','No', 'DS', 'No','Yes', 'No', 'No', 'No', 'No');
-- HereFOREIGN key is Internet_ID.

--create table Internet_Service
CREATE TABLE Internet_Service (
  Internet_ID VARCHAR(11) NOT NULL,
  Internet_service VARCHAR(51) NOT NULL,
  PRIMARY KEY (Internet_ID)
);

--add values
INSERT INTO Internet_Service (Internet_ID, Internet_service)
VALUES
      ('DS','DSL'),
      ('FB','Fiber'),
      ('N/A','No Service');

--create table Billing
CREATE TABLE Billing (
  customer_id VARCHAR(51) NOT NULL,
  contract_id VARCHAR(11) NOT NULL,
  paperless_billing VARCHAR(5) NOT NULL,
  Payment_id VARCHAR(11) NOT NULL,
  monthly_charges DECIMAL(10,2) NOT NULL,
  total_charges DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (customer_id)
);

--add values
INSERT INTO Billing (customer_id, contract_id, paperless_billing, Payment_id, monthly_charges, total_charges)
VALUES
      ('3668-QPYBK','M-M','Yes','MC',53.85,108.15),
      ('9237-HQITU','M-M','Yes','EC',70.70,151.65),
      ('9305-CDSKC','M-M','Yes','EC',99.65,820.5),
      ('7892-POOKP','M-M','Yes','EC',104.80,3046.05),
      ('0280-XJGEX','M-M','Yes','BT',103.70,5036.3),
      ('4190-MFLUW','M-M','No','CC',55.20,528.35),
      ('8779-QRDMV','M-M','Yes','EC',39.65,39.65),
      ('1066-JKSGK','M-M','No','MC',20.15,20.15),
      ('6467-CHFZW','M-M','Yes','EC',99.35,4749.15),
      ('8665-UTDHZ','M-M','No','EC',30.20,30.2);
-- Here FOREIGN keys are contract_id,Payment_id.

--create table Payment
CREATE TABLE Payment (
  Payment_id VARCHAR(11) NOT NULL,
  Payment_method VARCHAR(11) NOT NULL,
  PRIMARY KEY (Payment_id)
);

--add values
INSERT INTO Payment (Payment_id, Payment_method)
VALUES
      ('EC','Electronic Check'),
      ('MC','Mailed check'),
      ('BT','Bank transfer (automatic)'),
      ('CC','Credit card (automatic)');

--create table Contract
CREATE TABLE Contract (
  contract_id VARCHAR(11) NOT NULL,
  contract_type VARCHAR(51) NOT NULL,
  PRIMARY KEY (contract_id)
);

--add values
INSERT INTO Contract (contract_id, contract_type)
VALUES
      ('M-M','Month-to-month'),
      ('1Y','One Year'),
      ('2Y','Two Years');

--create table customer_churn
CREATE TABLE customer_churn (
  customer_id VARCHAR(51) NOT NULL,
  churn_level VARCHAR(5) NOT NULL,
  churn_value int(11) NOT NULL,
  churn_score DECIMAL(10,2) NOT NULL,
  CLTV DECIMAL(10,2) NOT NULL,
  reason_id VARCHAR(11) NOT NULL,
  PRIMARY KEY (customer_id)
);

--add values
INSERT INTO customer_churn (customer_id, churn_level, churn_value, churn_score, CLTV, reason_id)
VALUES
      ('3668-QPYBK','Yes',1,86,3239,'5'),
      ('9237-HQITU','Yes',1,67,2701,'14'),
      ('9305-CDSKC','Yes',1,86,5372,'14'),
      ('7892-POOKP','Yes',1,84,5003,'14'),
      ('0280-XJGEX','Yes',1,89,5340,'7'),
      ('4190-MFLUW','Yes',1,78,5925,'2'),
      ('8779-QRDMV','Yes',1,100,5433,'3'),
      ('1066-JKSGK','Yes',1,92,4832,'5'),
      ('6467-CHFZW','Yes',1,77,5789,'7'),
      ('8665-UTDHZ','Yes',1,97,2915,'7');
-- here FOREIGN key is reason_id.

--create table churn_reason
CREATE TABLE churn_reason (
  reason_id VARCHAR(11) NOT NULL,
  churn_reason VARCHAR(51) NOT NULL,
  PRIMARY KEY (reason_id)
);

--add values
INSERT INTO churn_reason (reason_id, churn_reason)
VALUES
      ('1','Attitude of support person'),
      ('2','Competitor offered higher download speeds'),
      ('3','Competitor offered more data'),
      ('4','Do not know'),
      ('5','Competitor made better offer'),
      ('6','Attitude of service provider'),
      ('7','Competitor had better devices'),
      ('8','Network reliability'),
      ('9','Product dissatisfaction'),
      ('10','Price too high'),
      ('11','Service dissatisfaction'),
      ('12','Lack of self-service on Website'),
      ('13','Extra data charges'),
      ('14','Moved'),
      ('15','Limited range of services'),
      ('16','Long distance charges'),
      ('17','Lack of affordable download/upload speed'),
      ('18','Poor expertise of phone support'),
      ('19','Poor expertise of online support'),
      ('20','Deceased');


--create E-R Model

