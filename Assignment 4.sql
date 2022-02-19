CREATE DATABASE Travelonthego;
USE Travelonthego;

CREATE TABLE PRICE( BUS_TYPE VARCHAR(20), 
DISTANCE INT, 
PRICE INT,
PRIMARY KEY (BUS_TYPE, DISTANCE)
);

DESC PRICE;

INSERT INTO PRICE  VALUES( "SLEEPER", 350, 770);
INSERT INTO PRICE  VALUES( "SLEEPER", 500, 1100); 
INSERT INTO PRICE  VALUES( "SLEEPER", 600, 1320);
INSERT INTO PRICE  VALUES( "SLEEPER", 700, 1540);
INSERT INTO PRICE  VALUES( "SLEEPER", 1000, 2200);
INSERT INTO PRICE  VALUES( "SLEEPER", 1200, 2640);
INSERT INTO PRICE  VALUES( "SLEEPER", 1500, 2700);
INSERT INTO PRICE  VALUES( "SITTING", 500, 620);
INSERT INTO PRICE  VALUES( "SITTING", 600, 744);
INSERT INTO PRICE  VALUES( "SITTING", 700, 868);
INSERT INTO PRICE  VALUES( "SITTING", 1000, 1240);
INSERT INTO PRICE  VALUES( "SITTING", 1200, 1488);
INSERT INTO PRICE  VALUES( "SITTING", 1500, 1860);
 
SELECT * FROM PRICE;
 
CREATE TABLE PASSENGER(PASSENGER_NAME varchar(20) PRIMARY KEY,
CATEGORY varchar(20),
GENDER varchar(5),
BOARDING_CITY varchar(20),
DESTINATION_CITY varchar(20),
DISTANCE int,
BUS_TYPE varchar(20),
CONSTRAINT FOREIGN KEY (BUS_TYPE, DISTANCE) REFERENCES PRICE(BUS_TYPE, DISTANCE)
);

DESC PASSENGER;

INSERT INTO PASSENGER VALUES("SEJAL", "AC", "F", "BENGALURU", "CHENNAI", 350, "SLEEPER");
INSERT INTO PASSENGER VALUES("ANMOL", "NON-AC", "M", "MUMBAI", "HYDERABAD", 700, "SITTING");
INSERT INTO PASSENGER VALUES("PALLAVI", "AC", "F", "PANAJI", "BENGALURU", 600, "SLEEPER");
INSERT INTO PASSENGER VALUES("KHUSBOO", "AC", "F", "CHENNAI", "MUMBAI", 1500, "SLEEPER");
INSERT INTO PASSENGER VALUES("UDIT", "NON-AC", "M", "TRIVENDRUM", "PANAJI", 1000, "SLEEPER");
INSERT INTO PASSENGER VALUES("ANKUR", "AC", "M", "NAGPUR", "HYDERABAD", 500, "SITTING");
INSERT INTO PASSENGER VALUES("HEMANT", "NON-AC", "M", "PANAJI", "MUMBAI", 700, "SLEEPER");
INSERT INTO PASSENGER VALUES("MANISH", "NON-AC", "M", "HYDERABAD", "BENGALURU", 500, "SITTING");
INSERT INTO PASSENGER VALUES("PIYUS", "AC", "M", "PUNE", "NAGPUR", 700, "SITTING");

SELECT * FROM PASSENGER;


/* 3) How many females and how many male passengers travelled for a minimum distance of 600 KM s? */

SELECT GENDER, COUNT(GENDER) FROM PASSENGER WHERE DISTANCE >=600 GROUP BY GENDER; 

/* 4) Find the minimum ticket price for Sleeper Bus.*/
 
SELECT MIN(PRICE) FROM PRICE WHERE BUS_TYPE="SLEEPER";

/* 5) Select passenger names whose names start with character 'S' */

SELECT PASSENGER_NAME FROM PASSENGER WHERE PASSENGER_NAME like "S%";

/* 6) Calculate price charged for each passenger displaying Passenger name, 
Boarding City, Destination City, Bus_Type, Price in the output */

SELECT PASSENGER_NAME, BOARDING_CITY, DESTINATION_CITY, PR.BUS_TYPE, PR.PRICE from PASSENGER 
LEFT JOIN 
PRICE AS PR 
ON (PASSENGER.BUS_TYPE= PR.BUS_TYPE) 
AND (PASSENGER.DISTANCE= PR.DISTANCE);


/* 7) What are the passenger name/s and his/her ticket price who travelled 
in the Sitting bus for a distance of 1000 KM s .*/

SELECT PASSENGER_NAME, P.PRICE FROM PASSENGER
LEFT JOIN 
PRICE AS P
ON (PASSENGER.BUS_TYPE= P.BUS_TYPE) 
AND (PASSENGER.DISTANCE= P.DISTANCE)
WHERE P.BUS_TYPE="SITTING" AND P.DISTANCE>=1000;

/*8) What will be the Sitting and Sleeper bus charge for Pallavi to travel from Bangalore to Panaji? */

SELECT BUS_TYPE, PRICE FROM PRICE WHERE DISTANCE=
(SELECT DISTANCE FROM PASSENGER WHERE PASSENGER_NAME="PALLAVI") GROUP BY BUS_TYPE;


/* 9) List the distances from the "Passenger" table which are unique (non-repeated distances) 
in descending order. */

SELECT DISTANCE, COUNT(DISTANCE)
FROM PASSENGER
GROUP BY DISTANCE
HAVING COUNT(DISTANCE) = 1 ORDER BY DISTANCE DESC;


/* 10) Display the passenger name and percentage of distance travelled 
by that passenger from the total distance travelled by all passengers 
without using user variables */

SELECT PASSENGER_NAME, DISTANCE, DISTANCE*100/T.S AS '% DISTANCE' FROM PASSENGER 
CROSS JOIN 
(SELECT SUM(DISTANCE) AS S FROM PASSENGER) AS T GROUP BY PASSENGER_NAME;

/* 11) Display the distance, price in three categories in table Price a) Expensive 
if the cost is more than 1000 b) Average Cost 
if the cost is less than 1000 and greater than 500*/

SELECT DISTANCE, PRICE,
CASE 
WHEN PRICE > 1000 THEN "Expensive"
WHEN PRICE  <1000 AND PRICE > 500 THEN "AVERAGE"
ELSE "Cheap"
END AS REMARK
FROM PRICE;