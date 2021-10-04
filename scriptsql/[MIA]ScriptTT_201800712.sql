
-- * Creado por: Jairo Ramirez.
-- * Descripcion: Borrado y creado de la tabla temporal.

-- ~ borrado y creacion de base de datos 
-- DROP DATABASE IF EXISTS blockbuster;
-- CREATE DATABASE blockbuster;

-- ~ borrado y creacion de tablas
BEGIN;
    SET CLIENT_ENCODING TO 'UTF8';
    DROP TABLE IF EXISTS TEMPORAL;

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
    FROM '/home/sebastian/Escritorio/blockbuster/BlockbusterData.csv' 
    DELIMITER ';'
    CSV HEADER;

COMMIT;

-- carga masiva a tabla temporal  
-- COPY   TEMPORAL(nombre_cliente,
--                 correo_cliente,
--                 cliente_activo,
--                 fecha_creacion,
--                 tienda_preferida,
--                 direccion_cliente,
--                 codigo_postal_cliente,
--                 ciudad_cliente,
--                 pais_cliente,
--                 fecha_renta,
--                 fecha_retorno,
--                 monto_a_pagar,
--                 fecha_pago,
--                 nombre_empleado,
--                 correo_empleado,
--                 empleado_activo,
--                 tienda_empleado,
--                 usuario_empleado,
--                 contraseniaa_empleado,
--                 direccion_empleado,
--                 codigo_postal_empleado,
--                 ciudad_empleado,
--                 pais_empleado,
--                 nombre_tienda,
--                 encargado_tienda,
--                 direccion_tienda,
--                 codigo_postal_tienda,
--                 ciudad_tienda,
--                 pais_tienda,
--                 tienda_pelicula,
--                 nombre_pelicula,
--                 descripcion_pelicula,
--                 anio_lanzamiento,
--                 dias_renta,
--                 costo_renta,
--                 duracion,
--                 costo_por_danio,
--                 clasificacion,
--                 lenguaje_pelicula,
--                 categoria_pelicula,
--                 actor_pelicula) 
-- FROM '/home/sebastian/Escritorio/blockbuster/BlockbusterData.csv' 
-- DELIMITER ';'
-- CSV HEADER;

