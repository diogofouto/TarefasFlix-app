-- -----------------------------------------------------------------------------------------
--															 HOUSEHOLD CHORES DB SCHEMA
--
--		created: 			 20/12/2020
--		last modified: 23/12/2020
--		by: 				 	 Diogo
-- -----------------------------------------------------------------------------------------

-- -------------------------------------------------------------------------------
-- Remove previous tables
-- -------------------------------------------------------------------------------
drop table pai cascade;
drop table filho cascade;
drop table tarefa cascade;
drop table realiza cascade;


-- -------------------------------------------------------------------------------
-- Create tables
-- -------------------------------------------------------------------------------
create table pai (
	nome varchar(5)
	check(nome in ("Pai", "Mãe")),
	pin varchar(100),
	primary key(nome)
);
-- Os pins (4 dígitos) são encriptados com SHA-1 (daí o varchar(100))

create table filho ( 
  nome varchar(10),
  pontuacao integer default 0,
  habilidade integer
  check(habilidade in (1,2,3)),
  primary key(nome)
);

create table tarefa ( 
  descricao varchar(50),
  criador varchar(5),
  dificuldade integer
  check(dificuldade in (1,2,3)),
  primary key(descricao),
  foreign key(criador) references pai(nome) on delete cascade on update cascade
);

create table realiza ( 
  id serial,
  filho varchar(10),
  tarefa varchar(50),
  data_registo date not null default current_date,
  data_conclusao date not null,
  supervisor varchar(10),
  status varchar(15) default 'para fazer'
  check(status in ('a fazer', 'feito', 'para fazer')),
  recompensa varchar(50),
  primary key(id),
  foreign key(filho) references filho(nome) on delete cascade on update cascade,
  foreign key(tarefa) references tarefa(descricao) on delete cascade on update cascade
);


-- -------------------------------------------------------------------------------------
-- RI 1 - trigger to add points once realiza.status = 'feito'
-- -------------------------------------------------------------------------------------
drop trigger if exists add_points on realiza;

create or replace function add_points_proc()
returns trigger as
$$
begin
	-- Se a tarefa estiver feita, incrementar pontuacao do filho
  if new.status = 'feito' then
    update filho
    set pontuacao = pontuacao + (select dificuldade from tarefa where new.tarefa = tarefa.descricao)
    where filho.nome = new.filho;
  end if;
  return new;
end
$$ language plpgsql;

create trigger add_points before update on realiza
for each row execute procedure add_points_proc();


-- -------------------------------------------------------------------------------------
-- RI 2 - trigger to check filho.habilidade <= tarefa.dificuldade
-- -------------------------------------------------------------------------------------
drop trigger if exists check_dificuldade on realiza;

create or replace function check_dificuldade_proc()
returns trigger as
$$
declare habilidade integer;
declare dificuldade integer;
begin
	-- Get habilidade
	select filho.habilidade into habilidade
	from filho
	where filho.nome = new.filho;

	-- Get dificuldade
	select tarefa.dificuldade into dificuldade
	from tarefa
	where tarefa.descricao = new.tarefa;

	-- Compare them
  if dificuldade > habilidade then
    raise exception 'O filho % não pode realizar tarefas com dificuldade maior à sua habilidae', new.filho;
  end if;

  -- Else, continue
  return new;
end
$$ language plpgsql;

create trigger check_dificuldade before insert on realiza
for each row execute procedure check_dificuldade_proc();