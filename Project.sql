CREATE TABLE citizen (
  ID int(11) NOT NULL,
  Name varchar(50) NOT NULL,
  Phone int(11) NOT NULL,
  Age int(11) NOT NULL,
  Infected bool NOT NULL,
  Infection_Date date ,
  Chronic_Disease bool ,
  Primary key (ID));

CREATE TABLE available_vaccines (
  Name varchar(15) NOT NULL,
  Global_ID int(11) NOT NULL,
  Doses int(11) NOT NULL,
  Price int(11) NOT NULL,
  Primary key (Global_ID));
  
CREATE TABLE vaccinate (
  ID int(11) ,
  Global_ID int(11),
  First_dose date,
  Second_dose date,
 Primary key (ID),
FOREIGN KEY (ID) REFERENCES citizen(id) ON DELETE CASCADE ON UPDATE CASCADE ,
FOREIGN KEY (Global_ID) REFERENCES available_vaccines(Global_ID) ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE infect (
  Infector_ID int,
  Infected_ID int,
   Primary key (Infected_ID),
  FOREIGN KEY (Infector_ID) REFERENCES citizen(id) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (Infected_ID) REFERENCES citizen(id) ON DELETE CASCADE ON UPDATE CASCADE);
  
 CREATE TABLE health_worker(Worker_ID int(11) NOT NULL,
  Hospital varchar(30) NOT NULL,
  Type_of_Work varchar(20) NOT NULL,
  Working_Hours int(11) NOT NULL,
  Priority int(10) NOT NULL,
   Primary key (Worker_ID),
   FOREIGN KEY (Worker_ID) REFERENCES citizen(id) ON DELETE CASCADE ON UPDATE CASCADE);
   
   CREATE TABLE engineer (
  Engineer_ID int(11) NOT NULL,
  Company varchar(20) DEFAULT NULL,
  Type_of_work varchar(10) DEFAULT NULL,
  Priority int(10) NOT NULL,
     primary key(Engineer_ID),
     FOREIGN KEY (Engineer_ID) REFERENCES citizen(id) ON DELETE CASCADE ON UPDATE CASCADE);
     
  CREATE TABLE journalist (
  Journalist_ID int(11) NOT NULL,
  Agency varchar(20) NOT NULL,
  City varchar(25) NOT NULL,
  Priority int(10) NOT NULL,
    primary key(Journalist_ID),
    FOREIGN KEY (Journalist_ID) REFERENCES citizen(id) ON DELETE CASCADE ON UPDATE CASCADE);
  
  CREATE TABLE professor (
  Professor_ID int(11) NOT NULL,
  Institute varchar(30) NOT NULL,
  Priority int(10) NOT NULL,
    primary key(Professor_ID),
     FOREIGN KEY (Professor_ID) REFERENCES citizen(id) ON DELETE CASCADE ON UPDATE CASCADE);
  
  CREATE TABLE vaccinated_people (
  ID int(11) NOT NULL,
  Name varchar(50) NOT NULL,
  Vaccine_Name varchar(15) NOT NULL,
  Second_Dose date ,
  primary key(ID) ,
    FOREIGN KEY (ID) REFERENCES citizen(id) ON DELETE CASCADE ON UPDATE CASCADE);
   
   CREATE TABLE vaccinate2 (
  ID int(11) ,
  Global_ID int(11) default 0 ,
     boost bool default false,
   Primary key (ID),
   FOREIGN KEY (ID) REFERENCES vaccinated_people(id) ON DELETE CASCADE ON UPDATE CASCADE ,
FOREIGN KEY (Global_ID) REFERENCES available_vaccines(Global_ID) ON DELETE CASCADE ON UPDATE CASCADE);