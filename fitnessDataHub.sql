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

CREATE TABLE gives_suppliments(
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
ALTER TABLE membership_plan MODIFY COLUMN validity INTEGER NOT NULL;

-- inserting values to table membership_plan
INSERT INTO membership_plan VALUES
	('Platinum',12,15000),
	('Gold',6,8000),
	('Silver',3,5000 ),
	('Bronze',1, 2000);

	
-- modified table equipment
DROP TABLE using_equipment;
ALTER TABLE equipment MODIFY equipment_id INTEGER(11) AUTO_INCREMENT;
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
ALTER TABLE equipment ADD column equipment_count INT(11);	
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

-- inserting values to table member
-- getting an error ERROR 1048 (23000): Column 'trainer_id' cannot be null
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
	









