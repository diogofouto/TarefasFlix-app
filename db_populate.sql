-- -----------------------------------------------------------------------------------------
--															 HOUSEHOLD CHORES DB POPULATE
--
--		created: 			 20/12/2020
--		last modified: 23/12/2020
--		by: 				 	 Diogo
-- -----------------------------------------------------------------------------------------

------------------------ Pais ---------------------------------
-- PIN default é 0000 encriptado com SHA-1
insert into supervisor(name, pin) values ('Pai', '39dfa55283318d31afe5a3ff4a0e3253e2045e43');
insert into supervisor(name, pin) values ('Mãe', '39dfa55283318d31afe5a3ff4a0e3253e2045e43');

------------------------ Filhos -------------------------------
insert into agent(name) values ('Diogo');
insert into agent(name) values ('Francisco');
insert into agent(name) values ('Joana');
insert into agent(name) values ('Sofia');
insert into agent(name) values ('Afonso');
insert into agent(name) values ('Marta');

----------------------- Tarefas -------------------------------
insert into task (description, difficulty) values ('Aspirar o Clio', 2);
insert into task (description, difficulty) values ('Varrer cozinha', 1);
insert into task (description, difficulty) values ('Passear a NaNa', 3);

----------------------- Atribuições ---------------------------
insert into assignment (agent,task,deadline_date,supervisor,reward) values ('Diogo','Aspirar o Clio','2020-02-02','Pai','Comer arroz');
insert into assignment (agent,task,deadline_date,supervisor) values ('Diogo','Varrer cozinha','2020-02-04','Mãe');
insert into assignment (agent,task,deadline_date,supervisor) values ('Diogo','Passear a NaNa','2020-02-05','Mãe');