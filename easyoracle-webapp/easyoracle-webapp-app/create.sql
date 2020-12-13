create table block_height_info (id uuid not null, created_timestamp timestamp, current_height int8 not null, node_alias varchar(255), update_timestamp timestamp, version int8, primary key (id))
create table enqueued_tx (id varchar(255) not null, block_height int8 not null, body uuid, created timestamp, modified timestamp, position_in_block int4 not null, status varchar(255), tx_timestamp timestamp, partition_id varchar(255), primary key (id))
create table oracle_data (id varchar(255) not null, public_key varchar(255), result varchar(255), signature varchar(255), primary key (id))
create table oracle_data_source (id varchar(255) not null, data_source_expression varchar(255), data_source_type varchar(255), data_transformation_script varchar(255), primary key (id))
create table oracle_data_source_selector (oracle_data_source_id varchar(255) not null, selector varchar(255))
create table oracle_definition (id varchar(255) not null, contract_id varchar(255), contract_name varchar(255), signatures int4 not null, trigger varchar(255), window_size int4 not null, primary key (id))
create table oracle_definition_data_sources (oracle_definition_id varchar(255) not null, data_sources_id varchar(255) not null)
create table oracle_task (id varchar(255) not null, status varchar(255), version int4 not null, definition_id varchar(255), primary key (id))
create table oracle_task_data (oracle_task_id varchar(255) not null, data_id varchar(255) not null, primary key (oracle_task_id, data_id))
create table tx_queue_partition (id varchar(255) not null, created timestamp, last_enqueued_tx_id varchar(255), last_enqueued_tx_timestamp timestamp, last_read_tx_id varchar(255), modified timestamp, priority int4 not null, primary key (id))
alter table if exists oracle_definition_data_sources add constraint UK_tiqlxnvm4ybtwwcq7d17hctw6 unique (data_sources_id)
alter table if exists oracle_task_data add constraint UK_1jht4ow9n0fmebe9igqhdnsey unique (data_id)
alter table if exists enqueued_tx add constraint FKfbmng1sdtxg6en2xip6tn1laf foreign key (partition_id) references tx_queue_partition
alter table if exists oracle_data_source_selector add constraint FKbhi4e5n3dfxa0978ckecvnlxt foreign key (oracle_data_source_id) references oracle_data_source
alter table if exists oracle_definition_data_sources add constraint FKiavmy79dbsx3vr09hn6t553eb foreign key (data_sources_id) references oracle_data_source
alter table if exists oracle_definition_data_sources add constraint FK6xy3bflmdfoalfpse6nh07bj3 foreign key (oracle_definition_id) references oracle_definition
alter table if exists oracle_task add constraint FKek2le6sx71ka2a3o4lxidhluw foreign key (definition_id) references oracle_definition
alter table if exists oracle_task_data add constraint FK3oh5hatrfu51atpe2p0um5jsa foreign key (data_id) references oracle_data
alter table if exists oracle_task_data add constraint FK32novw4kmjlad3lnb8sqaebjc foreign key (oracle_task_id) references oracle_task
create table block_height_info (id uuid not null, created_timestamp timestamp, current_height int8 not null, node_alias varchar(255), update_timestamp timestamp, version int8, primary key (id))
create table enqueued_tx (id varchar(255) not null, block_height int8 not null, body uuid, created timestamp, modified timestamp, position_in_block int4 not null, status varchar(255), tx_timestamp timestamp, partition_id varchar(255), primary key (id))
create table oracle_data (id varchar(255) not null, public_key varchar(255), result varchar(255), signature varchar(255), primary key (id))
create table oracle_data_source (id varchar(255) not null, data_source_expression varchar(255), data_source_type varchar(255), data_transformation_script varchar(255), primary key (id))
create table oracle_data_source_selector (oracle_data_source_id varchar(255) not null, selector varchar(255))
create table oracle_definition (id varchar(255) not null, contract_id varchar(255), contract_name varchar(255), signatures int4 not null, trigger varchar(255), window_size int4 not null, primary key (id))
create table oracle_definition_data_sources (oracle_definition_id varchar(255) not null, data_sources_id varchar(255) not null)
create table oracle_task (id varchar(255) not null, status varchar(255), version int4 not null, definition_id varchar(255), primary key (id))
create table oracle_task_data (oracle_task_id varchar(255) not null, data_id varchar(255) not null, primary key (oracle_task_id, data_id))
create table tx_queue_partition (id varchar(255) not null, created timestamp, last_enqueued_tx_id varchar(255), last_enqueued_tx_timestamp timestamp, last_read_tx_id varchar(255), modified timestamp, priority int4 not null, primary key (id))
alter table if exists oracle_definition_data_sources add constraint UK_tiqlxnvm4ybtwwcq7d17hctw6 unique (data_sources_id)
alter table if exists oracle_task_data add constraint UK_1jht4ow9n0fmebe9igqhdnsey unique (data_id)
alter table if exists enqueued_tx add constraint FKfbmng1sdtxg6en2xip6tn1laf foreign key (partition_id) references tx_queue_partition
alter table if exists oracle_data_source_selector add constraint FKbhi4e5n3dfxa0978ckecvnlxt foreign key (oracle_data_source_id) references oracle_data_source
alter table if exists oracle_definition_data_sources add constraint FKiavmy79dbsx3vr09hn6t553eb foreign key (data_sources_id) references oracle_data_source
alter table if exists oracle_definition_data_sources add constraint FK6xy3bflmdfoalfpse6nh07bj3 foreign key (oracle_definition_id) references oracle_definition
alter table if exists oracle_task add constraint FKek2le6sx71ka2a3o4lxidhluw foreign key (definition_id) references oracle_definition
alter table if exists oracle_task_data add constraint FK3oh5hatrfu51atpe2p0um5jsa foreign key (data_id) references oracle_data
alter table if exists oracle_task_data add constraint FK32novw4kmjlad3lnb8sqaebjc foreign key (oracle_task_id) references oracle_task
create table block_height_info (id uuid not null, created_timestamp timestamp, current_height int8 not null, node_alias varchar(255), update_timestamp timestamp, version int8, primary key (id))
create table enqueued_tx (id varchar(255) not null, block_height int8 not null, body uuid, created timestamp, modified timestamp, position_in_block int4 not null, status varchar(255), tx_timestamp timestamp, partition_id varchar(255), primary key (id))
create table oracle_data (id varchar(255) not null, public_key varchar(255), result varchar(255), signature varchar(255), primary key (id))
create table oracle_data_source (id varchar(255) not null, data_source_expression varchar(255), data_source_type varchar(255), data_transformation_script varchar(255), primary key (id))
create table oracle_data_source_selector (oracle_data_source_id varchar(255) not null, selector varchar(255))
create table oracle_definition (id varchar(255) not null, contract_id varchar(255), contract_name varchar(255), signatures int4 not null, trigger varchar(255), window_size int4 not null, primary key (id))
create table oracle_definition_data_sources (oracle_definition_id varchar(255) not null, data_sources_id varchar(255) not null)
create table oracle_task (id varchar(255) not null, status varchar(255), version int4 not null, definition_id varchar(255), primary key (id))
create table oracle_task_data (oracle_task_id varchar(255) not null, data_id varchar(255) not null, primary key (oracle_task_id, data_id))
create table tx_queue_partition (id varchar(255) not null, created timestamp, last_enqueued_tx_id varchar(255), last_enqueued_tx_timestamp timestamp, last_read_tx_id varchar(255), modified timestamp, priority int4 not null, primary key (id))
alter table if exists oracle_definition_data_sources add constraint UK_tiqlxnvm4ybtwwcq7d17hctw6 unique (data_sources_id)
alter table if exists oracle_task_data add constraint UK_1jht4ow9n0fmebe9igqhdnsey unique (data_id)
alter table if exists enqueued_tx add constraint FKfbmng1sdtxg6en2xip6tn1laf foreign key (partition_id) references tx_queue_partition
alter table if exists oracle_data_source_selector add constraint FKbhi4e5n3dfxa0978ckecvnlxt foreign key (oracle_data_source_id) references oracle_data_source
alter table if exists oracle_definition_data_sources add constraint FKiavmy79dbsx3vr09hn6t553eb foreign key (data_sources_id) references oracle_data_source
alter table if exists oracle_definition_data_sources add constraint FK6xy3bflmdfoalfpse6nh07bj3 foreign key (oracle_definition_id) references oracle_definition
alter table if exists oracle_task add constraint FKek2le6sx71ka2a3o4lxidhluw foreign key (definition_id) references oracle_definition
alter table if exists oracle_task_data add constraint FK3oh5hatrfu51atpe2p0um5jsa foreign key (data_id) references oracle_data
alter table if exists oracle_task_data add constraint FK32novw4kmjlad3lnb8sqaebjc foreign key (oracle_task_id) references oracle_task
create table block_height_info (id uuid not null, created_timestamp timestamp, current_height int8 not null, node_alias varchar(255), update_timestamp timestamp, version int8, primary key (id))
create table enqueued_tx (id varchar(255) not null, block_height int8 not null, body uuid, created timestamp, modified timestamp, position_in_block int4 not null, status varchar(255), tx_timestamp timestamp, partition_id varchar(255), primary key (id))
create table oracle_data (id varchar(255) not null, public_key varchar(255), result varchar(255), signature varchar(255), primary key (id))
create table oracle_data_source (id varchar(255) not null, data_source_expression varchar(255), data_source_type varchar(255), data_transformation_script varchar(255), primary key (id))
create table oracle_data_source_selector (oracle_data_source_id varchar(255) not null, selector varchar(255))
create table oracle_definition (id varchar(255) not null, contract_id varchar(255), contract_name varchar(255), signatures int4 not null, trigger varchar(255), window_size int4 not null, primary key (id))
create table oracle_definition_data_sources (oracle_definition_id varchar(255) not null, data_sources_id varchar(255) not null)
create table oracle_task (id varchar(255) not null, status varchar(255), version int4 not null, definition_id varchar(255), primary key (id))
create table oracle_task_data (oracle_task_id varchar(255) not null, data_id varchar(255) not null, primary key (oracle_task_id, data_id))
create table tx_queue_partition (id varchar(255) not null, created timestamp, last_enqueued_tx_id varchar(255), last_enqueued_tx_timestamp timestamp, last_read_tx_id varchar(255), modified timestamp, priority int4 not null, primary key (id))
alter table if exists oracle_definition_data_sources add constraint UK_tiqlxnvm4ybtwwcq7d17hctw6 unique (data_sources_id)
alter table if exists oracle_task_data add constraint UK_1jht4ow9n0fmebe9igqhdnsey unique (data_id)
alter table if exists enqueued_tx add constraint FKfbmng1sdtxg6en2xip6tn1laf foreign key (partition_id) references tx_queue_partition
alter table if exists oracle_data_source_selector add constraint FKbhi4e5n3dfxa0978ckecvnlxt foreign key (oracle_data_source_id) references oracle_data_source
alter table if exists oracle_definition_data_sources add constraint FKiavmy79dbsx3vr09hn6t553eb foreign key (data_sources_id) references oracle_data_source
alter table if exists oracle_definition_data_sources add constraint FK6xy3bflmdfoalfpse6nh07bj3 foreign key (oracle_definition_id) references oracle_definition
alter table if exists oracle_task add constraint FKek2le6sx71ka2a3o4lxidhluw foreign key (definition_id) references oracle_definition
alter table if exists oracle_task_data add constraint FK3oh5hatrfu51atpe2p0um5jsa foreign key (data_id) references oracle_data
alter table if exists oracle_task_data add constraint FK32novw4kmjlad3lnb8sqaebjc foreign key (oracle_task_id) references oracle_task
create table block_height_info (id uuid not null, created_timestamp timestamp, current_height int8 not null, node_alias varchar(255), update_timestamp timestamp, version int8, primary key (id))
create table enqueued_tx (id varchar(255) not null, block_height int8 not null, body uuid, created timestamp, modified timestamp, position_in_block int4 not null, status varchar(255), tx_timestamp timestamp, partition_id varchar(255), primary key (id))
create table oracle_data (id varchar(255) not null, public_key varchar(255), result varchar(255), signature varchar(255), primary key (id))
create table oracle_data_source (id varchar(255) not null, data_source_expression varchar(255), data_source_type varchar(255), data_transformation_script varchar(255), primary key (id))
create table oracle_data_source_selector (oracle_data_source_id varchar(255) not null, selector varchar(255))
create table oracle_definition (id varchar(255) not null, contract_id varchar(255), contract_name varchar(255), signatures int4 not null, trigger varchar(255), window_size int4 not null, primary key (id))
create table oracle_definition_data_sources (oracle_definition_id varchar(255) not null, data_sources_id varchar(255) not null)
create table oracle_task (id varchar(255) not null, status varchar(255), version int4 not null, definition_id varchar(255), primary key (id))
create table oracle_task_data (oracle_task_id varchar(255) not null, data_id varchar(255) not null, primary key (oracle_task_id, data_id))
create table tx_queue_partition (id varchar(255) not null, created timestamp, last_enqueued_tx_id varchar(255), last_enqueued_tx_timestamp timestamp, last_read_tx_id varchar(255), modified timestamp, priority int4 not null, primary key (id))
alter table if exists oracle_definition_data_sources add constraint UK_tiqlxnvm4ybtwwcq7d17hctw6 unique (data_sources_id)
alter table if exists oracle_task_data add constraint UK_1jht4ow9n0fmebe9igqhdnsey unique (data_id)
alter table if exists enqueued_tx add constraint FKfbmng1sdtxg6en2xip6tn1laf foreign key (partition_id) references tx_queue_partition
alter table if exists oracle_data_source_selector add constraint FKbhi4e5n3dfxa0978ckecvnlxt foreign key (oracle_data_source_id) references oracle_data_source
alter table if exists oracle_definition_data_sources add constraint FKiavmy79dbsx3vr09hn6t553eb foreign key (data_sources_id) references oracle_data_source
alter table if exists oracle_definition_data_sources add constraint FK6xy3bflmdfoalfpse6nh07bj3 foreign key (oracle_definition_id) references oracle_definition
alter table if exists oracle_task add constraint FKek2le6sx71ka2a3o4lxidhluw foreign key (definition_id) references oracle_definition
alter table if exists oracle_task_data add constraint FK3oh5hatrfu51atpe2p0um5jsa foreign key (data_id) references oracle_data
alter table if exists oracle_task_data add constraint FK32novw4kmjlad3lnb8sqaebjc foreign key (oracle_task_id) references oracle_task
create table block_height_info (id uuid not null, created_timestamp timestamp, current_height int8 not null, node_alias varchar(255), update_timestamp timestamp, version int8, primary key (id))
create table enqueued_tx (id varchar(255) not null, block_height int8 not null, body uuid, created timestamp, modified timestamp, position_in_block int4 not null, status varchar(255), tx_timestamp timestamp, partition_id varchar(255), primary key (id))
create table oracle_data (id varchar(255) not null, public_key varchar(255), result varchar(255), signature varchar(255), primary key (id))
create table oracle_data_source (id varchar(255) not null, data_source_expression varchar(255), data_source_type varchar(255), data_transformation_script varchar(255), primary key (id))
create table oracle_data_source_selector (oracle_data_source_id varchar(255) not null, selector varchar(255))
create table oracle_definition (id varchar(255) not null, contract_id varchar(255), contract_name varchar(255), signatures int4 not null, trigger varchar(255), window_size int4 not null, primary key (id))
create table oracle_definition_data_sources (oracle_definition_id varchar(255) not null, data_sources_id varchar(255) not null)
create table oracle_task (id varchar(255) not null, status varchar(255), version int4 not null, definition_id varchar(255), primary key (id))
create table oracle_task_data (oracle_task_id varchar(255) not null, data_id varchar(255) not null, primary key (oracle_task_id, data_id))
create table tx_queue_partition (id varchar(255) not null, created timestamp, last_enqueued_tx_id varchar(255), last_enqueued_tx_timestamp timestamp, last_read_tx_id varchar(255), modified timestamp, priority int4 not null, primary key (id))
alter table if exists oracle_definition_data_sources add constraint UK_tiqlxnvm4ybtwwcq7d17hctw6 unique (data_sources_id)
alter table if exists oracle_task_data add constraint UK_1jht4ow9n0fmebe9igqhdnsey unique (data_id)
alter table if exists enqueued_tx add constraint FKfbmng1sdtxg6en2xip6tn1laf foreign key (partition_id) references tx_queue_partition
alter table if exists oracle_data_source_selector add constraint FKbhi4e5n3dfxa0978ckecvnlxt foreign key (oracle_data_source_id) references oracle_data_source
alter table if exists oracle_definition_data_sources add constraint FKiavmy79dbsx3vr09hn6t553eb foreign key (data_sources_id) references oracle_data_source
alter table if exists oracle_definition_data_sources add constraint FK6xy3bflmdfoalfpse6nh07bj3 foreign key (oracle_definition_id) references oracle_definition
alter table if exists oracle_task add constraint FKek2le6sx71ka2a3o4lxidhluw foreign key (definition_id) references oracle_definition
alter table if exists oracle_task_data add constraint FK3oh5hatrfu51atpe2p0um5jsa foreign key (data_id) references oracle_data
alter table if exists oracle_task_data add constraint FK32novw4kmjlad3lnb8sqaebjc foreign key (oracle_task_id) references oracle_task
create table block_height_info (id uuid not null, created_timestamp timestamp, current_height int8 not null, node_alias varchar(255), update_timestamp timestamp, version int8, primary key (id))
create table enqueued_tx (id varchar(255) not null, block_height int8 not null, body uuid, created timestamp, modified timestamp, position_in_block int4 not null, status varchar(255), tx_timestamp timestamp, partition_id varchar(255), primary key (id))
create table oracle_data (id varchar(255) not null, public_key varchar(255), result varchar(255), signature varchar(255), primary key (id))
create table oracle_data_source (id varchar(255) not null, data_source_expression varchar(255), data_source_type varchar(255), data_transformation_script varchar(255), primary key (id))
create table oracle_data_source_selector (oracle_data_source_id varchar(255) not null, selector varchar(255))
create table oracle_definition (id varchar(255) not null, contract_id varchar(255), contract_name varchar(255), signatures int4 not null, trigger varchar(255), window_size int4 not null, primary key (id))
create table oracle_definition_data_sources (oracle_definition_id varchar(255) not null, data_sources_id varchar(255) not null)
create table oracle_task (id varchar(255) not null, status varchar(255), version int4 not null, definition_id varchar(255), primary key (id))
create table oracle_task_data (oracle_task_id varchar(255) not null, data_id varchar(255) not null, primary key (oracle_task_id, data_id))
create table tx_queue_partition (id varchar(255) not null, created timestamp, last_enqueued_tx_id varchar(255), last_enqueued_tx_timestamp timestamp, last_read_tx_id varchar(255), modified timestamp, priority int4 not null, primary key (id))
alter table if exists oracle_definition_data_sources add constraint UK_tiqlxnvm4ybtwwcq7d17hctw6 unique (data_sources_id)
alter table if exists oracle_task_data add constraint UK_1jht4ow9n0fmebe9igqhdnsey unique (data_id)
alter table if exists enqueued_tx add constraint FKfbmng1sdtxg6en2xip6tn1laf foreign key (partition_id) references tx_queue_partition
alter table if exists oracle_data_source_selector add constraint FKbhi4e5n3dfxa0978ckecvnlxt foreign key (oracle_data_source_id) references oracle_data_source
alter table if exists oracle_definition_data_sources add constraint FKiavmy79dbsx3vr09hn6t553eb foreign key (data_sources_id) references oracle_data_source
alter table if exists oracle_definition_data_sources add constraint FK6xy3bflmdfoalfpse6nh07bj3 foreign key (oracle_definition_id) references oracle_definition
alter table if exists oracle_task add constraint FKek2le6sx71ka2a3o4lxidhluw foreign key (definition_id) references oracle_definition
alter table if exists oracle_task_data add constraint FK3oh5hatrfu51atpe2p0um5jsa foreign key (data_id) references oracle_data
alter table if exists oracle_task_data add constraint FK32novw4kmjlad3lnb8sqaebjc foreign key (oracle_task_id) references oracle_task
create table block_height_info (id uuid not null, created_timestamp timestamp, current_height int8 not null, node_alias varchar(255), update_timestamp timestamp, version int8, primary key (id))
create table enqueued_tx (id varchar(255) not null, block_height int8 not null, body uuid, created timestamp, modified timestamp, position_in_block int4 not null, status varchar(255), tx_timestamp timestamp, partition_id varchar(255), primary key (id))
create table oracle_data (id varchar(255) not null, public_key varchar(255), result varchar(255), signature varchar(255), primary key (id))
create table oracle_data_source (id varchar(255) not null, data_source_expression varchar(255), data_source_type varchar(255), data_transformation_script varchar(255), primary key (id))
create table oracle_data_source_selector (oracle_data_source_id varchar(255) not null, selector varchar(255))
create table oracle_definition (id varchar(255) not null, contract_id varchar(255), contract_name varchar(255), signatures int4 not null, trigger varchar(255), window_size int4 not null, primary key (id))
create table oracle_definition_data_sources (oracle_definition_id varchar(255) not null, data_sources_id varchar(255) not null)
create table oracle_task (id varchar(255) not null, status varchar(255), version int4 not null, definition_id varchar(255), primary key (id))
create table oracle_task_data (oracle_task_id varchar(255) not null, data_id varchar(255) not null, primary key (oracle_task_id, data_id))
create table tx_queue_partition (id varchar(255) not null, created timestamp, last_enqueued_tx_id varchar(255), last_enqueued_tx_timestamp timestamp, last_read_tx_id varchar(255), modified timestamp, priority int4 not null, primary key (id))
alter table if exists oracle_definition_data_sources add constraint UK_tiqlxnvm4ybtwwcq7d17hctw6 unique (data_sources_id)
alter table if exists oracle_task_data add constraint UK_1jht4ow9n0fmebe9igqhdnsey unique (data_id)
alter table if exists enqueued_tx add constraint FKfbmng1sdtxg6en2xip6tn1laf foreign key (partition_id) references tx_queue_partition
alter table if exists oracle_data_source_selector add constraint FKbhi4e5n3dfxa0978ckecvnlxt foreign key (oracle_data_source_id) references oracle_data_source
alter table if exists oracle_definition_data_sources add constraint FKiavmy79dbsx3vr09hn6t553eb foreign key (data_sources_id) references oracle_data_source
alter table if exists oracle_definition_data_sources add constraint FK6xy3bflmdfoalfpse6nh07bj3 foreign key (oracle_definition_id) references oracle_definition
alter table if exists oracle_task add constraint FKek2le6sx71ka2a3o4lxidhluw foreign key (definition_id) references oracle_definition
alter table if exists oracle_task_data add constraint FK3oh5hatrfu51atpe2p0um5jsa foreign key (data_id) references oracle_data
alter table if exists oracle_task_data add constraint FK32novw4kmjlad3lnb8sqaebjc foreign key (oracle_task_id) references oracle_task
create table block_height_info (id uuid not null, created_timestamp timestamp, current_height int8 not null, node_alias varchar(255), update_timestamp timestamp, version int8, primary key (id))
create table enqueued_tx (id varchar(255) not null, block_height int8 not null, body uuid, created timestamp, modified timestamp, position_in_block int4 not null, status varchar(255), tx_timestamp timestamp, partition_id varchar(255), primary key (id))
create table oracle_data (id varchar(255) not null, public_key varchar(255), result varchar(255), signature varchar(255), primary key (id))
create table oracle_data_source (id varchar(255) not null, data_source_expression varchar(255), data_source_type varchar(255), data_transformation_script varchar(255), primary key (id))
create table oracle_data_source_selector (oracle_data_source_id varchar(255) not null, selector varchar(255))
create table oracle_definition (id varchar(255) not null, contract_id varchar(255), contract_name varchar(255), signatures int4 not null, trigger varchar(255), window_size int4 not null, primary key (id))
create table oracle_definition_data_sources (oracle_definition_id varchar(255) not null, data_sources_id varchar(255) not null)
create table oracle_task (id varchar(255) not null, status varchar(255), version int4 not null, definition_id varchar(255), primary key (id))
create table oracle_task_data (oracle_task_id varchar(255) not null, data_id varchar(255) not null, primary key (oracle_task_id, data_id))
create table tx_queue_partition (id varchar(255) not null, created timestamp, last_enqueued_tx_id varchar(255), last_enqueued_tx_timestamp timestamp, last_read_tx_id varchar(255), modified timestamp, priority int4 not null, primary key (id))
alter table if exists oracle_definition_data_sources add constraint UK_tiqlxnvm4ybtwwcq7d17hctw6 unique (data_sources_id)
alter table if exists oracle_task_data add constraint UK_1jht4ow9n0fmebe9igqhdnsey unique (data_id)
alter table if exists enqueued_tx add constraint FKfbmng1sdtxg6en2xip6tn1laf foreign key (partition_id) references tx_queue_partition
alter table if exists oracle_data_source_selector add constraint FKbhi4e5n3dfxa0978ckecvnlxt foreign key (oracle_data_source_id) references oracle_data_source
alter table if exists oracle_definition_data_sources add constraint FKiavmy79dbsx3vr09hn6t553eb foreign key (data_sources_id) references oracle_data_source
alter table if exists oracle_definition_data_sources add constraint FK6xy3bflmdfoalfpse6nh07bj3 foreign key (oracle_definition_id) references oracle_definition
alter table if exists oracle_task add constraint FKek2le6sx71ka2a3o4lxidhluw foreign key (definition_id) references oracle_definition
alter table if exists oracle_task_data add constraint FK3oh5hatrfu51atpe2p0um5jsa foreign key (data_id) references oracle_data
alter table if exists oracle_task_data add constraint FK32novw4kmjlad3lnb8sqaebjc foreign key (oracle_task_id) references oracle_task
create table block_height_info (id uuid not null, created_timestamp timestamp, current_height int8 not null, node_alias varchar(255), update_timestamp timestamp, version int8, primary key (id))
create table enqueued_tx (id varchar(255) not null, block_height int8 not null, body uuid, created timestamp, modified timestamp, position_in_block int4 not null, status varchar(255), tx_timestamp timestamp, partition_id varchar(255), primary key (id))
create table oracle_data (id varchar(255) not null, public_key varchar(255), result varchar(255), signature varchar(255), primary key (id))
create table oracle_data_source (id varchar(255) not null, data_source_expression varchar(255), data_source_type varchar(255), data_transformation_script varchar(255), primary key (id))
create table oracle_data_source_selector (oracle_data_source_id varchar(255) not null, selector varchar(255))
create table oracle_definition (id varchar(255) not null, contract_id varchar(255), contract_name varchar(255), signatures int4 not null, trigger varchar(255), window_size int4 not null, primary key (id))
create table oracle_definition_data_sources (oracle_definition_id varchar(255) not null, data_sources_id varchar(255) not null)
create table oracle_task (id varchar(255) not null, status varchar(255), version int4 not null, definition_id varchar(255), primary key (id))
create table oracle_task_data (oracle_task_id varchar(255) not null, data_id varchar(255) not null, primary key (oracle_task_id, data_id))
create table tx_queue_partition (id varchar(255) not null, created timestamp, last_enqueued_tx_id varchar(255), last_enqueued_tx_timestamp timestamp, last_read_tx_id varchar(255), modified timestamp, priority int4 not null, primary key (id))
alter table if exists oracle_definition_data_sources add constraint UK_tiqlxnvm4ybtwwcq7d17hctw6 unique (data_sources_id)
alter table if exists oracle_task_data add constraint UK_1jht4ow9n0fmebe9igqhdnsey unique (data_id)
alter table if exists enqueued_tx add constraint FKfbmng1sdtxg6en2xip6tn1laf foreign key (partition_id) references tx_queue_partition
alter table if exists oracle_data_source_selector add constraint FKbhi4e5n3dfxa0978ckecvnlxt foreign key (oracle_data_source_id) references oracle_data_source
alter table if exists oracle_definition_data_sources add constraint FKiavmy79dbsx3vr09hn6t553eb foreign key (data_sources_id) references oracle_data_source
alter table if exists oracle_definition_data_sources add constraint FK6xy3bflmdfoalfpse6nh07bj3 foreign key (oracle_definition_id) references oracle_definition
alter table if exists oracle_task add constraint FKek2le6sx71ka2a3o4lxidhluw foreign key (definition_id) references oracle_definition
alter table if exists oracle_task_data add constraint FK3oh5hatrfu51atpe2p0um5jsa foreign key (data_id) references oracle_data
alter table if exists oracle_task_data add constraint FK32novw4kmjlad3lnb8sqaebjc foreign key (oracle_task_id) references oracle_task
create table block_height_info (id uuid not null, created_timestamp timestamp, current_height int8 not null, node_alias varchar(255), update_timestamp timestamp, version int8, primary key (id))
create table enqueued_tx (id varchar(255) not null, block_height int8 not null, body uuid, created timestamp, modified timestamp, position_in_block int4 not null, status varchar(255), tx_timestamp timestamp, partition_id varchar(255), primary key (id))
create table oracle_data (id varchar(255) not null, public_key varchar(255), result varchar(255), signature varchar(255), primary key (id))
create table oracle_data_source (id varchar(255) not null, data_source_expression varchar(255), data_source_type varchar(255), data_transformation_script varchar(255), primary key (id))
create table oracle_data_source_selector (oracle_data_source_id varchar(255) not null, selector varchar(255))
create table oracle_definition (id varchar(255) not null, contract_id varchar(255), contract_name varchar(255), signatures int4 not null, trigger varchar(255), window_size int4 not null, primary key (id))
create table oracle_definition_data_sources (oracle_definition_id varchar(255) not null, data_sources_id varchar(255) not null)
create table oracle_task (id varchar(255) not null, status varchar(255), version int4 not null, definition_id varchar(255), primary key (id))
create table oracle_task_data (oracle_task_id varchar(255) not null, data_id varchar(255) not null, primary key (oracle_task_id, data_id))
create table tx_queue_partition (id varchar(255) not null, created timestamp, last_enqueued_tx_id varchar(255), last_enqueued_tx_timestamp timestamp, last_read_tx_id varchar(255), modified timestamp, priority int4 not null, primary key (id))
alter table if exists oracle_definition_data_sources add constraint UK_tiqlxnvm4ybtwwcq7d17hctw6 unique (data_sources_id)
alter table if exists oracle_task_data add constraint UK_1jht4ow9n0fmebe9igqhdnsey unique (data_id)
alter table if exists enqueued_tx add constraint FKfbmng1sdtxg6en2xip6tn1laf foreign key (partition_id) references tx_queue_partition
alter table if exists oracle_data_source_selector add constraint FKbhi4e5n3dfxa0978ckecvnlxt foreign key (oracle_data_source_id) references oracle_data_source
alter table if exists oracle_definition_data_sources add constraint FKiavmy79dbsx3vr09hn6t553eb foreign key (data_sources_id) references oracle_data_source
alter table if exists oracle_definition_data_sources add constraint FK6xy3bflmdfoalfpse6nh07bj3 foreign key (oracle_definition_id) references oracle_definition
alter table if exists oracle_task add constraint FKek2le6sx71ka2a3o4lxidhluw foreign key (definition_id) references oracle_definition
alter table if exists oracle_task_data add constraint FK3oh5hatrfu51atpe2p0um5jsa foreign key (data_id) references oracle_data
alter table if exists oracle_task_data add constraint FK32novw4kmjlad3lnb8sqaebjc foreign key (oracle_task_id) references oracle_task
create table block_height_info (id uuid not null, created_timestamp timestamp, current_height int8 not null, node_alias varchar(255), update_timestamp timestamp, version int8, primary key (id))
create table enqueued_tx (id varchar(255) not null, block_height int8 not null, body uuid, created timestamp, modified timestamp, position_in_block int4 not null, status varchar(255), tx_timestamp timestamp, partition_id varchar(255), primary key (id))
create table oracle_data (id varchar(255) not null, public_key varchar(255), result varchar(255), signature varchar(255), primary key (id))
create table oracle_data_source (id varchar(255) not null, data_source_expression varchar(255), data_source_type varchar(255), data_transformation_script varchar(255), primary key (id))
create table oracle_data_source_selector (oracle_data_source_id varchar(255) not null, selector varchar(255))
create table oracle_definition (id varchar(255) not null, contract_id varchar(255), contract_name varchar(255), signatures int4 not null, trigger varchar(255), window_size int4 not null, primary key (id))
create table oracle_definition_data_sources (oracle_definition_id varchar(255) not null, data_sources_id varchar(255) not null)
create table oracle_task (id varchar(255) not null, status varchar(255), version int4 not null, definition_id varchar(255), primary key (id))
create table oracle_task_data (oracle_task_id varchar(255) not null, data_id varchar(255) not null, primary key (oracle_task_id, data_id))
create table tx_queue_partition (id varchar(255) not null, created timestamp, last_enqueued_tx_id varchar(255), last_enqueued_tx_timestamp timestamp, last_read_tx_id varchar(255), modified timestamp, priority int4 not null, primary key (id))
alter table if exists oracle_definition_data_sources add constraint UK_tiqlxnvm4ybtwwcq7d17hctw6 unique (data_sources_id)
alter table if exists oracle_task_data add constraint UK_1jht4ow9n0fmebe9igqhdnsey unique (data_id)
alter table if exists enqueued_tx add constraint FKfbmng1sdtxg6en2xip6tn1laf foreign key (partition_id) references tx_queue_partition
alter table if exists oracle_data_source_selector add constraint FKbhi4e5n3dfxa0978ckecvnlxt foreign key (oracle_data_source_id) references oracle_data_source
alter table if exists oracle_definition_data_sources add constraint FKiavmy79dbsx3vr09hn6t553eb foreign key (data_sources_id) references oracle_data_source
alter table if exists oracle_definition_data_sources add constraint FK6xy3bflmdfoalfpse6nh07bj3 foreign key (oracle_definition_id) references oracle_definition
alter table if exists oracle_task add constraint FKek2le6sx71ka2a3o4lxidhluw foreign key (definition_id) references oracle_definition
alter table if exists oracle_task_data add constraint FK3oh5hatrfu51atpe2p0um5jsa foreign key (data_id) references oracle_data
alter table if exists oracle_task_data add constraint FK32novw4kmjlad3lnb8sqaebjc foreign key (oracle_task_id) references oracle_task
create table block_height_info (id uuid not null, created_timestamp timestamp, current_height int8 not null, node_alias varchar(255), update_timestamp timestamp, version int8, primary key (id))
create table enqueued_tx (id varchar(255) not null, block_height int8 not null, body uuid, created timestamp, modified timestamp, position_in_block int4 not null, status varchar(255), tx_timestamp timestamp, partition_id varchar(255), primary key (id))
create table oracle_data (id varchar(255) not null, public_key varchar(255), result varchar(255), signature varchar(255), primary key (id))
create table oracle_data_source (id varchar(255) not null, data_source_expression varchar(255), data_source_type varchar(255), data_transformation_script varchar(255), primary key (id))
create table oracle_data_source_selector (oracle_data_source_id varchar(255) not null, selector varchar(255))
create table oracle_definition (id varchar(255) not null, contract_id varchar(255), contract_name varchar(255), signatures int4 not null, trigger varchar(255), window_size int4 not null, primary key (id))
create table oracle_definition_data_sources (oracle_definition_id varchar(255) not null, data_sources_id varchar(255) not null)
create table oracle_task (id varchar(255) not null, status varchar(255), version int4 not null, definition_id varchar(255), primary key (id))
create table oracle_task_data (oracle_task_id varchar(255) not null, data_id varchar(255) not null, primary key (oracle_task_id, data_id))
create table tx_queue_partition (id varchar(255) not null, created timestamp, last_enqueued_tx_id varchar(255), last_enqueued_tx_timestamp timestamp, last_read_tx_id varchar(255), modified timestamp, priority int4 not null, primary key (id))
alter table if exists oracle_definition_data_sources add constraint UK_tiqlxnvm4ybtwwcq7d17hctw6 unique (data_sources_id)
alter table if exists oracle_task_data add constraint UK_1jht4ow9n0fmebe9igqhdnsey unique (data_id)
alter table if exists enqueued_tx add constraint FKfbmng1sdtxg6en2xip6tn1laf foreign key (partition_id) references tx_queue_partition
alter table if exists oracle_data_source_selector add constraint FKbhi4e5n3dfxa0978ckecvnlxt foreign key (oracle_data_source_id) references oracle_data_source
alter table if exists oracle_definition_data_sources add constraint FKiavmy79dbsx3vr09hn6t553eb foreign key (data_sources_id) references oracle_data_source
alter table if exists oracle_definition_data_sources add constraint FK6xy3bflmdfoalfpse6nh07bj3 foreign key (oracle_definition_id) references oracle_definition
alter table if exists oracle_task add constraint FKek2le6sx71ka2a3o4lxidhluw foreign key (definition_id) references oracle_definition
alter table if exists oracle_task_data add constraint FK3oh5hatrfu51atpe2p0um5jsa foreign key (data_id) references oracle_data
alter table if exists oracle_task_data add constraint FK32novw4kmjlad3lnb8sqaebjc foreign key (oracle_task_id) references oracle_task
create table block_height_info (id uuid not null, created_timestamp timestamp, current_height int8 not null, node_alias varchar(255), update_timestamp timestamp, version int8, primary key (id))
create table enqueued_tx (id varchar(255) not null, block_height int8 not null, body uuid, created timestamp, modified timestamp, position_in_block int4 not null, status varchar(255), tx_timestamp timestamp, partition_id varchar(255), primary key (id))
create table oracle_data (id varchar(255) not null, public_key varchar(255), result varchar(255), signature varchar(255), primary key (id))
create table oracle_data_source (id varchar(255) not null, data_source_expression varchar(255), data_source_type varchar(255), data_transformation_script varchar(255), primary key (id))
create table oracle_data_source_selector (oracle_data_source_id varchar(255) not null, selector varchar(255))
create table oracle_definition (id varchar(255) not null, contract_id varchar(255), contract_name varchar(255), signatures int4 not null, trigger varchar(255), window_size int4 not null, primary key (id))
create table oracle_definition_data_sources (oracle_definition_id varchar(255) not null, data_sources_id varchar(255) not null)
create table oracle_task (id varchar(255) not null, status varchar(255), version int4 not null, definition_id varchar(255), primary key (id))
create table oracle_task_data (oracle_task_id varchar(255) not null, data_id varchar(255) not null, primary key (oracle_task_id, data_id))
create table tx_queue_partition (id varchar(255) not null, created timestamp, last_enqueued_tx_id varchar(255), last_enqueued_tx_timestamp timestamp, last_read_tx_id varchar(255), modified timestamp, priority int4 not null, primary key (id))
alter table if exists oracle_definition_data_sources add constraint UK_tiqlxnvm4ybtwwcq7d17hctw6 unique (data_sources_id)
alter table if exists oracle_task_data add constraint UK_1jht4ow9n0fmebe9igqhdnsey unique (data_id)
alter table if exists enqueued_tx add constraint FKfbmng1sdtxg6en2xip6tn1laf foreign key (partition_id) references tx_queue_partition
alter table if exists oracle_data_source_selector add constraint FKbhi4e5n3dfxa0978ckecvnlxt foreign key (oracle_data_source_id) references oracle_data_source
alter table if exists oracle_definition_data_sources add constraint FKiavmy79dbsx3vr09hn6t553eb foreign key (data_sources_id) references oracle_data_source
alter table if exists oracle_definition_data_sources add constraint FK6xy3bflmdfoalfpse6nh07bj3 foreign key (oracle_definition_id) references oracle_definition
alter table if exists oracle_task add constraint FKek2le6sx71ka2a3o4lxidhluw foreign key (definition_id) references oracle_definition
alter table if exists oracle_task_data add constraint FK3oh5hatrfu51atpe2p0um5jsa foreign key (data_id) references oracle_data
alter table if exists oracle_task_data add constraint FK32novw4kmjlad3lnb8sqaebjc foreign key (oracle_task_id) references oracle_task
create table block_height_info (id uuid not null, created_timestamp timestamp, current_height int8 not null, node_alias varchar(255), update_timestamp timestamp, version int8, primary key (id))
create table enqueued_tx (id varchar(255) not null, block_height int8 not null, body uuid, created timestamp, modified timestamp, position_in_block int4 not null, status varchar(255), tx_timestamp timestamp, partition_id varchar(255), primary key (id))
create table oracle_data (id varchar(255) not null, public_key varchar(255), result varchar(255), signature varchar(255), primary key (id))
create table oracle_data_source (id varchar(255) not null, data_source_expression varchar(255), data_source_type varchar(255), data_transformation_script varchar(255), primary key (id))
create table oracle_data_source_selector (oracle_data_source_id varchar(255) not null, selector varchar(255))
create table oracle_definition (id varchar(255) not null, contract_id varchar(255), contract_name varchar(255), signatures int4 not null, trigger varchar(255), window_size int4 not null, primary key (id))
create table oracle_definition_data_sources (oracle_definition_id varchar(255) not null, data_sources_id varchar(255) not null)
create table oracle_task (id varchar(255) not null, status varchar(255), version int4 not null, definition_id varchar(255), primary key (id))
create table oracle_task_data (oracle_task_id varchar(255) not null, data_id varchar(255) not null, primary key (oracle_task_id, data_id))
create table tx_queue_partition (id varchar(255) not null, created timestamp, last_enqueued_tx_id varchar(255), last_enqueued_tx_timestamp timestamp, last_read_tx_id varchar(255), modified timestamp, priority int4 not null, primary key (id))
alter table if exists oracle_definition_data_sources add constraint UK_tiqlxnvm4ybtwwcq7d17hctw6 unique (data_sources_id)
alter table if exists oracle_task_data add constraint UK_1jht4ow9n0fmebe9igqhdnsey unique (data_id)
alter table if exists enqueued_tx add constraint FKfbmng1sdtxg6en2xip6tn1laf foreign key (partition_id) references tx_queue_partition
alter table if exists oracle_data_source_selector add constraint FKbhi4e5n3dfxa0978ckecvnlxt foreign key (oracle_data_source_id) references oracle_data_source
alter table if exists oracle_definition_data_sources add constraint FKiavmy79dbsx3vr09hn6t553eb foreign key (data_sources_id) references oracle_data_source
alter table if exists oracle_definition_data_sources add constraint FK6xy3bflmdfoalfpse6nh07bj3 foreign key (oracle_definition_id) references oracle_definition
alter table if exists oracle_task add constraint FKek2le6sx71ka2a3o4lxidhluw foreign key (definition_id) references oracle_definition
alter table if exists oracle_task_data add constraint FK3oh5hatrfu51atpe2p0um5jsa foreign key (data_id) references oracle_data
alter table if exists oracle_task_data add constraint FK32novw4kmjlad3lnb8sqaebjc foreign key (oracle_task_id) references oracle_task
create table block_height_info (id uuid not null, created_timestamp timestamp, current_height int8 not null, node_alias varchar(255), update_timestamp timestamp, version int8, primary key (id))
create table enqueued_tx (id varchar(255) not null, block_height int8 not null, body uuid, created timestamp, modified timestamp, position_in_block int4 not null, status varchar(255), tx_timestamp timestamp, partition_id varchar(255), primary key (id))
create table oracle_data (id varchar(255) not null, public_key varchar(255), result varchar(255), signature varchar(255), primary key (id))
create table oracle_data_source (id varchar(255) not null, data_source_expression varchar(255), data_source_type varchar(255), data_transformation_script varchar(255), primary key (id))
create table oracle_data_source_selector (oracle_data_source_id varchar(255) not null, selector varchar(255))
create table oracle_definition (id varchar(255) not null, contract_id varchar(255), contract_name varchar(255), signatures int4 not null, trigger varchar(255), window_size int4 not null, primary key (id))
create table oracle_definition_data_sources (oracle_definition_id varchar(255) not null, data_sources_id varchar(255) not null)
create table oracle_task (id varchar(255) not null, status varchar(255), version int4 not null, definition_id varchar(255), primary key (id))
create table oracle_task_data (oracle_task_id varchar(255) not null, data_id varchar(255) not null, primary key (oracle_task_id, data_id))
create table tx_queue_partition (id varchar(255) not null, created timestamp, last_enqueued_tx_id varchar(255), last_enqueued_tx_timestamp timestamp, last_read_tx_id varchar(255), modified timestamp, priority int4 not null, primary key (id))
alter table if exists oracle_definition_data_sources add constraint UK_tiqlxnvm4ybtwwcq7d17hctw6 unique (data_sources_id)
alter table if exists oracle_task_data add constraint UK_1jht4ow9n0fmebe9igqhdnsey unique (data_id)
alter table if exists enqueued_tx add constraint FKfbmng1sdtxg6en2xip6tn1laf foreign key (partition_id) references tx_queue_partition
alter table if exists oracle_data_source_selector add constraint FKbhi4e5n3dfxa0978ckecvnlxt foreign key (oracle_data_source_id) references oracle_data_source
alter table if exists oracle_definition_data_sources add constraint FKiavmy79dbsx3vr09hn6t553eb foreign key (data_sources_id) references oracle_data_source
alter table if exists oracle_definition_data_sources add constraint FK6xy3bflmdfoalfpse6nh07bj3 foreign key (oracle_definition_id) references oracle_definition
alter table if exists oracle_task add constraint FKek2le6sx71ka2a3o4lxidhluw foreign key (definition_id) references oracle_definition
alter table if exists oracle_task_data add constraint FK3oh5hatrfu51atpe2p0um5jsa foreign key (data_id) references oracle_data
alter table if exists oracle_task_data add constraint FK32novw4kmjlad3lnb8sqaebjc foreign key (oracle_task_id) references oracle_task
create table block_height_info (id uuid not null, created_timestamp timestamp, current_height int8 not null, node_alias varchar(255), update_timestamp timestamp, version int8, primary key (id))
create table enqueued_tx (id varchar(255) not null, block_height int8 not null, body uuid, created timestamp, modified timestamp, position_in_block int4 not null, status varchar(255), tx_timestamp timestamp, partition_id varchar(255), primary key (id))
create table oracle_data (id varchar(255) not null, public_key varchar(255), result varchar(255), signature varchar(255), primary key (id))
create table oracle_data_source (id varchar(255) not null, data_source_expression varchar(255), data_source_type varchar(255), data_transformation_script varchar(255), primary key (id))
create table oracle_data_source_selector (oracle_data_source_id varchar(255) not null, selector varchar(255))
create table oracle_definition (id varchar(255) not null, contract_id varchar(255), contract_name varchar(255), signatures int4 not null, trigger varchar(255), window_size int4 not null, primary key (id))
create table oracle_definition_data_sources (oracle_definition_id varchar(255) not null, data_sources_id varchar(255) not null)
create table oracle_task (id varchar(255) not null, status varchar(255), version int4 not null, definition_id varchar(255), primary key (id))
create table oracle_task_data (oracle_task_id varchar(255) not null, data_id varchar(255) not null, primary key (oracle_task_id, data_id))
create table tx_queue_partition (id varchar(255) not null, created timestamp, last_enqueued_tx_id varchar(255), last_enqueued_tx_timestamp timestamp, last_read_tx_id varchar(255), modified timestamp, priority int4 not null, primary key (id))
alter table if exists oracle_definition_data_sources add constraint UK_tiqlxnvm4ybtwwcq7d17hctw6 unique (data_sources_id)
alter table if exists oracle_task_data add constraint UK_1jht4ow9n0fmebe9igqhdnsey unique (data_id)
alter table if exists enqueued_tx add constraint FKfbmng1sdtxg6en2xip6tn1laf foreign key (partition_id) references tx_queue_partition
alter table if exists oracle_data_source_selector add constraint FKbhi4e5n3dfxa0978ckecvnlxt foreign key (oracle_data_source_id) references oracle_data_source
alter table if exists oracle_definition_data_sources add constraint FKiavmy79dbsx3vr09hn6t553eb foreign key (data_sources_id) references oracle_data_source
alter table if exists oracle_definition_data_sources add constraint FK6xy3bflmdfoalfpse6nh07bj3 foreign key (oracle_definition_id) references oracle_definition
alter table if exists oracle_task add constraint FKek2le6sx71ka2a3o4lxidhluw foreign key (definition_id) references oracle_definition
alter table if exists oracle_task_data add constraint FK3oh5hatrfu51atpe2p0um5jsa foreign key (data_id) references oracle_data
alter table if exists oracle_task_data add constraint FK32novw4kmjlad3lnb8sqaebjc foreign key (oracle_task_id) references oracle_task
create table block_height_info (id uuid not null, created_timestamp timestamp, current_height int8 not null, node_alias varchar(255), update_timestamp timestamp, version int8, primary key (id))
create table enqueued_tx (id varchar(255) not null, block_height int8 not null, body uuid, created timestamp, modified timestamp, position_in_block int4 not null, status varchar(255), tx_timestamp timestamp, partition_id varchar(255), primary key (id))
create table oracle_data (id varchar(255) not null, public_key varchar(255), result varchar(255), signature varchar(255), primary key (id))
create table oracle_data_source (id varchar(255) not null, data_source_expression varchar(255), data_source_type varchar(255), data_transformation_script varchar(255), primary key (id))
create table oracle_data_source_selector (oracle_data_source_id varchar(255) not null, selector varchar(255))
create table oracle_definition (id varchar(255) not null, contract_id varchar(255), contract_name varchar(255), signatures int4 not null, trigger varchar(255), window_size int4 not null, primary key (id))
create table oracle_definition_data_sources (oracle_definition_id varchar(255) not null, data_sources_id varchar(255) not null)
create table oracle_task (id varchar(255) not null, status varchar(255), version int4 not null, definition_id varchar(255), primary key (id))
create table oracle_task_data (oracle_task_id varchar(255) not null, data_id varchar(255) not null, primary key (oracle_task_id, data_id))
create table tx_queue_partition (id varchar(255) not null, created timestamp, last_enqueued_tx_id varchar(255), last_enqueued_tx_timestamp timestamp, last_read_tx_id varchar(255), modified timestamp, priority int4 not null, primary key (id))
alter table if exists oracle_definition_data_sources add constraint UK_tiqlxnvm4ybtwwcq7d17hctw6 unique (data_sources_id)
alter table if exists oracle_task_data add constraint UK_1jht4ow9n0fmebe9igqhdnsey unique (data_id)
alter table if exists enqueued_tx add constraint FKfbmng1sdtxg6en2xip6tn1laf foreign key (partition_id) references tx_queue_partition
alter table if exists oracle_data_source_selector add constraint FKbhi4e5n3dfxa0978ckecvnlxt foreign key (oracle_data_source_id) references oracle_data_source
alter table if exists oracle_definition_data_sources add constraint FKiavmy79dbsx3vr09hn6t553eb foreign key (data_sources_id) references oracle_data_source
alter table if exists oracle_definition_data_sources add constraint FK6xy3bflmdfoalfpse6nh07bj3 foreign key (oracle_definition_id) references oracle_definition
alter table if exists oracle_task add constraint FKek2le6sx71ka2a3o4lxidhluw foreign key (definition_id) references oracle_definition
alter table if exists oracle_task_data add constraint FK3oh5hatrfu51atpe2p0um5jsa foreign key (data_id) references oracle_data
alter table if exists oracle_task_data add constraint FK32novw4kmjlad3lnb8sqaebjc foreign key (oracle_task_id) references oracle_task
create table block_height_info (id uuid not null, created_timestamp timestamp, current_height int8 not null, node_alias varchar(255), update_timestamp timestamp, version int8, primary key (id))
create table enqueued_tx (id varchar(255) not null, block_height int8 not null, body uuid, created timestamp, modified timestamp, position_in_block int4 not null, status varchar(255), tx_timestamp timestamp, partition_id varchar(255), primary key (id))
create table oracle_data (id varchar(255) not null, public_key varchar(255), result varchar(255), signature varchar(255), primary key (id))
create table oracle_data_source (id varchar(255) not null, data_source_expression varchar(255), data_source_type varchar(255), data_transformation_script varchar(255), primary key (id))
create table oracle_data_source_selector (oracle_data_source_id varchar(255) not null, selector varchar(255))
create table oracle_definition (id varchar(255) not null, contract_id varchar(255), contract_name varchar(255), signatures int4 not null, trigger varchar(255), window_size int4 not null, primary key (id))
create table oracle_definition_data_sources (oracle_definition_id varchar(255) not null, data_sources_id varchar(255) not null)
create table oracle_task (id varchar(255) not null, status varchar(255), version int4 not null, definition_id varchar(255), primary key (id))
create table oracle_task_data (oracle_task_id varchar(255) not null, data_id varchar(255) not null, primary key (oracle_task_id, data_id))
create table tx_queue_partition (id varchar(255) not null, created timestamp, last_enqueued_tx_id varchar(255), last_enqueued_tx_timestamp timestamp, last_read_tx_id varchar(255), modified timestamp, priority int4 not null, primary key (id))
alter table if exists oracle_definition_data_sources add constraint UK_tiqlxnvm4ybtwwcq7d17hctw6 unique (data_sources_id)
alter table if exists oracle_task_data add constraint UK_1jht4ow9n0fmebe9igqhdnsey unique (data_id)
alter table if exists enqueued_tx add constraint FKfbmng1sdtxg6en2xip6tn1laf foreign key (partition_id) references tx_queue_partition
alter table if exists oracle_data_source_selector add constraint FKbhi4e5n3dfxa0978ckecvnlxt foreign key (oracle_data_source_id) references oracle_data_source
alter table if exists oracle_definition_data_sources add constraint FKiavmy79dbsx3vr09hn6t553eb foreign key (data_sources_id) references oracle_data_source
alter table if exists oracle_definition_data_sources add constraint FK6xy3bflmdfoalfpse6nh07bj3 foreign key (oracle_definition_id) references oracle_definition
alter table if exists oracle_task add constraint FKek2le6sx71ka2a3o4lxidhluw foreign key (definition_id) references oracle_definition
alter table if exists oracle_task_data add constraint FK3oh5hatrfu51atpe2p0um5jsa foreign key (data_id) references oracle_data
alter table if exists oracle_task_data add constraint FK32novw4kmjlad3lnb8sqaebjc foreign key (oracle_task_id) references oracle_task
create table block_height_info (id uuid not null, created_timestamp timestamp, current_height int8 not null, node_alias varchar(255), update_timestamp timestamp, version int8, primary key (id))
create table enqueued_tx (id varchar(255) not null, block_height int8 not null, body uuid, created timestamp, modified timestamp, position_in_block int4 not null, status varchar(255), tx_timestamp timestamp, partition_id varchar(255), primary key (id))
create table oracle_data (id varchar(255) not null, public_key varchar(255), result varchar(255), signature varchar(255), primary key (id))
create table oracle_data_source (id varchar(255) not null, data_source_expression varchar(255), data_source_type varchar(255), data_transformation_script varchar(255), primary key (id))
create table oracle_data_source_selector (oracle_data_source_id varchar(255) not null, selector varchar(255))
create table oracle_definition (id varchar(255) not null, contract_id varchar(255), contract_name varchar(255), signatures int4 not null, trigger varchar(255), window_size int4 not null, primary key (id))
create table oracle_definition_data_sources (oracle_definition_id varchar(255) not null, data_sources_id varchar(255) not null)
create table oracle_task (id varchar(255) not null, status varchar(255), version int4 not null, definition_id varchar(255), primary key (id))
create table oracle_task_data (oracle_task_id varchar(255) not null, data_id varchar(255) not null, primary key (oracle_task_id, data_id))
create table tx_queue_partition (id varchar(255) not null, created timestamp, last_enqueued_tx_id varchar(255), last_enqueued_tx_timestamp timestamp, last_read_tx_id varchar(255), modified timestamp, priority int4 not null, primary key (id))
alter table if exists oracle_definition_data_sources add constraint UK_tiqlxnvm4ybtwwcq7d17hctw6 unique (data_sources_id)
alter table if exists oracle_task_data add constraint UK_1jht4ow9n0fmebe9igqhdnsey unique (data_id)
alter table if exists enqueued_tx add constraint FKfbmng1sdtxg6en2xip6tn1laf foreign key (partition_id) references tx_queue_partition
alter table if exists oracle_data_source_selector add constraint FKbhi4e5n3dfxa0978ckecvnlxt foreign key (oracle_data_source_id) references oracle_data_source
alter table if exists oracle_definition_data_sources add constraint FKiavmy79dbsx3vr09hn6t553eb foreign key (data_sources_id) references oracle_data_source
alter table if exists oracle_definition_data_sources add constraint FK6xy3bflmdfoalfpse6nh07bj3 foreign key (oracle_definition_id) references oracle_definition
alter table if exists oracle_task add constraint FKek2le6sx71ka2a3o4lxidhluw foreign key (definition_id) references oracle_definition
alter table if exists oracle_task_data add constraint FK3oh5hatrfu51atpe2p0um5jsa foreign key (data_id) references oracle_data
alter table if exists oracle_task_data add constraint FK32novw4kmjlad3lnb8sqaebjc foreign key (oracle_task_id) references oracle_task
create table block_height_info (id uuid not null, created_timestamp timestamp, current_height int8 not null, node_alias varchar(255), update_timestamp timestamp, version int8, primary key (id))
create table enqueued_tx (id varchar(255) not null, block_height int8 not null, body uuid, created timestamp, modified timestamp, position_in_block int4 not null, status varchar(255), tx_timestamp timestamp, partition_id varchar(255), primary key (id))
create table oracle_data (id varchar(255) not null, public_key varchar(255), result varchar(255), signature varchar(255), primary key (id))
create table oracle_data_source (id varchar(255) not null, data_source_expression varchar(255), data_source_type varchar(255), data_transformation_script varchar(255), primary key (id))
create table oracle_data_source_selector (oracle_data_source_id varchar(255) not null, selector varchar(255))
create table oracle_definition (id varchar(255) not null, contract_id varchar(255), contract_name varchar(255), signatures int4 not null, trigger varchar(255), window_size int4 not null, primary key (id))
create table oracle_definition_data_sources (oracle_definition_id varchar(255) not null, data_sources_id varchar(255) not null)
create table oracle_task (id varchar(255) not null, status varchar(255), version int4 not null, definition_id varchar(255), primary key (id))
create table oracle_task_data (oracle_task_id varchar(255) not null, data_id varchar(255) not null, primary key (oracle_task_id, data_id))
create table tx_queue_partition (id varchar(255) not null, created timestamp, last_enqueued_tx_id varchar(255), last_enqueued_tx_timestamp timestamp, last_read_tx_id varchar(255), modified timestamp, priority int4 not null, primary key (id))
alter table if exists oracle_definition_data_sources add constraint UK_tiqlxnvm4ybtwwcq7d17hctw6 unique (data_sources_id)
alter table if exists oracle_task_data add constraint UK_1jht4ow9n0fmebe9igqhdnsey unique (data_id)
alter table if exists enqueued_tx add constraint FKfbmng1sdtxg6en2xip6tn1laf foreign key (partition_id) references tx_queue_partition
alter table if exists oracle_data_source_selector add constraint FKbhi4e5n3dfxa0978ckecvnlxt foreign key (oracle_data_source_id) references oracle_data_source
alter table if exists oracle_definition_data_sources add constraint FKiavmy79dbsx3vr09hn6t553eb foreign key (data_sources_id) references oracle_data_source
alter table if exists oracle_definition_data_sources add constraint FK6xy3bflmdfoalfpse6nh07bj3 foreign key (oracle_definition_id) references oracle_definition
alter table if exists oracle_task add constraint FKek2le6sx71ka2a3o4lxidhluw foreign key (definition_id) references oracle_definition
alter table if exists oracle_task_data add constraint FK3oh5hatrfu51atpe2p0um5jsa foreign key (data_id) references oracle_data
alter table if exists oracle_task_data add constraint FK32novw4kmjlad3lnb8sqaebjc foreign key (oracle_task_id) references oracle_task
