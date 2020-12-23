--------------------------------------------------- SCHEMA -----------------------------------------------------

-- -------------------------------------------------------------------------------
-- Remove previous tables
-- -------------------------------------------------------------------------------
drop table filho cascade;
drop table tarefa cascade;
drop table faz cascade;

-- -------------------------------------------------------------------------------
-- Create database
-- -------------------------------------------------------------------------------
create table filho ( 
    nome varchar(10),
    pontuacao integer default 0,
    num_tarefas_completas integer default 0,
    primary key(nome)
);

create table tarefa ( 
    descricao varchar(50),
    dificuldade integer
    check(dificuldade in (1,2,3)),
    primary key(descricao)
);

create table faz ( 
    id serial,
    filho varchar(10),
    tarefa varchar(50),
    data_registo date default current_date,
    data_conclusao date not null,
    supervisor varchar(5)
    check(supervisor in ('pai', 'mae')),
    status varchar(15) default 'para fazer'
    check(status in ('a fazer', 'feito', 'para fazer')),
    primary key(id),
    foreign key(filho) references filho(nome) on delete cascade on update cascade,
    foreign key(tarefa) references tarefa(descricao) on delete cascade on update cascade
);


-- ---------------------------------------------------------------------------------
-- Trigger: add points and increment num_tarefas_completas once faz.status = 'feito'
-- ---------------------------------------------------------------------------------
drop trigger if exists add_points on faz;

create or replace function add_points_proc()
returns trigger as
$$
begin
    if new.status = 'feito' then
        update filho
        set pontuacao = pontuacao + (select dificuldade from tarefa where new.tarefa = tarefa.descricao),
        		num_tarefas_completas = num_tarefas_completas + 1
        where filho.nome = new.filho;
    end if;
    return new;
end
$$ language plpgsql;

create trigger add_points before update on faz
for each row execute procedure add_points_proc();