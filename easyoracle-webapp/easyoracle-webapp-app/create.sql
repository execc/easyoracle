create table oracle_data (id varchar(255) not null, public_key varchar(255), result varchar(255), signature varchar(255), primary key (id))
create table oracle_definition (id varchar(255) not null, data_source_expression varchar(255), data_source_type varchar(255), data_transformation_script varchar(255), signatures int4 not null, trigger varchar(255), window_size int4 not null, primary key (id))
create table oracle_task (id varchar(255) not null, status varchar(255), version int4 not null, definition_id varchar(255), primary key (id))
create table oracle_task_data (oracle_task_id varchar(255) not null, data_id varchar(255) not null, primary key (oracle_task_id, data_id))
alter table if exists oracle_task_data add constraint UK_1jht4ow9n0fmebe9igqhdnsey unique (data_id)
alter table if exists oracle_task add constraint FKek2le6sx71ka2a3o4lxidhluw foreign key (definition_id) references oracle_definition
alter table if exists oracle_task_data add constraint FK3oh5hatrfu51atpe2p0um5jsa foreign key (data_id) references oracle_data
alter table if exists oracle_task_data add constraint FK32novw4kmjlad3lnb8sqaebjc foreign key (oracle_task_id) references oracle_task
create table oracle_data (id varchar(255) not null, public_key varchar(255), result varchar(255), signature varchar(255), primary key (id))
create table oracle_definition (id varchar(255) not null, data_source_expression varchar(255), data_source_type varchar(255), data_transformation_script varchar(255), signatures int4 not null, trigger varchar(255), window_size int4 not null, primary key (id))
create table oracle_task (id varchar(255) not null, status varchar(255), version int4 not null, definition_id varchar(255), primary key (id))
create table oracle_task_data (oracle_task_id varchar(255) not null, data_id varchar(255) not null, primary key (oracle_task_id, data_id))
alter table if exists oracle_task_data add constraint UK_1jht4ow9n0fmebe9igqhdnsey unique (data_id)
alter table if exists oracle_task add constraint FKek2le6sx71ka2a3o4lxidhluw foreign key (definition_id) references oracle_definition
alter table if exists oracle_task_data add constraint FK3oh5hatrfu51atpe2p0um5jsa foreign key (data_id) references oracle_data
alter table if exists oracle_task_data add constraint FK32novw4kmjlad3lnb8sqaebjc foreign key (oracle_task_id) references oracle_task
create table oracle_data (id varchar(255) not null, public_key varchar(255), result varchar(255), signature varchar(255), primary key (id))
create table oracle_definition (id varchar(255) not null, data_source_expression varchar(255), data_source_type varchar(255), data_transformation_script varchar(255), signatures int4 not null, trigger varchar(255), window_size int4 not null, primary key (id))
create table oracle_task (id varchar(255) not null, status varchar(255), version int4 not null, definition_id varchar(255), primary key (id))
create table oracle_task_data (oracle_task_id varchar(255) not null, data_id varchar(255) not null, primary key (oracle_task_id, data_id))
alter table if exists oracle_task_data add constraint UK_1jht4ow9n0fmebe9igqhdnsey unique (data_id)
alter table if exists oracle_task add constraint FKek2le6sx71ka2a3o4lxidhluw foreign key (definition_id) references oracle_definition
alter table if exists oracle_task_data add constraint FK3oh5hatrfu51atpe2p0um5jsa foreign key (data_id) references oracle_data
alter table if exists oracle_task_data add constraint FK32novw4kmjlad3lnb8sqaebjc foreign key (oracle_task_id) references oracle_task
create table oracle_data (id varchar(255) not null, public_key varchar(255), result varchar(255), signature varchar(255), primary key (id))
create table oracle_definition (id varchar(255) not null, data_source_expression varchar(255), data_source_type varchar(255), data_transformation_script varchar(255), signatures int4 not null, trigger varchar(255), window_size int4 not null, primary key (id))
create table oracle_task (id varchar(255) not null, status varchar(255), version int4 not null, definition_id varchar(255), primary key (id))
create table oracle_task_data (oracle_task_id varchar(255) not null, data_id varchar(255) not null, primary key (oracle_task_id, data_id))
alter table if exists oracle_task_data add constraint UK_1jht4ow9n0fmebe9igqhdnsey unique (data_id)
alter table if exists oracle_task add constraint FKek2le6sx71ka2a3o4lxidhluw foreign key (definition_id) references oracle_definition
alter table if exists oracle_task_data add constraint FK3oh5hatrfu51atpe2p0um5jsa foreign key (data_id) references oracle_data
alter table if exists oracle_task_data add constraint FK32novw4kmjlad3lnb8sqaebjc foreign key (oracle_task_id) references oracle_task
