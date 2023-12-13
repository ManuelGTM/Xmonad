CREATE TABLE anime (
    id serial not null,
    nombre varchar(100),
    anime varchar(100),
    power varchar(100),
    status varchar(50) default 'vivo',

    PRIMARY KEY(id)

);


