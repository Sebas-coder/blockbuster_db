BEGIN;
    DROP TABLE IF EXISTS persons;

    CREATE TABLE persons (
        id          SERIAL,
        first_name  VARCHAR(50),
        last_name   VARCHAR(50),
        dob         DATE,
        email       VARCHAR(255),
        PRIMARY KEY (id)
    );
COMMIT;

COPY persons(first_name, last_name, dob, email)
FROM '/home/sebastian/Escritorio/blockbuster/persons.csv'
DELIMITER ';'
CSV HEADER;

--  Tienda 1 | 47 Lou Fresco Drive   | 47 Lou Fresco Drive   | Canada
--  Tienda 2 | 28 Dannigaz Boulevard | 28 Dannigaz Boulevard | Australia

-- SELECT INITCAP(t.nombre_tienda), INITCAP(t.direccion_tienda), INITCAP(t.ciudad_tienda), INITCAP(t.pais_tienda)
        -- FROM TEMPORAL t
        -- WHERE t.nombre_tienda <> '-' AND t.direccion_tienda <> '-' 
        -- AND t.ciudad_tienda <> '-' AND t.pais_tienda <> '-'
        -- GROUP BY (INITCAP(t.nombre_tienda), INITCAP(t.direccion_tienda), INITCAP(t.ciudad_tienda), INITCAP(t.pais_tienda));

        -- -- UNION

        -- SELECT c.id, c.nombre, c.pais FROM TEMPORAL t, ciudad c 
        -- WHERE INITCAP(c.nombre) = INITCAP(t.ciudad_tienda) AND INITCAP(c.pais) = INITCAP(t.pais_tienda) AND
        -- t.nombre_tienda <> '-' AND t.direccion_tienda <> '-'
        -- GROUP BY (INITCAP(t.ciudad_tienda), INITCAP(t.pais_tienda), c.id);

BEGIN;
    DROP TABLE IF EXISTS TEMPORAL;

    CREATE TABLE TEMPORAL(
        id                      SERIAL,
        nombre_cliente          VARCHAR(100),
        correo_cliente          VARCHAR(100),
        cliente_activo          VARCHAR(100),
        fecha_creacion          DATE,
        tienda_preferida        VARCHAR(100),
        direccion_cliente       VARCHAR(100),
        codigo_postal_cliente   INTEGER,
        ciudad_cliente          VARCHAR(100),
        pais_cliente            VARCHAR(100),
        fecha_renta             TIMESTAMP,
        fecha_retorno           TIMESTAMP,
        monto_a_pagar           DOUBLE PRECISION,
        fecha_pago              TIMESTAMP,
        nombre_empleado         VARCHAR(100),
        correo_empleado         VARCHAR(100),
        empleado_activo         VARCHAR(100),
        tienda_empleado         VARCHAR(100),
        usuario_empleado        VARCHAR(100),
        contraseniaa_empleado   VARCHAR(100),
        direccion_empleado      VARCHAR(100),
        codigo_postal_empleado  INTEGER,
        ciudad_empleado         VARCHAR(100),
        pais_empleado           VARCHAR(100),
        nombre_tienda           VARCHAR(100),
        encargado_tienda        VARCHAR(100),
        direccion_tienda        VARCHAR(100),
        codigo_postal_tienda    INTEGER,
        ciudad_tienda           VARCHAR(100),
        pais_tienda             VARCHAR(100),
        tienda_pelicula         VARCHAR(100),
        nombre_pelicula         VARCHAR(100),
        descripcion_pelicula    VARCHAR(100),
        anio_lanzamiento        INTEGER,
        dias_renta              INTEGER,
        costo_renta             DOUBLE PRECISION,
        duracion                DOUBLE PRECISION,
        costo_por_danio         DOUBLE PRECISION,
        clasificacion           VARCHAR(100),
        lenguaje_pelicula       VARCHAR(100),
        categoria_pelicula      VARCHAR(100),
        actor_pelicula          VARCHAR(100),
        PRIMARY KEY(id)
    );
COMMIT;


BEGIN;
    SELECT INITCAP(t.clasificacion) AS CLASIFICACION FROM TEMPORAL t GROUP BY INITCAP(t.clasificacion);
    SELECT INITCAP(t.actor_pelicula) AS ACTORES FROM TEMPORAL t GROUP BY INITCAP(t.actor_pelicula);
    SELECT INITCAP(t.categoria_pelicula) AS CATEGORIAS FROM TEMPORAL t GROUP BY INITCAP(t.categoria_pelicula);
COMMIT;



CREATE TABLE direccion(
    descripcion     VARCHAR(500) NOT NULL,
    distrito        VARCHAR(500) NOT NULL,
    codigo_postal   VARCHAR(500) NOT NULL,
    PRIMARY KEY(nombre, pais)
);

CREATE TABLE pelicula_actor(
    pelicula_id INT NOT NULL REFERENCES pelicula(id),
    actor_id INT NOT NULL REFERENCES actor(id),
    PRIMARY KEY(pelicula_id, actor_id)
);

-- \i /home/sebastian/Escritorio/blockbuster/scriptsql/[MIA]ScriptTT_201800712.sql
-- \i /home/sebastian/Escritorio/blockbuster/scriptsql/[MIA]ScriptMR_201800712.sql
-- \i /home/sebastian/Escritorio/blockbuster/scriptsql/[MIA]CargaDeDatos_201800712.sql


SELECT INITCAP(t.nombre_cliente) NOMBRE, INITCAP(t.nombre_empleado) CORREO,
            INITCAP(t.nombre_pelicula) PELICULA, INITCAP(t.costo_renta) COSTOR,
            INITCAP(t.costo_por_danio) costo_daniito,
            INITCAP(t.fecha_renta) FECHA, INITCAP(t.fecha_retorno) TEINDA,
            INITCAP(t.monto_a_pagar) MONTO, INITCAP(t.fecha_pago) TEINDA
    FROM TEMPORAL t
    WHERE   t.nombre_cliente <> '-' AND t.nombre_empleado <> '-' AND 
            t.fecha_renta <> '-' AND t.fecha_retorno <> '-' AND 
            t.nombre_pelicula <> '-' AND t.costo_renta <> '-' AND 
            t.monto_a_pagar <> '-' AND t.fecha_pago <> '-' 

    GROUP BY (  
            INITCAP(t.nombre_cliente), 
            INITCAP(t.nombre_empleado),
            INITCAP(t.fecha_renta),
            INITCAP(t.fecha_retorno),
            INITCAP(t.monto_a_pagar),
            INITCAP(t.nombre_pelicula),
            INITCAP(t.costo_renta),
            INITCAP(t.costo_por_danio),
            INITCAP(t.fecha_pago)
            ); 

    -- datos de alquiler
    SELECT INITCAP(t.nombre_cliente) NOMBRE, INITCAP(t.nombre_empleado) CORREO,
            INITCAP(t.nombre_pelicula) PELICULA, INITCAP(t.costo_renta) COSTOR,
            INITCAP(t.costo_por_danio) costo_daniito,
            INITCAP(t.fecha_renta) FECHA, INITCAP(t.fecha_retorno) TEINDA,
            INITCAP(t.monto_a_pagar) MONTO, INITCAP(t.fecha_pago) TEINDA
    FROM TEMPORAL t
    WHERE   t.nombre_cliente <> '-' AND t.nombre_empleado <> '-' AND 
            t.fecha_renta <> '-' AND t.fecha_retorno <> '-' AND 
            t.nombre_pelicula <> '-' AND t.costo_renta <> '-' AND 
            t.monto_a_pagar <> '-' AND t.fecha_pago <> '-' 

    GROUP BY (  
            INITCAP(t.nombre_cliente), 
            INITCAP(t.nombre_empleado),
            INITCAP(t.fecha_renta),
            INITCAP(t.fecha_retorno),
            INITCAP(t.monto_a_pagar),
            INITCAP(t.nombre_pelicula),
            INITCAP(t.costo_renta),
            INITCAP(t.costo_por_danio),
            INITCAP(t.fecha_pago)
            ); 
    -- union de peli_tienda almacen

-- INSERT INTO tienda(nombre, direccion, ciudad_id)
        -- SELECT INITCAP(t.nombre_tienda) NOMBRE, INITCAP(t.direccion_tienda) DIRECCION, c.id
        -- FROM TEMPORAL t, ciudad c 
        -- WHERE t.nombre_tienda <> '-' AND t.direccion_tienda <> '-' 
        -- AND t.ciudad_tienda <> '-' AND t.pais_tienda <> '-' AND
        -- INITCAP(c.nombre) = INITCAP(t.ciudad_tienda) AND INITCAP(c.pais) = INITCAP(t.pais_tienda)
        -- GROUP BY (INITCAP(t.nombre_tienda), INITCAP(t.direccion_tienda), c.id);



        SELECT  INITCAP(SPLIT_PART(t.nombre_cliente,' ', 1)) nombre_cliente, 
                INITCAP(SPLIT_PART(t.nombre_cliente, ' ', 2)) apellido_cliente,
                INITCAP(t.correo_cliente) correo_cliente,
                INITCAP(t.cliente_activo) = 'Si' AS cliente_activo,
                CAST (t.fecha_creacion AS TIMESTAMP) fecha_creacion,
                ti.id tienda,
                d.id direccion

        FROM TEMPORAL t, direccion d, tienda ti
        WHERE   t.nombre_cliente <> '-' AND t.correo_cliente <> '-' AND
                t.cliente_activo <> '-' AND t.tienda_preferida <> '-' AND
                t.direccion_cliente <> '-' AND t.codigo_postal_cliente <> '-' AND
                t.ciudad_cliente <> '-' AND t.pais_cliente <> '-' AND
                t.fecha_creacion <> '-' AND

                ti.id = (SELECT tie.id FROM tienda tie WHERE INITCAP(t.tienda_preferida) = INITCAP(tie.nombre) ) AND

                d.ciudad_id = (SELECT c.id FROM ciudad c WHERE INITCAP(t.ciudad_cliente) = INITCAP(c.nombre) AND INITCAP(t.pais_tienda) = INITCAP(c.pais)) AND
                d.codigo_postal = CAST (t.codigo_postal_cliente AS INTEGER) 

        GROUP BY( INITCAP(SPLIT_PART(t.nombre_cliente,' ', 1)), 
                INITCAP(SPLIT_PART(t.nombre_cliente, ' ', 2)),
                INITCAP(t.correo_cliente),
                INITCAP(t.cliente_activo),      
                INITCAP(t.tienda_preferida),
                INITCAP(t.direccion_cliente),
                INITCAP(t.codigo_postal_cliente),
                INITCAP(t.ciudad_cliente),
                CAST (t.fecha_creacion AS TIMESTAMP),
                INITCAP(t.pais_cliente),
                ti.id,
                d.id
                );





-- cleentes sinsnasknaskoj tienda
SELECT  INITCAP(SPLIT_PART(t.nombre_cliente,' ', 1)) nombre_cliente, 
                INITCAP(SPLIT_PART(t.nombre_cliente, ' ', 2)) apellido_cliente,
                INITCAP(t.correo_cliente) correo_cliente,
                INITCAP(t.cliente_activo) = 'Si' AS cliente_activo,
                CAST (t.fecha_creacion AS TIMESTAMP) fecha_creacion,
                d.id direccion

        FROM TEMPORAL t, direccion d
        WHERE   t.nombre_cliente <> '-' AND t.correo_cliente <> '-' AND
                t.cliente_activo <> '-' AND t.tienda_preferida <> '-' AND
                t.direccion_cliente <> '-' AND t.codigo_postal_cliente <> '-' AND
                t.ciudad_cliente <> '-' AND t.pais_cliente <> '-' AND
                t.fecha_creacion <> '-' AND

                INITCAP(d.descripcion) = INITCAP(t.direccion_cliente) AND 
                d.ciudad_id = (SELECT c.id FROM ciudad c WHERE INITCAP(t.ciudad_cliente) = INITCAP(c.nombre) AND INITCAP(t.pais_cliente) = INITCAP(c.pais)) 
                AND d.codigo_postal = CAST (t.codigo_postal_cliente AS INTEGER) 

        GROUP BY( INITCAP(SPLIT_PART(t.nombre_cliente,' ', 1)), 
                INITCAP(SPLIT_PART(t.nombre_cliente, ' ', 2)),
                INITCAP(t.correo_cliente),
                INITCAP(t.cliente_activo),      
                INITCAP(t.tienda_preferida),
                INITCAP(t.direccion_cliente),
                INITCAP(t.codigo_postal_cliente),
                INITCAP(t.ciudad_cliente),
                INITCAP(t.pais_cliente),
                CAST (t.fecha_creacion AS TIMESTAMP),
                d.id
                );


















                SELECT  INITCAP(SPLIT_PART(t.nombre_cliente,' ', 1)) nombre_cliente, 
            INITCAP(SPLIT_PART(t.nombre_cliente, ' ', 2)) apellido_cliente,
            INITCAP(t.correo_cliente) correo_cliente,
            INITCAP(t.cliente_activo) = 'Si' AS cliente_activo,
            CAST (t.fecha_creacion AS TIMESTAMP) fecha_creacion,

    FROM TEMPORAL t 

    WHERE   t.nombre_cliente <> '-' AND t.correo_cliente <> '-' AND
            t.cliente_activo <> '-' AND t.tienda_preferida <> '-' AND
            t.direccion_cliente <> '-' AND t.codigo_postal_cliente <> '-' AND
            t.ciudad_cliente <> '-' AND t.pais_cliente <> '-' AND
            t.fecha_creacion <> '-' 

    GROUP BY( INITCAP(SPLIT_PART(t.nombre_cliente,' ', 1)), 
            INITCAP(SPLIT_PART(t.nombre_cliente, ' ', 2)),
            INITCAP(t.correo_cliente),
            INITCAP(t.cliente_activo),
            INITCAP(t.tienda_preferida),
            INITCAP(t.direccion_cliente),
            INITCAP(t.codigo_postal_cliente),
            INITCAP(t.ciudad_cliente),
            CAST (t.fecha_creacion AS TIMESTAMP),
            INITCAP(t.pais_cliente)
            );