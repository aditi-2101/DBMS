CREATE TABLE driver(
    d_name VARCHAR(20) NOT NULL,
    car_no INT,
    d_country VARCHAR(20),
    best_finish INT DEFAULT 0,
    no_wins INT DEFAULT 0,
    t_name VARCHAR(50) NOT NULL,
    PRIMARY KEY(car_no),
    CHECK(car_no>=0 AND car_no<100),
    CHECK(best_finish>=1 AND best_finish<=10),
    CHECK(no_wins>=0),
    FOREIGN KEY (t_name) REFERENCES team(t_name) ON DELETE CASCADE
);
 DROP TABLE driver;
 DESCRIBE driver;

 ALTER TABLE driver
 ADD COLUMN no_dnf INT DEFAULT 0;

CREATE TABLE team(
    t_name VARCHAR(50),
    t_country VARCHAR(20) NOT NULL,
    principal VARCHAR(20) NOT NULL,
    t_points INT DEFAULT 0,
    PRIMARY KEY(t_name),
    CHECK(t_points>=0)
);
DROP TABLE team;
DESCRIBE TABLE team;

CREATE TABLE race(
    r_name VARCHAR(50),
    w_name VARCHAR(20) DEFAULT NULL,
    laps INT DEFAULT 1,
    circuit VARCHAR(100),
    place VARCHAR(25),
    PRIMARY KEY(r_name),
    CHECK(laps>0)
);

DROP TABLE race;
DESCRIBE TABLE race;



CREATE TABLE lap_len(
    laps INT,
    len DECIMAL(2,1),
    PRIMARY KEY(laps),
    CHECK(laps>0),
    CHECK(len>0)

);

DROP TABLE lap_len;
DESCRIBE TABLE lap_len;


CREATE TABLE car(
    model VARCHAR(10),
    c_engine VARCHAR(20),
    t_name VARCHAR(50), 
    car_no INT ,
    PRIMARY KEY(model),
    CHECK(car_no>=0 AND car_no<100),
    FOREIGN KEY (t_name) REFERENCES team(t_name) ON DELETE CASCADE,
    FOREIGN KEY (car_no) REFERENCES driver(car_no) ON DELETE CASCADE
);
ALTER TABLE car
ADD COLUMN car_no_2 INT NOT NULL,
ADD FOREIGN KEY (car_no_2) REFERENCES driver(car_no) ON DELETE CASCADE;
DROP TABLE car;
DESCRIBE TABLE car;

CREATE TABLE compete(
    car_no INT,
    model VARCHAR (10),
    r_name VARCHAR (50),
    r_points INT,
    PRIMARY KEY(car_no,r_name,model),
    CHECK(car_no>=0 AND car_no<100),
    FOREIGN KEY (car_no) REFERENCES driver(car_no) ON DELETE CASCADE,
    FOREIGN KEY (r_name) REFERENCES race(r_name) ON DELETE CASCADE,
    FOREIGN KEY (model) REFERENCES car(model) ON DELETE CASCADE
);

DROP TABLE compete;
DESCRIBE TABLE compete;

CREATE TABLE car_mod(
    car_no INT,
    model VARCHAR(10),
    PRIMARY KEY(car_no),
    CHECK(car_no>=0 AND car_no<100),
    FOREIGN KEY (model) REFERENCES car(model) ON DELETE CASCADE,
    FOREIGN KEY (car_no) REFERENCES driver(car_no) ON DELETE CASCADE
);

DROP TABLE car_mod;
DESCRIBE TABLE car_mod;

CREATE TABLE fastest_lap(
    d_name VARCHAR(20),
    r_name VARCHAR(50),
    d_time TIME(3),
    PRIMARY KEY(d_name,r_name),    
    FOREIGN KEY (r_name) REFERENCES race(r_name) ON DELETE CASCADE
);

DROP TABLE fastest_lap;
DESCRIBE TABLE fastest_lap;




INSERT INTO team(t_name,t_country,principal,t_points) VALUES('Ferrari','Italy','Matt',DEFAULT);
INSERT INTO team(t_name,t_country,principal,t_points) VALUES('Redbull','Austria','Chris',DEFAULT);
INSERT INTO team(t_name,t_country,principal,t_points) VALUES('Renault','France','Cyril',DEFAULT);
INSERT INTO team(t_name,t_country,principal,t_points) VALUES('Toro Rosso','Italy','Franz',DEFAULT);
INSERT INTO team(t_name,t_country,principal,t_points) VALUES('MvLaren','Britain','Zak',DEFAULT);

DELETE FROM team WHERE t_name='MvLaren';
INSERT INTO team(t_name,t_country,principal,t_points) VALUES('McLaren','Britain','Zak',DEFAULT);

SELECT * FROM team;

INSERT INTO race VALUES ('2019 SINGAPORE GP','Seb',56,'Marina Bay Circuit','Singapore');
INSERT INTO race VALUES ('2019 ITALIAN GP','Charles',53,'Monza Circuit','Monza');
INSERT INTO race VALUES ('2019 BELGIAN GP','Charles',44,'Spa','Stavelot');
INSERT INTO race VALUES ('2019 BRAZILIAN GP','Max',71,'Jose Carlos Circuit','Sao Paulo');
INSERT INTO race VALUES ('2019 AUSTRIAN GP','Max',71,'Redbull Ring','Speilberg');

SELECT * FROM race;

INSERT INTO lap_len VALUES(56,5.0);
INSERT INTO lap_len VALUES(53,5.7);
INSERT INTO lap_len VALUES(44,7);
INSERT INTO lap_len VALUES(71,4.3);

SELECT * FROM lap_len;

INSERT INTO driver VALUES('Seb',5,'Germany',1,1,'Ferrari',1);
INSERT INTO driver VALUES('Charles',16,'Monaco',1,2,'Ferrari',1);
INSERT INTO driver VALUES('Max',33,'Netherlands',1,2,'Redbull',1);
INSERT INTO driver VALUES('Alex',23,'Britain',3,0,'Redbull',0);
INSERT INTO driver VALUES('Daniel',3,'Australia',2,0,'Renault',0);
INSERT INTO driver VALUES('Nico',27,'Germany',3,0,'Renault',0);
INSERT INTO driver VALUES('Pierre',10,'France',2,0,'Toro Rosso',0);
INSERT INTO driver VALUES('Kvyat',26,'Russia',4,0,'Toro Rosso',1);
INSERT INTO driver VALUES('Norris',4,'Britain',4,0,'McLaren',0);
INSERT INTO driver VALUES('Carlos',55,'Spain',3,0,'McLaren',2);

SELECT * FROM driver;

INSERT INTO car VALUES ('SF90','Ferrari engine','Ferrari',5,16);
INSERT INTO car VALUES ('RB15','Honda engine','Redbull',33,23);
INSERT INTO car VALUES ('RS19','Renault engine','Renault',3,27);
INSERT INTO car VALUES ('SRT14','Honda engine','Toro Rosso',10,26);
INSERT INTO car VALUES ('MCL34','Renault engine','McLaren',4,55);

SELECT * FROM car;


DESCRIBE TABLE fastest_lap;
INSERT INTO fastest_lap VALUES('Kvyat','2019 SINGAPORE GP','00:1:44.377');
INSERT INTO fastest_lap VALUES('Seb','2019 ITALIAN GP','00:1:22.799');
INSERT INTO fastest_lap VALUES('Seb','2019 BELGIAN GP','00:1:46.409');
INSERT INTO fastest_lap VALUES('Max','2019 BRAZILIAN GP','00:1:10.862');
INSERT INTO fastest_lap VALUES('Max','2019 AUSTRIAN GP','00:1:07.475');

SELECT * FROM fastest_lap;

DESCRIBE TABLE compete;
INSERT INTO compete VALUES('5','SF90','2019 SINGAPORE GP',10);
INSERT INTO compete VALUES('16','SF90','2019 SINGAPORE GP',8);
INSERT INTO compete VALUES('33','RB15','2019 SINGAPORE GP',6);
INSERT INTO compete VALUES('23','RB15','2019 SINGAPORE GP',4);
INSERT INTO compete VALUES('3','RS19','2019 SINGAPORE GP',0);
INSERT INTO compete VALUES('27','RS19','2019 SINGAPORE GP',0);
INSERT INTO compete VALUES('10','SRT14','2019 SINGAPORE GP',0);
INSERT INTO compete VALUES('26','SRT14','2019 SINGAPORE GP',0);
INSERT INTO compete VALUES('4','MCL34','2019 SINGAPORE GP',2);
INSERT INTO compete VALUES('55','MCL34','2019 SINGAPORE GP',0);

INSERT INTO compete VALUES('5','SF90','2019 ITALIAN GP',0);
INSERT INTO compete VALUES('16','SF90','2019 ITALIAN GP',10);
INSERT INTO compete VALUES('33','RB15','2019 ITALIAN GP',2);
INSERT INTO compete VALUES('23','RB15','2019 ITALIAN GP',4);
INSERT INTO compete VALUES('3','RS19','2019 ITALIAN GP',8);
INSERT INTO compete VALUES('27','RS19','2019 ITALIAN GP',6);
INSERT INTO compete VALUES('10','SRT14','2019 ITALIAN GP',0);
INSERT INTO compete VALUES('26','SRT14','2019 ITALIAN GP',0);
INSERT INTO compete VALUES('4','MCL34','2019 ITALIAN GP',0);
INSERT INTO compete VALUES('55','MCL34','2019 ITALIAN GP',0);

INSERT INTO compete VALUES('5','SF90','2019 BELGIAN GP',8);
INSERT INTO compete VALUES('16','SF90','2019 BELGIAN GP',10);
INSERT INTO compete VALUES('33','RB15','2019 BELGIAN GP',0);
INSERT INTO compete VALUES('23','RB15','2019 BELGIAN GP',6);
INSERT INTO compete VALUES('3','RS19','2019 BELGIAN GP',0);
INSERT INTO compete VALUES('27','RS19','2019 BELGIAN GP',2);
INSERT INTO compete VALUES('10','SRT14','2019 BELGIAN GP',0);
INSERT INTO compete VALUES('26','SRT14','2019 BELGIAN GP',4);
INSERT INTO compete VALUES('4','MCL34','2019 BELGIAN GP',0);
INSERT INTO compete VALUES('55','MCL34','2019 BELGIAN GP',0);

INSERT INTO compete VALUES('5','SF90','2019 BRAZILIAN GP',0);
INSERT INTO compete VALUES('16','SF90','2019 BRAZILIAN GP',0);
INSERT INTO compete VALUES('33','RB15','2019 BRAZILIAN GP',10);
INSERT INTO compete VALUES('23','RB15','2019 BRAZILIAN GP',0);
INSERT INTO compete VALUES('3','RS19','2019 BRAZILIAN GP',4);
INSERT INTO compete VALUES('27','RS19','2019 BRAZILIAN GP',0);
INSERT INTO compete VALUES('10','SRT14','2019 BRAZILIAN GP',8);
INSERT INTO compete VALUES('26','SRT14','2019 BRAZILIAN GP',0);
INSERT INTO compete VALUES('4','MCL34','2019 BRAZILIAN GP',2);
INSERT INTO compete VALUES('55','MCL34','2019 BRAZILIAN GP',6);

INSERT INTO compete VALUES('5','SF90','2019 AUSTRIAN GP',6);
INSERT INTO compete VALUES('16','SF90','2019 AUSTRIAN GP',8);
INSERT INTO compete VALUES('33','RB15','2019 AUSTRIAN GP',10);
INSERT INTO compete VALUES('23','RB15','2019 AUSTRIAN GP',0);
INSERT INTO compete VALUES('3','RS19','2019 AUSTRIAN GP',0);
INSERT INTO compete VALUES('27','RS19','2019 AUSTRIAN GP',0);
INSERT INTO compete VALUES('10','SRT14','2019 AUSTRIAN GP',2);
INSERT INTO compete VALUES('26','SRT14','2019 AUSTRIAN GP',0);
INSERT INTO compete VALUES('4','MCL34','2019 AUSTRIAN GP',4);
INSERT INTO compete VALUES('55','MCL34','2019 AUSTRIAN GP',0);

SELECT * FROM compete;

INSERT INTO car_mod VALUES (5,'SF90');
INSERT INTO car_mod VALUES (16,'SF90');
INSERT INTO car_mod VALUES (33,'RB15');
INSERT INTO car_mod VALUES (23,'RB15');
INSERT INTO car_mod VALUES (3,'RS19');
INSERT INTO car_mod VALUES (27,'RS19');
INSERT INTO car_mod VALUES (10,'SRT14');
INSERT INTO car_mod VALUES (26,'SRT14');
INSERT INTO car_mod VALUES (4,'MCL34');
INSERT INTO car_mod VALUES (55,'MCL34');

SELECT * FROM car_mod;

--PODIUM FINISHERS IN EACH RACE
SELECT compete.r_name,compete.car_no,driver.d_name,compete.r_points
FROM driver
INNER JOIN compete ON
driver.car_no=compete.car_no AND compete.r_points>=6
ORDER BY r_name,r_points DESC;


--DRIVERS WHO HAVE FINISHED IN THE TOP 3
SELECT DISTINCT d_name,best_finish
FROM driver 
WHERE driver.car_no IN (
    SELECT car_no 
    FROM compete 
    WHERE r_points>=6 )
    ORDER BY best_finish,d_name;


--FIND THE WINNER
SELECT d_name, car_no,t_name
FROM driver 
WHERE driver.car_no IN (
    SELECT car_no FROM(
        SELECT car_no, 
        SUM(r_points)
        FROM compete
        GROUP BY car_no
        order by sum(r_points) desc
        limit 1
        )AS T
    );


--AVERAGE POINTS OF DRIVER PER RACE
SELECT car_no, 
AVG(r_points) as Average
FROM compete
GROUP BY car_no
ORDER by AVG(r_points) desc;

--TEAM POINTS
SELECT car.t_name, T2.Team_points
FROM car 
LEFT OUTER JOIN 
(   SELECT model, SUM(r_points) AS Team_points
    FROM compete
    GROUP BY model
) T2 ON car.model = T2.model
ORDER BY  T2.Team_points DESC;

--TRIGGER
CREATE TABLE trigger_test(
    message VARCHAR(200)
);

DELIMITER $$
CREATE 
    TRIGGER race_insert_new BEFORE INSERT
    ON race
        FOR EACH ROW BEGIN
            IF NEW.w_name IN (SELECT DISTINCT w_name FROM race) THEN
                INSERT INTO trigger_test VALUES('race updated. No new winner');
            ELSE
                INSERT INTO trigger_test VALUES('race updated. new winner');
                INSERT INTO trigger_test VALUES(NEW.w_name);
            END IF;
    END$$

  
DELIMITER;

INSERT INTO race VALUES('2019 HUNGARIAN GP','Norris',59,'Hungaroring','hungary');
INSERT INTO race VALUES('2019 CANADIAN GP','Seb',52,'gilles villneuve circuit','montreal');

DELETE FROM race WHERE w_name='Norris';
SELECT * FROM race;
drop table trigger_test;
select * from trigger_test;

select * from team;
ALTER TABLE team DROP COLUMN t_points;


SELECT  distinct * FROM race 
NATURAL JOIN lap_len 
NATURAL JOIN compete 
NATURAL JOIN driver 
NATURAL JOIN team
NATURAL JOIN car
;

SELECT * FROM lap_len 
NATURAL JOIN race
Left OUTER JOIN driver on ;

--lossless join
select * from driver
natural join race
natural join lap_len
natural join team
natural join compete
left outer join car on compete.model=car.model;
left OUTER join fastest_lap on compete.r_name= fastest_lap.r_name;


select * from compete 
left join car ;

--query using outer join

--drivers who havent set fastest lap
select distinct t2.d_name from  
(select r_name,d_time,driver.d_name
from fastest_lap
right outer join driver
on fastest_lap.d_name=driver.d_name)as t2
where t2.r_name is null
and t2.d_time is null
 ;

select r_name,d_time,driver.d_name
from fastest_lap
right outer join driver
on fastest_lap.d_name=driver.d_name;