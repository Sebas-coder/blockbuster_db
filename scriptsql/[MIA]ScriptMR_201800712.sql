-- * Creado por: Jairo Ramirez.
-- * Descripcion: Borrado y creado de la base de datos propuesta en el modelo relacional.

-- ~ borrado y creacion de tablas
BEGIN;
    DROP TABLE IF EXISTS pelicula CASCADE;
    DROP TABLE IF EXISTS actor CASCADE;
    DROP TABLE IF EXISTS ciudad CASCADE;
    DROP TABLE IF EXISTS pelicula_tienda CASCADE;
    DROP TABLE IF EXISTS pelicula_categoria CASCADE;
    DROP TABLE IF EXISTS pelicula_actor CASCADE;
    DROP TABLE IF EXISTS renta CASCADE;
    DROP TABLE IF EXISTS categoria CASCADE;
    DROP TABLE IF EXISTS tienda CASCADE;
    DROP TABLE IF EXISTS cliente CASCADE;
    DROP TABLE IF EXISTS empleado CASCADE;
    DROP TABLE IF EXISTS clasificacion CASCADE;
    DROP TABLE IF EXISTS direccion CASCADE;
COMMIT;

-- ~ declaracion de tablas 
BEGIN;
    CREATE TABLE categoria(
        id          SERIAL,
        nombre      varchar(500) NOT NULL,
        primary key(id)
    );

    CREATE TABLE actor(
        id          SERIAL,
        nombre      varchar(500) NOT NULL,
        primary key(id)
    );
    
    CREATE TABLE clasificacion(
        id          SERIAL,
        nombre      varchar(500) NOT NULL,
        primary key(id)
    );
    
    CREATE TABLE pelicula(
        id                  SERIAL,
        titulo              varchar(500) NOT NULL,
        descripcion         varchar(500) NOT NULL,
        anio_lanzamiento    INTEGER NOT NULL,
        dias_renta          INTEGER NOT NULL,
        costo_renta         DOUBLE PRECISION NOT NULL,
        duracion            DOUBLE PRECISION NOT NULL,
        costo_danio         DOUBLE PRECISION NOT NULL,
        clasificacion       varchar(500) NOT NULL,
        idioma_original     varchar(500) NOT NULL,
        primary key(id)
    );

    CREATE TABLE pelicula_actor(
        id          SERIAL,
        pelicula_id INTEGER NOT NULL REFERENCES pelicula(id),
        actor_id    INTEGER NOT NULL REFERENCES actor(id),
        PRIMARY KEY(id)
    );
    
    CREATE TABLE pelicula_categoria(
        id              SERIAL,
        pelicula_id     INTEGER NOT NULL REFERENCES pelicula(id),
        categoria_id    INTEGER NOT NULL REFERENCES categoria(id),
        PRIMARY KEY(id)
    );
    
    CREATE TABLE ciudad(
        id          SERIAL,
        nombre      varchar(500) NOT NULL,
        pais        varchar(500) NOT NULL,
        primary key(id)
    );
    
    CREATE TABLE direccion(
        id              SERIAL,
        descripcion     varchar(500) NOT NULL,
        codigo_postal   INTEGER,
        ciudad_id       INTEGER NOT NULL REFERENCES ciudad(id),
        primary key(id)
    );
    
    CREATE TABLE tienda(
        id              SERIAL,
        nombre          varchar(500) NOT NULL,
        direccion_id    INTEGER NOT NULL REFERENCES direccion(id),
        primary key(id)
    );

    CREATE TABLE cliente(
        id              SERIAL,
        nombre          varchar(500) NOT NULL,
        apellido        varchar(500) NOT NULL,
        correo          varchar(500) NOT NULL,
        activo          BOOLEAN NOT NULL,
        fecha_creacion  TIMESTAMP NOT NULL,
        tienda_id       INTEGER NOT NULL REFERENCES tienda(id),
        direccion_id    INTEGER NOT NULL REFERENCES direccion(id),
        primary key(id)
    );
    
    CREATE TABLE empleado(
        id              SERIAL,
        nombre          varchar(500) NOT NULL,
        apellido        varchar(500) NOT NULL,
        correo          varchar(500) NOT NULL,
        usuario         varchar(500) NOT NULL,
        contrasenia     varchar(500) NOT NULL,
        activo          BOOLEAN NOT NULL,
        tienda_id       INTEGER NOT NULL REFERENCES tienda(id),
        direccion_id    INTEGER NOT NULL REFERENCES direccion(id),
        tipo_plaza      varchar(500) NOT NULL,
        primary key(id)
    );

    CREATE TABLE pelicula_tienda(
        id              SERIAL,
        tienda_id       INTEGER NOT NULL REFERENCES tienda(id),
        pelicula_id     INTEGER NOT NULL REFERENCES pelicula(id),
        primary key(id)
    );
    
    CREATE TABLE renta(
        id              SERIAL,
        cliente_id      INTEGER NOT NULL REFERENCES cliente(id),
        empleado_id     INTEGER NOT NULL REFERENCES empleado(id),
        pelicula_id     INTEGER NOT NULL REFERENCES pelicula(id),
        fecha_renta     TIMESTAMP NOT NULL,
        fecha_retorno   TIMESTAMP,
        fecha_pago      TIMESTAMP NOT NULL,
        monto_a_pagar   DOUBLE PRECISION NOT NULL,
        primary key(id)
    );
    
COMMIT;
