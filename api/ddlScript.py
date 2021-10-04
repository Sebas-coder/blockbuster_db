DROP_TEMPORAL = ''' 
    DROP TABLE IF EXISTS TEMPORAL;
'''
ELIMINAR_TEMPORAL = ''' 
    TRUNCATE TABLE TEMPORAL;
'''

DROP_MODELO = ''' 
    DROP TABLE IF EXISTS pelicula CASCADE;
    DROP TABLE IF EXISTS categoria CASCADE;
    DROP TABLE IF EXISTS actor CASCADE;
    DROP TABLE IF EXISTS ciudad CASCADE;
    DROP TABLE IF EXISTS pelicula_actor CASCADE;
    DROP TABLE IF EXISTS pelicula_categoria CASCADE;
    DROP TABLE IF EXISTS tienda CASCADE;
    DROP TABLE IF EXISTS cliente CASCADE;
    DROP TABLE IF EXISTS empleado CASCADE;
    DROP TABLE IF EXISTS clasificacion CASCADE;
    DROP TABLE IF EXISTS direccion CASCADE;
    DROP TABLE IF EXISTS pelicula_tienda CASCADE;
    DROP TABLE IF EXISTS renta CASCADE;
'''

ELIMINAR_MODELO = ''' 
    TRUNCATE TABLE ciudad RESTART IDENTITY CASCADE;
    TRUNCATE TABLE pelicula RESTART IDENTITY CASCADE;
    TRUNCATE TABLE categoria RESTART IDENTITY CASCADE;
    TRUNCATE TABLE actor RESTART IDENTITY CASCADE;
    TRUNCATE TABLE tienda RESTART IDENTITY CASCADE;
    TRUNCATE TABLE pelicula_actor RESTART IDENTITY CASCADE;
    TRUNCATE TABLE direccion RESTART IDENTITY CASCADE;
    TRUNCATE TABLE pelicula_tienda RESTART IDENTITY CASCADE;
    TRUNCATE TABLE renta RESTART IDENTITY CASCADE;
    TRUNCATE TABLE cliente RESTART IDENTITY CASCADE;
    TRUNCATE TABLE empleado RESTART IDENTITY CASCADE;
    TRUNCATE TABLE pelicula_categoria RESTART IDENTITY CASCADE;
    TRUNCATE TABLE clasificacion RESTART IDENTITY CASCADE;
'''

CARGAR_TEMPORAL = ''' 
    CREATE TABLE TEMPORAL(
        id                      SERIAL,
        nombre_cliente          VARCHAR(500),
        correo_cliente          VARCHAR(500),
        cliente_activo          VARCHAR(500),
        fecha_creacion          VARCHAR(500),
        tienda_preferida        VARCHAR(500),
        direccion_cliente       VARCHAR(500),
        codigo_postal_cliente   VARCHAR(500),
        ciudad_cliente          VARCHAR(500),
        pais_cliente            VARCHAR(500),
        fecha_renta             VARCHAR(500),
        fecha_retorno           VARCHAR(500),
        monto_a_pagar           VARCHAR(500),
        fecha_pago              VARCHAR(500),
        nombre_empleado         VARCHAR(500),
        correo_empleado         VARCHAR(500),
        empleado_activo         VARCHAR(500),
        tienda_empleado         VARCHAR(500),
        usuario_empleado        VARCHAR(500),
        contraseniaa_empleado   VARCHAR(500),
        direccion_empleado      VARCHAR(500),
        codigo_postal_empleado  VARCHAR(500),
        ciudad_empleado         VARCHAR(500),
        pais_empleado           VARCHAR(500),
        nombre_tienda           VARCHAR(500),
        encargado_tienda        VARCHAR(500),
        direccion_tienda        VARCHAR(500),
        codigo_postal_tienda    VARCHAR(500),
        ciudad_tienda           VARCHAR(500),
        pais_tienda             VARCHAR(500),
        tienda_pelicula         VARCHAR(500),
        nombre_pelicula         VARCHAR(500),
        descripcion_pelicula    VARCHAR(500),
        anio_lanzamiento        VARCHAR(500),
        dias_renta              VARCHAR(500),
        costo_renta             VARCHAR(500),
        duracion                VARCHAR(500),
        costo_por_danio         VARCHAR(500),
        clasificacion           VARCHAR(500),
        lenguaje_pelicula       VARCHAR(500),
        categoria_pelicula      VARCHAR(500),
        actor_pelicula          VARCHAR(500),
        PRIMARY KEY(id)
    );


    COPY   TEMPORAL(nombre_cliente,
                correo_cliente,
                cliente_activo,
                fecha_creacion,
                tienda_preferida,
                direccion_cliente,
                codigo_postal_cliente,
                ciudad_cliente,
                pais_cliente,
                fecha_renta,
                fecha_retorno,
                monto_a_pagar,
                fecha_pago,
                nombre_empleado,
                correo_empleado,
                empleado_activo,
                tienda_empleado,
                usuario_empleado,
                contraseniaa_empleado,
                direccion_empleado,
                codigo_postal_empleado,
                ciudad_empleado,
                pais_empleado,
                nombre_tienda,
                encargado_tienda,
                direccion_tienda,
                codigo_postal_tienda,
                ciudad_tienda,
                pais_tienda,
                tienda_pelicula,
                nombre_pelicula,
                descripcion_pelicula,
                anio_lanzamiento,
                dias_renta,
                costo_renta,
                duracion,
                costo_por_danio,
                clasificacion,
                lenguaje_pelicula,
                categoria_pelicula,
                actor_pelicula) 
    FROM '/home/sebastian/Escritorio/blockbuster/csv_blockbuster/BlockbusterData.csv' 
    DELIMITER ';'
    CSV HEADER;
'''

CARGA_MODELO = ''' 
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
'''