CREATE DATABASE fitness_data_hub;

USE fitness_data_hub;

CREATE TABLE gym(
    gym_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    gym_name VARCHAR(25) NOT NULL,
    location VARCHAR(255) NOT NULL
);

CREATE TABLE trainer(
    trainer_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    trainer_name VARCHAR(30) NOT NULL,
    address VARCHAR(100),
    contact BIGINT NOT NULL,
    experience INTEGER NOT NULL,
    gym_id INTEGER NOT NULL,
    FOREIGN KEY (gym_id) REFERENCES gym(gym_id)
);

-- (modified)
CREATE TABLE membership_plan(
    type_name VARCHAR(25) PRIMARY KEY,
    expiry_date DATE NOT NULL,
    amount INTEGER NOT NULL
);

-- (modified)
CREATE TABLE member(
    member_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    member_name VARCHAR(30) NOT NULL,
    address VARCHAR(255),
    contact BIGINT NOT NULL,
    join_date DATE NOT NULL,
    gym_id INTEGER NOT NULL,
    trainer_id INTEGER NOT NULL,
    member_type VARCHAR(25) NOT NULL,
    FOREIGN KEY (trainer_id) REFERENCES trainer(trainer_id),
    FOREIGN KEY (gym_id) REFERENCES gym(gym_id),
    FOREIGN KEY (member_type) REFERENCES membership_plan(type_name)
);

CREATE TABLE competition(
    category_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(25) NOT NULL,
    position INTEGER,
    year INTEGER,
    member_id INTEGER,
    FOREIGN KEY (member_id) REFERENCES member(member_id)
);

-- (modified)
CREATE TABLE equipment(
    equipment_id INTEGER PRIMARY KEY,
    equipment_name VARCHAR(30) NOT NULL,
    weight INTEGER,
    gym_id INTEGER,
    FOREIGN KEY (gym_id) REFERENCES gym(gym_id)
);

CREATE TABLE gives_supplements(
    member_id INTEGER,
    trainer_id INTEGER,
    date_of_intake DATE NOT NULL,
    supplement_name VARCHAR(30) NOT NULL,
    PRIMARY KEY (member_id,date_of_intake),
    FOREIGN KEY (trainer_id) REFERENCES trainer(trainer_id),
    FOREIGN KEY (member_id) REFERENCES member(member_id)
);

CREATE TABLE log_book(
    member_id INTEGER,
    login_date DATETIME,
    PRIMARY KEY (member_id,login_date),
    FOREIGN KEY (member_id) REFERENCES member(member_id)
);

CREATE TABLE using_equipment(
    member_id INTEGER,
    trainer_id INTEGER,
    equipment_id INTEGER,
    date_of_use DATETIME NOT NULL,
    PRIMARY KEY (member_id,date_of_use),
    FOREIGN KEY (member_id) REFERENCES member(member_id),
    FOREIGN KEY (trainer_id) REFERENCES trainer(trainer_id),
    FOREIGN KEY (equipment_id) REFERENCES equipment(equipment_id)
);

-- 06/04/2023
-- inserting values to table gym
INSERT INTO gym(gym_name,location) VALUES
	('Rothman Gym','Trivandrum');
	
-- inserting values to table trainer
INSERT INTO trainer(trainer_name,address,contact,experience,gym_id) VALUES
	('Michael','Palayam',9553798011,6,1),
	('Justin','Vanchiyoor',8351280095,5,1),
	('Maria','Thampanoor',8769611599,4,1),
	('Rajesh','Pettah',7255480246,3,1),
	('Jagath','Kowdiar',9971077633,2,1),
	('Jennifer','Nedumangad',7643856016 ,1,1);	

-- modified table membership_plan 
ALTER TABLE membership_plan RENAME COLUMN expiry_date to validity;
ALTER TABLE membership_plan MODIFY COLUMN validity INT NOT NULL;

-- inserting values to table membership_plan
INSERT INTO membership_plan VALUES
	('Platinum',12,15000),
	('Gold',6,8000),
	('Silver',3,5000 ),
	('Bronze',1, 2000),
    ('Expired',0,0);

	
-- modified table equipment
DROP TABLE using_equipment;
ALTER TABLE equipment MODIFY equipment_id INT(11) AUTO_INCREMENT;
CREATE TABLE using_equipment(
    member_id INTEGER,
    trainer_id INTEGER,
    equipment_id INTEGER,
    date_of_use DATETIME NOT NULL,
    PRIMARY KEY (member_id,date_of_use),
    FOREIGN KEY (member_id) REFERENCES member(member_id),
    FOREIGN KEY (trainer_id) REFERENCES trainer(trainer_id),
    FOREIGN KEY (equipment_id) REFERENCES equipment(equipment_id)
);

-- 07/04/2023
-- modified table equipment
DELETE FROM equipment;
ALTER TABLE equipment ADD column equipment_count INTEGER;
DELETE FROM equipment;	
INSERT INTO equipment(equipment_name,weight,equipment_count,gym_id) VALUES
	('Dumbbell',2,6,1),
	('Dumbbell',5,6,1),
	('Dumbbell',10,6,1),
	('Kettlebell',8,3,1),
	('Kettlebell',12,3,1),
	('Kettlebell',16,3,1),
	('Punching Bag',1,2,1),
	('Treadmill',NULL,8,1),
	('Skipping rope',NULL,5,1),
	('Smith machine',NULL,3,1),
	('Bench press machine',NULL,3,1),
	('Leg press machine',NULL,2,1),
	('Lats pulley',NULL,2,1),
	('Pull up bars',NULL,4,1),
	('Barbell',NULL,5,1),
	('EZ bar',NULL,5,1);
	
-- modified table member
ALTER TABLE member MODIFY trainer_id INTEGER;
-- inserting values to table member
INSERT INTO member(member_name,address,contact,join_date,gym_id,trainer_id,member_type) VALUES
	('Rohan','Palayam',9376843054,'2023-01-01',1,1,'Platinum'),
	('Rahul','Kowdiar',9643122032,'2023-01-02',1,2,'Gold'),
	('Shiva',NULL,9176646363,'2023-01-03',1,3,'Silver'),
	('Ajay','Pettah',8261428506,'2022-07-01',1,4,'Platinum'),
	('Karthik','Chakkai',8481814241 ,'2022-08-01',1,5,'Gold'),
	('Rayhan','Pattom',9778543651,'2021-11-17',1,6,'Bronze'),
	('Adithya','Kochuveli',7912673384,'2020-07-26',1,NULL,'Platinum'),
	('Anjali','Attingal',7112504113,'2023-11-21',1,2,'Silver'),
	('Alvin','Palayam',8158252272,'2023-01-01',1,4,'Platinum'),
	('Janet','Kattakada',9963713806,'2019-05-30',1,NULL,'Silver'),
	('Ahmed',NULL,8184177002,'2020-06-19',1,1,'Gold'),
	('Merin','Perurkada',7241506567,'2023-02-09',1,3,'Gold'),
	('Tessa','Kowdiar',7525145930,'2023-08-14',1,1,'Platinum'),
	('Ashley','Pettah',9172432533,'2020-03-23',1,NULL,'Bronze'),
	('Abel','Pattom',8229423323,'2021-01-12',1,6,'Silver');
	
-- 11/04/2023

-- inserting values into table competition

INSERT INTO competition (category_name,position,year,member_id) VALUES
("Mens Physique",3,2023,2),
("Bodybuilding",2,2022,5),
("Classic Physique",5,2021,15),
("Womens Physique",2,2023,8),
("Mens Physique",5,2023,9),
("Classic Physique",3,2020,7),
("Bodybuilding",3,2023,13),
("Bikini Physique",1,2023,12),
("Bodybuilding",3,2021,6),
("Mens Physique",4,2022,4),
("Womens Physique",2,2020,14);

-- inserting values into table gives_supplements

INSERT INTO gives_supplements VALUES
(1,1,'2023-02-12','Creatine'),
(3,3,'2023-02-12','BCAA'),
(14,NULL,'2023-02-14','Mass-Gainer'),
(9,4,'2023-02-16','Creatine'),
(4,4,'2023-02-21','L-Arginine'),
(3,3,'2023-02-22','Ashvagandha'),
(2,2,'2023-02-22','Citrulline Malate'),
(10,NULL,'2023-03-04','Creatine'),
(6,6,'2023-03-05','L-Arginine'),
(1,1,'2023-03-06','BCAA'),
(3,3,'2023-03-06','Ashvagandha'),
(8,2,'2023-03-07','Citrulline Malate'),
(12,3,'2023-03-08','Mass-Gainer'),
(9,4,'2023-03-09','Creatine');

-- inserting values into table log_book

INSERT INTO log_book VALUES
(2,'2023-03-02 13:14:07'),
(5,'2023-03-02 13:46:34'),
(14,'2023-03-03 05:32:06'),
(7,'2023-03-03 07:34:05'),
(10,'2023-03-04 05:32:23'),
(14,'2023-03-04 14:23:24'),
(1,'2023-03-04 18:45:54'),
(11,'2023-03-04 20:34:45'),
(13,'2023-03-06 05:23:45'),
(11,'2023-03-06 18:45:54'),
(2,'2023-03-07 06:56:01'),
(8,'2023-03-07 07:34:05'),
(3,'2023-03-09 08:56:44'),
(12,'2023-03-09 18:02:00'),
(4,'2023-03-10 05:23:53'),
(13,'2023-03-12 06:34:23'),
(5,'2023-03-12 12:34:23'),
(8,'2023-03-12 12:34:23'),
(9,'2023-03-13 06:34:23'),
(12,'2023-03-13 16:14:29'),
(4,'2023-03-13 19:54:45'),
(2,'2023-03-14 06:04:27'),
(6,'2023-03-14 14:56:01'),
(15,'2023-03-14 20:34:22'),
(3,'2023-03-16 06:09:10'),
(6,'2023-03-16 08:39:23'),
(12,'2023-03-17 08:33:43'),
(9,'2023-03-18 13:45:34'),
(4,'2023-03-19 08:04:56'),
(10,'2023-03-19 15:32:23');

-- inserting values into table using_equipment

INSERT INTO using_equipment VALUES
(2,2,3,'2023-03-02 13:14:07'),
(5,5,5,'2023-03-02 13:46:34'),
(14,NULL,9,'2023-03-03 05:32:06'),
(7,NULL,4,'2023-03-03 07:34:05'),
(10,NULL ,13,'2023-03-04 05:32:23'),
(14,NULL ,15,'2023-03-04 14:23:24'),
(1, 1,1,'2023-03-04 18:45:54'),
(11,1 ,16,'2023-03-04 20:34:45'),
(13, 1,13,'2023-03-06 05:23:45'),
(11, 1,11,'2023-03-06 18:45:54'),
(2, 2,11,'2023-03-07 06:56:01'),
(8, 2,10,'2023-03-07 07:34:05'),
(3, 3,8,'2023-03-09 08:56:44'),
(12, 3,3,'2023-03-09 18:02:00'),
(4, 4,9,'2023-03-10 05:23:53'),
(13,1 ,14,'2023-03-12 06:34:23'),
(5,5,11,'2023-03-12 12:34:23'),
(8, 2,9,'2023-03-12 12:34:23'),
(9, 4,6,'2023-03-13 06:34:23'),
(12, 3,2,'2023-03-13 16:14:29'),
(4, 4,15,'2023-03-13 19:54:45'),
(2, 2,14,'2023-03-14 06:04:27'),
(6, 6,8,'2023-03-14 14:56:01'),
(15, 6,11,'2023-03-14 20:34:22'),
(3, 3,16,'2023-03-16 06:09:10'),
(6, 6,7,'2023-03-16 08:39:23'),
(12, 3,15,'2023-03-17 08:33:43'),
(9, 4,2,'2023-03-18 13:45:34'),
(4, 4,1,'2023-03-19 08:04:56'),
(10, NULL,6,'2023-03-19 15:32:23');



Dbms questions :

1.	Count the number of people trained by trainer trainer_name

SELECT trainer_name,COUNT(member_id) AS 'Number of Pupil' FROM trainer
INNER JOIN member
ON trainer.trainer_id=member.trainer_id
GROUP BY trainer_name;

2.	List the details of people who have used equipment equipment_name on a_date 

SELECT DATE(date_of_use) AS "Date",member_name,equipment_name FROM using_equipment
NATURAL JOIN member
NATURAL JOIN equipment
ORDER BY date_of_use;

3.	Display the number of people subscribed to each membership in descending order of count 

SELECT type_name,COUNT(member_id) FROM member
INNER JOIN membership_plan
ON member.member_type=membership_plan.type_name
GROUP BY type_name;

4.  list members along with trainer participating in competition

SELECT member_name,trainer_name,category_name FROM competition
INNER JOIN member ON member.member_id=competition.member_id
INNER JOIN trainer ON trainer.trainer_id=member.trainer_id;

5.	Write a procedure to edit details of an equipment . Handle exception for primary key

DROP PROCEDURE IF EXISTS edit_equipment;
DELIMITER $$
CREATE PROCEDURE edit_equipment(id INTEGER,name VARCHAR(25),equipment_weight INTEGER,gym INTEGER,count INTEGER)
BEGIN
DECLARE highest_count INTEGER;
SELECT MAX(equipment_id) INTO highest_count FROM equipment;
IF id > highest_count OR id < 1 THEN
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No equipment available';
END IF;
UPDATE equipment SET equipment_name=name, weight=equipment_weight, equipment_count=count WHERE equipment_id=id;
END$$
DELIMITER ;

CALL edit_equipment(22,"Kettlebell",16,1,3);
CALL edit_equipment(6,"Kettlebell",15,1,5);


6.  Write a procedure to edit the membership plans to rejection after a time

DROP PROCEDURE IF EXISTS membership_plan_update;
DELIMITER $$
CREATE PROCEDURE membership_plan_update()
BEGIN
DECLARE plan VARCHAR(15);
DECLARE date_of_join DATE;
DECLARE expiry INTEGER;
DECLARE id INTEGER;
DECLARE f INTEGER DEFAULT 0;
DECLARE cur CURSOR FOR SELECT member_id FROM member;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET f=1;
OPEN cur;
loop1: LOOP
FETCH cur INTO id;
IF f=1 THEN
LEAVE loop1;
END IF;
SELECT member_type INTO plan FROM member WHERE member_id=id;
SELECT join_date INTO date_of_join FROM member WHERE member_id=id;
SELECT validity INTO expiry FROM membership_plan WHERE type_name=plan;
IF month(date_of_join)-month(CURDATE()) NOT BETWEEN -1*expiry AND expiry THEN
UPDATE member SET member_type="Expired",trainer_id=NULL WHERE member_id=id;
END IF;
END LOOP loop1;
CLOSE cur;
END $$
DELIMITER ;

CALL membership_plan_update();

7.	Write a function which returns list of supplements available in the gym using cursors(comma separated)

DROP FUNCTION IF EXISTS supplements;
DELIMITER $$
CREATE FUNCTION supplements()
RETURNS TEXT
DETERMINISTIC
BEGIN
DECLARE supplement VARCHAR(20);
DECLARE supplement_list TEXT DEFAULT '';
DECLARE f INTEGER DEFAULT 0;
DECLARE cur CURSOR FOR SELECT DISTINCT(supplement_name) FROM gives_supplements;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET f=1;
OPEN cur;
loop1: LOOP
FETCH cur INTO supplement;
IF f=1 THEN LEAVE loop1;
END IF;
SET supplement_list = CONCAT(supplement_list,supplement,', ');
END LOOP loop1;
CLOSE cur;
RETURN supplement_list;
END $$
DELIMITER ;

SELECT supplements();

8.	Create a view  of member names along with their trainer

DROP VIEW IF EXISTS member_trainer_view;
CREATE VIEW member_trainer_view AS 
SELECT member_name,trainer_name FROM member
INNER JOIN trainer ON member.trainer_id = trainer.trainer_id;

9.	Write a trigger to remove trainers with zero years of experience 

DROP TRIGGER IF EXISTS zero_exp;
DELIMITER $$
CREATE TRIGGER zero_exp
BEFORE INSERT ON trainer
FOR EACH ROW
BEGIN 
DELETE FROM trainer WHERE trainer_id = new.trainer_id;
END$$
DELIMITER ;

INSERT INTO trainer(trainer_name,address,contact,experience,gym_id) VALUES
('Roshan','Palayam',9446890901,0,1);
INSERT INTO trainer(trainer_name,address,contact,experience,gym_id) VALUES
('Kalyani','Nedumangaadu',9495676708,0,1);

10. Create a view of members and the suppliments they have taken and the date of date_of_intake

DROP VIEW IF EXISTS member_supplement;
CREATE VIEW member_supplement AS
SELECT member_name,supplement_name FROM member 
INNER JOIN gives_supplements ON member.member_id=gives_supplements.member_id;

11. Create a procedure to list the memebers who were in the competition in an year

DROP PROCEDURE IF EXISTS competition_member;
DELIMITER $$
CREATE PROCEDURE competition_member(in_year INTEGER)
BEGIN
SELECT member_name,category_name from member
INNER JOIN competition ON member.member_id = competition.member_id
WHERE year = in_year;
END$$
DELIMITER ;

CALL competition_member(2022);

12. Create a trigger to backup the member data to a new table

CREATE TABLE IF NOT EXISTS member_back_up(
    member_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    member_name VARCHAR(30) NOT NULL,
    join_date DATE NOT NULL,
    membership_plan VARCHAR(20) NOT NULL
);

DROP TRIGGER IF EXISTS member_back_up;
DELIMITER $$
CREATE TRIGGER member_back_up
BEFORE INSERT ON member
FOR EACH ROW
BEGIN
INSERT INTO member_back_up(member_name,join_date,membership_plan) 
VALUES (new.member_name,new.join_date,new.member_type);
END$$
DELIMITER ;

INSERT INTO member(member_name,address,contact,join_date,gym_id,trainer_id,member_type) VALUES
('Jebin','Kowdiar',9564821356,'2023-04-25',1,4,'Silver'),
('Gopika','Pappanamkodu',9223290903,'2023-04-02',1,6,'Gold');

13. List the name of members who havenot used any of the equipments

SELECT member_name FROM member 
WHERE member_id NOT IN (SELECT DISTINCT(member_id) FROM using_equipment);

14. Create a New User with only read operation provilage for all tables

CREATE USER 'viewer'@'localhost' IDENTIFIED BY 'pass';
GRANT SELECT ON fitness_data_hub.* TO 'viewer'@'localhost' WITH GRANT OPTION; 

15. List the names of members who have won medals in any category and order them by position

SELECT category_name , member_name, position,year 
FROM competition NATURAL JOIN member 
WHERE position <=3
ORDER BY position ;

16. Count the number of people that came to Gym on 4th March 2023

SELECT count(distinct member_id)
FROM log_book 
WHERE DATE(login_date) = '2023-03-04';

17. Write a function to determine the supplement that is most used in the gym using cursor

DROP FUNCTION IF EXISTS most_used_supplement;
DELIMITER $$
CREATE FUNCTION most_used_supplement()
RETURNS VARCHAR(30)
DETERMINISTIC
BEGIN
DECLARE flag INT DEFAULT 0;
DECLARE current_element VARCHAR(30);
DECLARE current_count INT;
DECLARE max_element VARCHAR(30);
DECLARE max_count INT DEFAULT 0;
DECLARE cur CURSOR FOR SELECT supplement_name, count(*) FROM gives_supplements GROUP BY supplement_name;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET flag = 1;
OPEN cur;
FETCH cur INTO current_element , current_count;
WHILE flag < 1 DO
IF current_count > max_count THEN
SET max_count = current_count;
SET max_element = current_element;
END IF;
FETCH cur INTO current_element , current_count;
END WHILE;
CLOSE cur;
RETURN max_element;	
END $$
DELIMITER ;

SELECT most_used_supplement();

18. Write a procedure to add attribute 'salary' for trainers to table trainer depending on their experience

DROP PROCEDURE IF EXISTS make_salary;
DELIMITER $$
CREATE PROCEDURE make_salary()
BEGIN
ALTER TABLE trainer ADD salary BIGINT;
UPDATE trainer set salary = experience*5000;
END $$
DELIMITER ;    

CALL make_salary();

19. Write a function to calculate current income to the gym

DROP FUNCTION IF EXISTS calculate_current_income;
DELIMITER $$
CREATE FUNCTION calculate_current_income()
RETURNS INT
DETERMINISTIC
BEGIN   
DECLARE amt INT;
DECLARE cnt INT;
DECLARE total INT DEFAULT 0;
DECLARE flag INT DEFAULT 0;
DECLARE cur CURSOR FOR SELECT amount , count(*) FROM membership_plan INNER JOIN member  ON type_name = member_type GROUP BY amount;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET flag = 1;
OPEN cur;
FETCH cur INTO amt,cnt;
WHILE flag < 1 DO
SET total = total + amt*cnt;
FETCH cur INTO amt,cnt;
END WHILE;
CLOSE cur;
RETURN total;
END $$
DELIMITER ;

SELECT calculate_current_income();    
