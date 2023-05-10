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
	('Bronze',1, 2000);

	
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

-- inserting values to table equipment
INSERT INTO equipment(equipment_name,weight,gym_id) VALUES
	('Dumbbell',2,1),
	('Dumbbell',5,1),
	('Dumbbell',10,1),
	('Kettlebell',8,1),
	('Kettlebell',12,1),
	('Kettlebell',16,1),
	('Punching Bag',1,1),
	('Treadmill',NULL,1),
	('Skipping rope',NULL,1),
	('Smith machine',NULL,1),
	('Bench press machine',NULL,1),
	('Leg press machine',NULL,1),
	('Lats pulley',NULL,1),
	('Pull up bars',NULL,1),
	('Barbell',NULL,1),
	('EZ bar',NULL,1);

	
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
	
--11/04/2023

--inserting values into table competition

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

--inserting values into table gives_supplements

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

--inserting values into table log_book

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

--inserting values into table using_equipment

INSERT INTO using_equipment VALUES
(2,2,19,'2023-03-02 13:14:07'),
(5,5,17,'2023-03-02 13:46:34'),
(14,NULL,29,'2023-03-03 05:32:06'),
(7,NULL,22,'2023-03-03 07:34:05'),
(10,NULL ,27,'2023-03-04 05:32:23'),
(14,NULL ,23,'2023-03-04 14:23:24'),
(1, 1,31,'2023-03-04 18:45:54'),
(11,1 ,23,'2023-03-04 20:34:45'),
(13, 1,19,'2023-03-06 05:23:45'),
(11, 1,23,'2023-03-06 18:45:54'),
(2, 2,32,'2023-03-07 06:56:01'),
(8, 2,24,'2023-03-07 07:34:05'),
(3, 3,31,'2023-03-09 08:56:44'),
(12, 3,32,'2023-03-09 18:02:00'),
(4, 4,25,'2023-03-10 05:23:53'),
(13,1 ,19,'2023-03-12 06:34:23'),
(5,5,29,'2023-03-12 12:34:23'),
(8, 2,28,'2023-03-12 12:34:23'),
(9, 4,28,'2023-03-13 06:34:23'),
(12, 3,18,'2023-03-13 16:14:29'),
(4, 4,31,'2023-03-13 19:54:45'),
(2, 2,32,'2023-03-14 06:04:27'),
(6, 6,31,'2023-03-14 14:56:01'),
(15, 6,27,'2023-03-14 20:34:22'),
(3, 3,23,'2023-03-16 06:09:10'),
(6, 6,20,'2023-03-16 08:39:23'),
(12, 3,30,'2023-03-17 08:33:43'),
(9, 4,25,'2023-03-18 13:45:34'),
(4, 4,29,'2023-03-19 08:04:56'),
(10, NULL,27,'2023-03-19 15:32:23');



Dbms questions :

	2.	Count the number of people trained by trainer trainer_name
	3.	List the details of people who have used equipment equipment_name on a_date 
	4.	Display the number of people subscribed to each membership in descending order of count 
    12.  list members along with trainer participating in competition
    16.  To calculate the monthly income to the gym    

    5.	Write a procedure to edit details of an equipment . Handle exception for primary key
    13.  write a procedure to edit the membership plans to rejection after a time

    6.	Write a function which returns list of supplements available in the gym using cursors(comma separated)
	10.	Write a function to create a view  of member names along with their trainer

    7.	Write a trigger to remove trainers with zero years of experience 
	8.	Write a trigger to remove members with no subscription plan 
	9.	Write a trigger to capitalise the first letter of member name if it is lowercase 
    14.  write a trigger to remove  members that have  expired their plan
