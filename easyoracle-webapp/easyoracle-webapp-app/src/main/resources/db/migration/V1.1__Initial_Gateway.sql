-- Transaction tracker required tables
create table gateway_address_mapping
(
    id varchar(100) not null
        constraint gateway_address_mapping_pkey
            primary key,
    source_address varchar(255) not null,
    target_address varchar(255) not null
);

create table sber_block_height_info
(
    id varchar(100) not null
        constraint sber_block_height_info_pkey
            primary key,
    height bigint not null
);