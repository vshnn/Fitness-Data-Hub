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
	('Dumbbell',8,1),
	('Dumbbell',10,1),
	('Dumbbell',20,1),

	('Dumbbell',1,1),
	('Dumbbell',1,1),
	('Barbell',NULL,1),
	('EZ bar',NULL,1),
	('Kettlebell',8,1),
	('Kettlebell',12,1),
	('Kettlebell',16,1),
	
	
	
	


























