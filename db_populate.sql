--------------------------------------------------- POPULATE -----------------------------------------------------

------------------------ Pais ---------------------------------
-- PIN default é 0000 encriptado com SHA-1
insert into pai(nome,pin) values ('Pai', '39dfa55283318d31afe5a3ff4a0e3253e2045e43');
insert into pai(nome,pin) values ('Mãe', '39dfa55283318d31afe5a3ff4a0e3253e2045e43');

------------------------ Filhos -------------------------------
insert into filho(nome,habilidade) values ('Diogo',3);
insert into filho(nome,habilidade) values ('Francisco',3);
insert into filho(nome,habilidade) values ('Joana',2);
insert into filho(nome,habilidade) values ('Sofia',2);
insert into filho(nome,habilidade) values ('Afonso',2);
insert into filho(nome,habilidade) values ('Marta',1);

----------------------- Tarefas -------------------------------
-- Vão sendo populadas ao longo do uso!
---------------------------------------------------------------

----------------------- Atribuições ---------------------------
-- Vão sendo populadas ao longo do uso!
---------------------------------------------------------------