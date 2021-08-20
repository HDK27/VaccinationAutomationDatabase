#These data must be added in the schema creation tab and not in the query tab# 

#Inserting data into citizen relation#

insert into citizen (id, name, phone, age, infected, infection_date, chronic_disease) values (1, 'Dr. Ahmad Fadlallah', '00112233', 40, false, null, false);
insert into citizen (id, name, phone, age, infected, infection_date, chronic_disease) values (2, 'Alex Lidbetter', '00115566', 30, false, NULL, true);
insert into citizen (id, name, phone, age, infected, infection_date, chronic_disease) values (3, 'Mustafa Qasir', '00125896', 45, false, NULL, true);
insert into citizen (id, name, phone, age, infected, infection_date, chronic_disease) values (4, 'Hadi Jaber', '00325478', 56, true, '2021/05/8', true);
insert into citizen (id, name, phone, age, infected, infection_date, chronic_disease) values (5, 'Adel haj Hassan', '00325412', 70, true, '2021/01/20', false);
insert into citizen (id, name, phone, age, infected, infection_date, chronic_disease) values (6, 'Wafik Zahwa', '03215689', 80, true, '2020/10/6', true);
insert into citizen (id, name, phone, age, infected, infection_date, chronic_disease) values (7, 'Dani Zeineddine', '01236578', 22, false, null, false);
insert into citizen (id, name, phone, age, infected, infection_date, chronic_disease) values (8, 'Hussein kazem', '12658974', 85, false, null, true);

#Inserting data into journalist relation#
insert into journalist (Journalist_ID, Agency, city, priority) values (5, 'LBC', 'beirut', 5);
insert into journalist (Journalist_ID, Agency, city, priority) values (6, 'BEIN Sports', 'beirut', 8);

#Inserting data into health_worker relation#               
insert into health_worker (Worker_ID,Hospital, type_of_work,working_hours , priority) values (6,'AUB MC', 'COVID-19 Dep', '10', 10);                 

#Inserting data into engineer relation#
insert into engineer (Engineer_ID,Company,Type_of_work,Priority) values (7,'Murex','Programmer',4);
insert into engineer (Engineer_ID,Company,Type_of_work,Priority) values (8,'LAU MC','Biomedical',9);   

#Inserting data into professor relation#               
insert into professor (Professor_ID,Institute,Priority) values (1,'ULFG 3',10);        

#Inserting data into available_vaccines relation#               
insert into available_vaccines (Name,Global_ID,Doses,Price) values ('pfizer', 1, 105,22);
insert into available_vaccines (Name,Global_ID,Doses,Price) values ('astrazeneca', 2, 75,25);
insert into available_vaccines (Name,Global_ID,Doses,Price) values ('Sputnik V', 3, 115,25);
insert into available_vaccines (Name,Global_ID,Doses,Price) values ('moderna', 4, 120,20);
insert into available_vaccines (Name,Global_ID,Doses,Price) values ('Johnson&Johnson', 5, 80,15);

#Inserting data into vaccinate relation(vaccinating citizens)#
insert into vaccinate (id, global_id, first_dose,second_dose) values (5, 1, '2021/06/01',null);
insert into vaccinate (id, global_id, first_dose,second_dose) values (4, 1, '2021/06/21',null);
insert into vaccinate (id, global_id, first_dose,second_dose) values (3, 2, '2021/05/15',null);
insert into vaccinate (id, global_id, first_dose,second_dose) values (6, 3, '2021/03/16','2021/05/16');
insert into vaccinate (id, global_id, first_dose,second_dose) values (7, 1, '2021/04/17','2021/05/13');

#Inserting data into infect relation#
insert into infect(Infector_ID ,Infected_ID) values (1,5);
insert into infect(Infector_ID ,Infected_ID) values (1,2);
insert into infect(Infector_ID ,Infected_ID) values (1,3);
insert into infect(Infector_ID ,Infected_ID) values (5,6);
insert into infect(Infector_ID ,Infected_ID) values (6,8);

#Updating second dose date for a citizen,thus giving him the second dose#
UPDATE vaccinate v SET v.second_dose='2021/06/1' where v.id=3;              

#Copying all fully vaccinated people from citizen to vaccinated_people#
INSERT INTO vaccinated_people  SELECT c.id,c.name as citizen_name,a.name,v.second_dose FROM citizen c,available_vaccines a,vaccinate v WHERE c.id=v.id and v.global_id=a.global_id and v.second_dose is not null and datediff('2021/06/24',v.second_dose)>15;

#inserting data to vaccinate2#               
insert into vaccinate2 select a.id,null,null from vaccinated_people a;