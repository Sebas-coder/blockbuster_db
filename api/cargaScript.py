CARGA_MASIVA= ''' 
    INSERT INTO ciudad(nombre, pais)
        SELECT INITCAP(t.ciudad_cliente), INITCAP(t.pais_cliente)
        FROM TEMPORAL t WHERE t.ciudad_cliente <> '-' AND t.pais_cliente <> '-' AND 
        NOT EXISTS (SELECT c.nombre, c.pais FROM ciudad c 
        WHERE INITCAP(c.nombre) = INITCAP(t.ciudad_cliente) AND INITCAP(c.pais) = INITCAP(t.pais_cliente))
        GROUP BY (INITCAP(t.ciudad_cliente), INITCAP(t.pais_cliente));
        
        -- empleado
        INSERT INTO ciudad(nombre, pais)
        SELECT INITCAP(t.ciudad_empleado), INITCAP(t.pais_empleado)
        FROM TEMPORAL t WHERE t.ciudad_empleado <> '-' AND t.pais_empleado <> '-' AND 
        NOT EXISTS (SELECT c.nombre, c.pais FROM ciudad c 
        WHERE INITCAP(c.nombre) = INITCAP(t.ciudad_empleado) AND INITCAP(c.pais) = INITCAP(t.pais_empleado))
        GROUP BY (INITCAP(t.ciudad_empleado), INITCAP(t.pais_empleado));
        
        -- ciudad
        INSERT INTO ciudad(nombre, pais)
        SELECT INITCAP(t.ciudad_tienda), INITCAP(t.pais_tienda)
        FROM TEMPORAL t WHERE t.ciudad_tienda <> '-' AND t.pais_tienda <> '-' AND
        NOT EXISTS (SELECT c.nombre, c.pais FROM ciudad c 
        WHERE INITCAP(c.nombre) = INITCAP(t.ciudad_tienda) AND INITCAP(c.pais) = INITCAP(t.pais_tienda))
        GROUP BY (INITCAP(t.ciudad_tienda), INITCAP(t.pais_tienda));

        -- ~ carga de direcciones
        -- tiendas 
        INSERT INTO direccion(descripcion, codigo_postal, ciudad_id)
        SELECT  INITCAP(t.direccion_tienda) DESCRIPCION,
                CASE 
                        WHEN t.codigo_postal_tienda = '-' THEN NULL
                        ELSE CAST (t.codigo_postal_tienda AS INTEGER)
                END  AS CP,
                c.id AS ID
        FROM TEMPORAL t, ciudad c 
        WHERE   t.direccion_tienda <> '-' AND
                t.ciudad_tienda <> '-' AND t.pais_tienda <> '-'AND
                INITCAP(c.nombre) = INITCAP(t.ciudad_tienda) AND INITCAP(c.pais) = INITCAP(t.pais_tienda) 
        AND NOT EXISTS (SELECT * FROM direccion d
                        WHERE   c.id = d.ciudad_id AND INITCAP(t.direccion_tienda) = INITCAP(d.descripcion))
        GROUP BY(INITCAP(t.direccion_tienda), t.codigo_postal_tienda, c.id);
        
        -- empleados 
        INSERT INTO direccion(descripcion, codigo_postal, ciudad_id)
        SELECT  INITCAP(t.direccion_empleado) DESCRIPCION,
                CASE 
                        WHEN t.codigo_postal_empleado = '-' THEN NULL
                        ELSE CAST (t.codigo_postal_empleado AS INTEGER)
                END  AS CP,
                c.id AS ID
        FROM TEMPORAL t, ciudad c 
        WHERE   t.direccion_empleado <> '-' AND
                t.ciudad_empleado <> '-' AND t.pais_empleado <> '-'AND
                INITCAP(c.nombre) = INITCAP(t.ciudad_empleado) AND INITCAP(c.pais) = INITCAP(t.pais_empleado) 
        AND NOT EXISTS (SELECT * FROM direccion d
                        WHERE   c.id = d.ciudad_id AND INITCAP(t.direccion_empleado) = INITCAP(d.descripcion))
        GROUP BY(INITCAP(t.direccion_empleado), t.codigo_postal_empleado, c.id);

        -- cliente
        INSERT INTO direccion(descripcion, codigo_postal, ciudad_id)
        SELECT  INITCAP(t.direccion_cliente) DESCRIPCION, CAST (t.codigo_postal_cliente AS INTEGER) AS CP , c.id AS ID
        FROM TEMPORAL t, ciudad c 
        WHERE   t.direccion_cliente <> '-' AND t.codigo_postal_cliente <> '-' AND
                t.ciudad_cliente <> '-' AND t.pais_cliente <> '-'AND

                INITCAP(c.nombre) = INITCAP(t.ciudad_cliente) AND INITCAP(c.pais) = INITCAP(t.pais_cliente) AND
        NOT EXISTS (SELECT * FROM direccion d
        WHERE   c.id = d.ciudad_id AND CAST (t.codigo_postal_cliente AS INTEGER) = d.codigo_postal AND
                INITCAP(t.direccion_cliente) = INITCAP(d.descripcion))
        GROUP BY( INITCAP(t.direccion_cliente), CAST (t.codigo_postal_cliente AS INTEGER), c.id);
        
        -- ================================================== TIENDAS ================================================== 
           -- carga de tienda(nombre, direccion_id)
        INSERT INTO tienda(nombre, direccion_id)
        SELECT INITCAP(t.nombre_tienda) NOMBRE, d.id ID_DIRECCION 
        FROM TEMPORAL t, direccion d
        WHERE   t.nombre_tienda <> '-' AND t.direccion_tienda <> '-' AND
                t.ciudad_tienda <> '-' AND t.pais_tienda <> '-' AND

                INITCAP(d.descripcion) = INITCAP(t.direccion_tienda) AND 
                d.ciudad_id = (SELECT c.id FROM ciudad c WHERE INITCAP(t.ciudad_tienda) = INITCAP(c.nombre) AND INITCAP(t.pais_tienda) = INITCAP(c.pais))
        GROUP BY (      INITCAP(t.nombre_tienda), 
                        INITCAP(t.direccion_tienda),   
                        INITCAP(t.ciudad_tienda),
                        INITCAP(t.pais_tienda),         
                        d.id
                );

        -- ================================================== PERSONAS ================================================== 
        -- -- carga de cliente(nombre, direccion, nombre_ciudad, nombre_pais)
        INSERT INTO cliente(nombre, apellido, correo, activo,fecha_creacion, tienda_id, direccion_id)
        SELECT  INITCAP(SPLIT_PART(t.nombre_cliente,' ', 1)) nombre_cliente, 
                INITCAP(SPLIT_PART(t.nombre_cliente, ' ', 2)) apellido_cliente,
                INITCAP(t.correo_cliente) correo_cliente,
                INITCAP(t.cliente_activo) = 'Si' AS cliente_activo,
                CAST (t.fecha_creacion AS TIMESTAMP) AS fecha_creacion,
                ti.id TIENDA,
                d.id direccion

        FROM TEMPORAL t, direccion d, tienda ti
        WHERE   t.nombre_cliente <> '-' AND t.correo_cliente <> '-' AND
                t.cliente_activo <> '-' AND t.tienda_preferida <> '-' AND
                t.direccion_cliente <> '-' AND
                t.ciudad_cliente <> '-' AND t.pais_cliente <> '-' AND
                t.fecha_creacion <> '-' AND t.codigo_postal_cliente <> '-' AND

                INITCAP(d.descripcion) = INITCAP(t.direccion_cliente) AND 
                d.codigo_postal = CAST (t.codigo_postal_cliente AS INTEGER) AND 
                d.ciudad_id = (SELECT c.id FROM ciudad c WHERE INITCAP(t.ciudad_cliente) = INITCAP(c.nombre) AND INITCAP(t.pais_cliente) = INITCAP(c.pais)) 
                AND 
                ti.id = (SELECT tie.id FROM tienda tie WHERE INITCAP(tie.nombre) = INITCAP(t.tienda_preferida)) 

        GROUP BY( INITCAP(SPLIT_PART(t.nombre_cliente,' ', 1)), 
                INITCAP(SPLIT_PART(t.nombre_cliente, ' ', 2)),
                INITCAP(t.correo_cliente),
                INITCAP(t.cliente_activo),      
                CAST (t.fecha_creacion AS TIMESTAMP),      
                INITCAP(t.codigo_postal_cliente),      
                INITCAP(t.tienda_preferida),
                INITCAP(t.direccion_cliente),
                INITCAP(t.codigo_postal_empleado),
                INITCAP(t.ciudad_cliente),
                INITCAP(t.pais_cliente),
                ti.id,
                d.id
                );

        -- carga de empleados 
        INSERT INTO empleado(nombre, apellido, correo, usuario, contrasenia, activo, tienda_id, direccion_id, tipo_plaza)
        SELECT  INITCAP(SPLIT_PART(t.nombre_empleado,' ', 1)) nombre_empleado, 
                INITCAP(SPLIT_PART(t.nombre_empleado, ' ', 2)) apellido_cliente,
                INITCAP(t.correo_empleado) correo_empleado,
                INITCAP(t.usuario_empleado) usuario_empleado,
                INITCAP(t.contraseniaa_empleado) contraseniaa_empleado,
                INITCAP(t.empleado_activo) = 'Si' AS empleado_activo,
                ti.id TIENDA,
                d.id direccion,
                CASE
                    WHEN    INITCAP(SPLIT_PART(t.nombre_empleado,' ', 1)) = INITCAP(SPLIT_PART(t.encargado_tienda,' ', 1)) AND
                            INITCAP(SPLIT_PART(t.nombre_empleado, ' ', 2)) = INITCAP(SPLIT_PART(t.encargado_tienda,' ', 2))
                    THEN 'Encargado'
                    ELSE 'Normal'
                END AS TIPO_EMPLEADO

        FROM TEMPORAL t, direccion d, tienda ti
        WHERE   t.nombre_empleado <> '-' AND t.correo_empleado <> '-' AND
                t.empleado_activo <> '-' AND t.tienda_empleado <> '-' AND
                t.direccion_empleado <> '-' AND
                t.ciudad_empleado <> '-' AND t.pais_empleado <> '-' AND
                t.usuario_empleado <> '-' AND t.contraseniaa_empleado <> '-' AND
                t.encargado_tienda <> '-' AND 

                INITCAP(d.descripcion) = INITCAP(t.direccion_empleado) AND 
                d.ciudad_id = (SELECT c.id FROM ciudad c WHERE INITCAP(t.ciudad_empleado) = INITCAP(c.nombre) AND INITCAP(t.pais_empleado) = INITCAP(c.pais)) 
                AND 
                ti.id = (SELECT tie.id FROM tienda tie WHERE INITCAP(tie.nombre) = INITCAP(t.tienda_empleado)) 

        GROUP BY( 
                INITCAP(SPLIT_PART(t.nombre_empleado,' ', 1)), 
                INITCAP(SPLIT_PART(t.nombre_empleado, ' ', 2)),
                INITCAP(SPLIT_PART(t.encargado_tienda,' ', 1)), 
                INITCAP(SPLIT_PART(t.encargado_tienda, ' ', 2)),
                INITCAP(t.correo_empleado),
                INITCAP(t.empleado_activo),      
                INITCAP(t.usuario_empleado),      
                INITCAP(t.contraseniaa_empleado),      
                INITCAP(t.tienda_empleado),
                INITCAP(t.direccion_empleado),
                INITCAP(t.codigo_postal_empleado),
                INITCAP(t.ciudad_empleado),
                INITCAP(t.pais_empleado),
                ti.id,
                d.id
                );

        -- -- ================================================== PELICULAS ================================================== 
        -- -- carga de actor(nombre)
        INSERT INTO actor(nombre)
        SELECT INITCAP(t.actor_pelicula) AS ACTORES FROM TEMPORAL t 
        WHERE t.actor_pelicula <> '-'
        GROUP BY INITCAP(t.actor_pelicula);

        -- -- carga de categoria(nombre)
        INSERT INTO categoria(nombre)
        SELECT INITCAP(t.categoria_pelicula) AS ACTORES FROM TEMPORAL t 
        WHERE t.categoria_pelicula <> '-'
        GROUP BY INITCAP(t.categoria_pelicula);

        -- -- carga de categoria(nombre)
        INSERT INTO clasificacion(nombre)
        SELECT INITCAP(t.clasificacion) FROM TEMPORAL t 
        WHERE t.clasificacion <> '-'
        GROUP BY(INITCAP(t.clasificacion));

        -- carga de pelicula(nombre)
        INSERT INTO pelicula(titulo, descripcion, anio_lanzamiento, dias_renta, costo_renta, duracion, costo_danio, clasificacion, idioma_original)
        SELECT  INITCAP(t.nombre_pelicula) AS TITULO, 
                INITCAP(t.descripcion_pelicula) AS DESCRIPCION, 
                CAST (t.anio_lanzamiento AS INTEGER) AS ANIO,
                CAST (t.dias_renta AS INTEGER) AS DIAS, 
                CAST (t.costo_renta AS DOUBLE PRECISION) AS COSTO_R, 
                CAST (t.duracion AS DOUBLE PRECISION) AS DURACION,
                CAST (t.costo_por_danio AS DOUBLE PRECISION) AS COSTO_D, 
                INITCAP(t.clasificacion) AS CLASIFICACION, 
                INITCAP(t.lenguaje_pelicula) AS LENGUAJE
        FROM TEMPORAL t 
        WHERE   t.nombre_pelicula <> '-' AND t.descripcion_pelicula <> '-' AND t.anio_lanzamiento <> '-' AND 
                t.dias_renta <> '-' AND t.costo_renta <> '-' AND t.duracion <> '-' AND t.costo_por_danio <> '-' AND 
                t.clasificacion <> '-' AND t.lenguaje_pelicula <> '-'
        GROUP BY (INITCAP(t.nombre_pelicula), INITCAP(t.descripcion_pelicula), t.anio_lanzamiento, t.dias_renta, 
                t.costo_renta, t.duracion, t.costo_por_danio, INITCAP(t.clasificacion), INITCAP(t.lenguaje_pelicula) );

        -- -- carga de pelicula_actor(pelicula_id,actor_id)
        INSERT INTO pelicula_actor(pelicula_id, actor_id)
        SELECT p.id, a.id
        FROM TEMPORAL t, pelicula p, actor a
        WHERE INITCAP(t.nombre_pelicula) = p.titulo AND INITCAP(t.actor_pelicula) = a.nombre
        GROUP BY(p.id, a.id);

        -- -- carga de pelicula_categoria(pelicula_id,categoria_id)
        INSERT INTO pelicula_categoria(pelicula_id, categoria_id)
        SELECT p.id, c.id
        FROM TEMPORAL t, pelicula p, categoria c
        WHERE INITCAP(t.nombre_pelicula) = p.titulo AND INITCAP(t.categoria_pelicula) = c.nombre
        GROUP BY(p.id, c.id);
        
        -- -- carga de pelicula_tienda(pelicula_id,categoria_id)
        INSERT INTO pelicula_tienda(tienda_id, pelicula_id)
        SELECT ti.id TIENDA, p.id PELICULA
        FROM TEMPORAL t, pelicula p, tienda ti
        WHERE   t.tienda_pelicula <> '-' AND t.nombre_pelicula <> '-' AND 
                t.lenguaje_pelicula <> '-' AND
                ti.id = (SELECT tie.id FROM tienda tie WHERE INITCAP(tie.nombre) = INITCAP(t.tienda_pelicula)) AND
                p.id = (SELECT pe.id FROM pelicula pe WHERE INITCAP(pe.titulo) = INITCAP(t.nombre_pelicula)) 

        GROUP BY (  
                INITCAP(t.tienda_pelicula), 
                INITCAP(t.nombre_pelicula),
                INITCAP(t.lenguaje_pelicula),
                ti.id,
                p.id
                );

        -- -- carga de renta()
        INSERT INTO renta(cliente_id, empleado_id, pelicula_id, fecha_renta, fecha_retorno, fecha_pago, monto_a_pagar)
        SELECT  c.id, 
                e.id,
                p.id, 
                CAST (t.fecha_renta AS TIMESTAMP) fecha_renta,
                CASE 
                        WHEN t.fecha_retorno = '-' THEN NULL
                        ELSE CAST (t.fecha_retorno AS TIMESTAMP)
                END  AS CP,
                CAST (t.fecha_pago AS TIMESTAMP) fecha_pago,
                CAST (t.monto_a_pagar AS DOUBLE PRECISION) MONTO

        FROM TEMPORAL t, cliente c, empleado e, pelicula p
        WHERE   t.nombre_cliente <> '-' AND t.nombre_empleado <> '-' AND 
                t.fecha_renta <> '-' AND
                t.nombre_pelicula <> '-' AND 
                t.monto_a_pagar <> '-' AND t.fecha_pago <> '-' AND 
                c.id = (SELECT cl.id FROM cliente cl 
                        WHERE   cl.nombre = INITCAP(SPLIT_PART(t.nombre_cliente,' ', 1)) AND
                                cl.apellido = INITCAP(SPLIT_PART(t.nombre_cliente,' ', 2))
                        ) AND 
                e.id = (SELECT em.id FROM empleado em 
                        WHERE   em.nombre = INITCAP(SPLIT_PART(t.nombre_empleado,' ', 1)) AND
                                em.apellido = INITCAP(SPLIT_PART(t.nombre_empleado,' ', 2))
                        ) AND 
                p.id = (SELECT pe.id FROM pelicula pe 
                        WHERE pe.titulo = INITCAP(nombre_pelicula) 
                        ) 
        GROUP BY (  
                INITCAP(t.nombre_cliente), 
                INITCAP(t.nombre_empleado),
                INITCAP(t.nombre_pelicula),
                c.id, 
                e.id,
                p.id, 
                CAST (t.fecha_renta AS TIMESTAMP),
                t.fecha_retorno,
                CAST (t.fecha_pago AS TIMESTAMP),
                CAST (t.monto_a_pagar AS DOUBLE PRECISION)
                ); 
'''