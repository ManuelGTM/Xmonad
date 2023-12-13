create table person (
    id serial not null,
    nombre varchar(50),
    estado varchar(20) default 'A',

    PRIMARY KEY (id)
);

insert into person (nombre, estado) values ('Manuel', 'Torres');
insert into person (nombre, estado) values ('Maria', 'Dominguez');
insert into person (nombre, estado) values ('Emmanuel', 'Torres');
insert into person (nombre, estado) values ('Rhoanny', 'Malena');
insert into person (nombre, estado) values ('Nataly', 'Fabre');

