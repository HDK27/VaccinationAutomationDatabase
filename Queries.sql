#Remark:in case of an INSERT or UPDATE query,it must be wirtten in the schema builder tab and not in the query tab#

#Inserting a citizen:#

#1)Normal citizen:#
INSERT INTO citizen (id, name, phone, age, infected, infection_date, chronic_disease) values (8, 'Hussein kazem', '71001320', 85, false, null, true);

#2)Worker citizen: example on professors:#
INSERT INTO citizen (id, name, phone, age, infected, infection_date, chronic_disease) values (1, 'Dr. Ahmad Fadlallah', '70860230', 40, false, null, false);

INSERT INTO professor (Professor_ID,Institute,Priority) values (1,'ULFG 3',10);

#Display all the citizens registered in the official platform:# 
SELECT * FROM Citizen;

#Display journalists, health workers, professors,engineers:#
SELECT * FROM citizen where id in (select professor_id from professor);
SELECT * FROM citizen where id in (select worker_id from health_worker); 
SELECT * FROM citizen where id in (select journalist_id from journalist);
SELECT * FROM citizen where id in (select engineer_id from engineer);

#If we want to include the type of work and place:#
SELECT DISTINCT c.*,e.Company,e.Type_of_work FROM citizen c,engineer e where c.id=e.engineer_id;

#Display all the targeted citizens to be vaccinated depending on a minimum age(here is 60) and approved to be vaccinated:# 

SELECT * FROM citizen c where age>60 and (infected <> true OR datediff('2021/06/28',Infection_Date)>90) and c.id not in (Select v.id from vaccinate v );

#datediff() function returns the answer in days of the difference of the 2 inputs. The first input is our current day.#
#To be vaccinated, a citizen must :#
#Be at least at a specified age (can be changed in the queries). #
#Must be recovered from the infection (if he was infected) from at least 3 months ago.#

#Vaccinating the upper targeted citizens with the pfizer vaccine (for example),we just need to insert the information in the vaccinate entity after decrementing the number of available doses in the pfizer vaccine:#
UPDATE available_vaccines a SET a.doses=a.doses-(select count(c.id) FROM citizen c where age>60 and (infected <> true OR datediff('2021/06/28',Infection_Date)>90) and c.id not in (Select v.id from vaccinate v )) where a.global_id=1 ;

INSERT INTO vaccinate SELECT c.id,1,'2021/06/25',null FROM citizen c where age>60 and (infected <> true OR datediff('2021/06/28',Infection_Date)>90) and c.id not in (Select v.id from vaccinate v ) ;

#Display all the targeted citizens to be vaccinated depending on the type of work after combining and comparing the citizen entity with a job entity and collecting a successful match, and listing them depending on a specified priority:# 

SELECT c.*,j.priority FROM citizen c,professor j where c.id in (select professor_id from professor) and j.professor_id=c.id ORDER BY j.priority DESC; 

SELECT c.*,j.priority FROM citizen c,health_worker j where c.id in (select worker_id from health_worker) and j.worker_id=c.id ORDER BY j.priority DESC; 

SELECT c.*,j.priority FROM citizen c, journalist j where c.id in (select journalist_id from journalist) and j.journalist_id=c.id ORDER BY j.priority DESC; 

SELECT c.*,j.priority FROM citizen c,engineer j where id in (select engineer_id from engineer) and j.engineer_id=c.id ORDER BY j.priority DESC;

#Changing the data of the Citizen entity for a citizen after taking the first dose ( marking the date of taking the 1st dose):# 

INSERT INTO vaccinate (id, global_id, first_dose,second_dose) values (5, 1, '2021/05/26',null);

#Changing the data of a citizen after taking the second dose(marking the date of the second dose): let’s take an example:#
UPDATE vaccinate v SET v.second_dose='2021/06/1' where v.id=3; 

#Display all the targeted citizens to be vaccinated with a second dose after 21 days of the first dose:#

SELECT * FROM citizen c,vaccinate v where c.id=v.id and v.second_dose is null and v.first_dose is not null and  datediff('2021/06/24',v.first_dose)>20;

#Displaying name,age, date of first and second dose and vaccine type taken by citizens:# 

SELECT c.name,c.age,k.First_dose,k.second_dose,l.name as Vaccine_Type FROM citizen c,vaccinate k,available_vaccines l where c.id=k.id and l.Global_ID=k.Global_ID;

#Each citizen that has taken 2 doses must be added to the table vaccinated_people after 15 days of the second dose: #

INSERT INTO vaccinated_people SELECT c.id,c.name as citizen_name,a.name,v.second_dose FROM citizen c,available_vaccines a,vaccinate v WHERE c.id=v.id and v.global_id=a.global_id and v.second_dose is not null and datediff('2021/06/24',v.second_dose)>15;

#Viewing fully vaccinated people:#
SELECT * FROM vaccinated_people;

#Adding information to vaccinate2:#

INSERT INTO vaccinate2 SELECT a.id,null,null from vaccinated_people a; 

#Checking citizens that need a boost after 6 months of the second dose:#

SELECT p.* from vaccinated_people p,vaccinate2 v where v.global_id is null and v.boost is null and p.id=v.id;




#Counting the number of doses taken by each vaccine : #

SELECT count(c.name),l.name as Vaccine_Type FROM citizen c,vaccinate k,available_vaccines l WHERE c.id=k.id AND l.Global_ID=k.Global_ID GROUP BY l.name;

#Calculating the % of vaccination efficacy after taking 2 doses:(probability of being infected meanwhile we have taken 2 doses)#

SELECT (count(infected_id)/(select (count(vaccinate.id)) from vaccinate))*100 as vaccination_efficacy_in_percent FROM infect,vaccinate where infect.Infected_ID=vaccinate.id and (vaccinate.first_dose is not null and vaccinate.second_dose is not null);

#Calculating the % of vaccination efficacy after taking 1 dose: (probability of being infected meanwhile we have taken 1 dose)#

SELECT (count(infected_id)/(select (count(vaccinate.id)) from vaccinate))*100 as vaccination_efficacy_in_percent FROM infect,vaccinate where infect.Infected_ID=vaccinate.id and (vaccinate.first_dose is not null and vaccinate.second_dose is null);

#Calculating the % of covid spreading after taking 2 doses (probability of a person to infect others meanwhile this person has taken 2 doses)#

select (count(infector_id)/(select (count(vaccinate.id)) from vaccinate))*100 as vaccination_spreding_efficacy_in_percent from infect,vaccinate where infect.Infector_ID=vaccinate.id and (vaccinate.first_dose is not null and vaccinate.second_dose is not null);

#Calculating the % of covid spreading after taking 1 dose (probability of a person to infect others meanwhile this person has taken 1 dose)#

SELECT (count(infector_id)/(select (count(vaccinate.id)) from vaccinate))*100 as vaccination_spreding_efficacy_in_percent FROM infect,vaccinate where infect.Infector_ID=vaccinate.id and (vaccinate.first_dose is not null and vaccinate.second_dose is null);

