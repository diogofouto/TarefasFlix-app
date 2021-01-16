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
drop table supervisor cascade;
drop table agent cascade;
drop table task cascade;
drop table assignment cascade;
drop table news cascade;


-- -------------------------------------------------------------------------------
-- Create tables
-- -------------------------------------------------------------------------------
create table supervisor (
	name varchar(50),
	pin varchar(100),
	primary key(name)
);
-- Os pins (4 dígitos) são encriptados com SHA-1 (daí o varchar(100))

create table agent ( 
  name varchar(50),
  score integer default 0,
  primary key(name)
);

create table task ( 
  description varchar(50),
  difficulty integer
  check(difficulty in (1,2,3)),
  primary key(description)
);

create table assignment ( 
  id serial,
  agent varchar(50),
  task varchar(50),
  start_date date not null default current_date,
  deadline_date date not null,
  supervisor varchar(50),
  status varchar(15) default 'por fazer'
  check(status in ('feito', 'por fazer', 'em consideração')),
  reward varchar(50),
  primary key(id),
  foreign key(agent) references agent(name) on delete cascade on update cascade,
  foreign key(supervisor) references supervisor(name) on delete cascade on update cascade,
  foreign key(task) references task(description) on delete cascade on update cascade
);

create table news ( 
  id serial,
  assignment_id integer,
  news_date date not null default current_date,
  agent varchar(50),
  task varchar(50),
  supervisor varchar(50),
  message varchar(50),
  status varchar(15) default 'não visto'
  check(status in ('não visto', 'visto')),
  primary key(id),
  foreign key(agent) references agent(name) on delete cascade on update cascade,
  foreign key(supervisor) references supervisor(name) on delete cascade on update cascade,
  foreign key(task) references task(description) on delete cascade on update cascade,
  foreign key(assignment_id) references assignment(id) on delete cascade on update cascade
);


-- -------------------------------------------------------------------------------------
-- RI 1 - trigger to add points once assignment.status = 'feito'
-- -------------------------------------------------------------------------------------
drop trigger if exists add_points on assignment;

create or replace function add_points_proc()
returns trigger as
$$
begin
	-- Se a tarefa estiver feita, incrementar score do agent
  if new.status = 'feito' then
    update agent
    set score = score + (select difficulty from task where new.task = task.description)
    where agent.name = new.agent;
  end if;
  return new;
end
$$ language plpgsql;

create trigger add_points before update on assignment
for each row execute procedure add_points_proc();


-- -------------------------------------------------------------------------------------
-- RI 2 - trigger to send news to supervisor depending on assignment.status
-- -------------------------------------------------------------------------------------
drop trigger if exists send_news on assignment;

create or replace function send_news_proc()
returns trigger as
$$
begin
  -- Se a tarefa estiver feita, incrementar score do agent
  if new.status = 'feito' then
    insert into news (assignment_id, agent, task, supervisor, message) values (new.id, new.agent, new.task, new.supervisor, 'Tarefa concluída!');
  elsif new.status = 'em consideração' then
    insert into news (assignment_id, agent, task, supervisor, message) values (new.id, new.agent, new.task, new.supervisor, 'Houve reclamação!');
  end if;
  return new;
end
$$ language plpgsql;

create trigger send_news before update on assignment
for each row execute procedure send_news_proc();