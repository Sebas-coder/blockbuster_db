BEGIN;  
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

COMMIT;   

--     SELECT INITCAP(t.tienda_pelicula) NOMBRE, ti.id TIENDA,
--             p.id PELICULA
--     FROM TEMPORAL t, pelicula p, tienda ti
--     WHERE   t.tienda_pelicula <> '-' AND t.nombre_pelicula <> '-' AND 
--             t.lenguaje_pelicula <> '-' AND
--             ti.id = (SELECT tie.id FROM tienda tie WHERE INITCAP(tie.nombre) = INITCAP(t.tienda_pelicula)) AND
--             p.id = (SELECT pe.id FROM pelicula pe WHERE INITCAP(pe.titulo) = INITCAP(t.nombre_pelicula)) 

--     GROUP BY (  
--             INITCAP(t.tienda_pelicula), 
--             INITCAP(t.nombre_pelicula),
--             INITCAP(t.lenguaje_pelicula),
--             ti.id,
--             p.id
--             );





        
        -- SELECT  INITCAP(SPLIT_PART(t.nombre_cliente,' ', 1)) nombre_cliente, 
        --         INITCAP(SPLIT_PART(t.nombre_cliente, ' ', 2)) apellido_cliente,
        --         INITCAP(t.correo_cliente) correo_cliente,
        --         INITCAP(t.cliente_activo) = 'Si' AS cliente_activo,
        --         CAST (t.fecha_creacion AS TIMESTAMP) AS fecha_creacion,
        --         ti.id TIENDA,
        --         d.id direccion

        -- FROM TEMPORAL t, direccion d, tienda ti
        -- WHERE   t.nombre_cliente <> '-' AND t.correo_cliente <> '-' AND
        --         t.cliente_activo <> '-' AND t.tienda_preferida <> '-' AND
        --         t.direccion_cliente <> '-' AND
        --         t.ciudad_cliente <> '-' AND t.pais_cliente <> '-' AND
        --         t.fecha_creacion <> '-' AND t.codigo_postal_cliente <> '-' AND

        --         INITCAP(d.descripcion) = INITCAP(t.direccion_cliente) AND 
        --         d.codigo_postal = CAST (t.codigo_postal_cliente AS INTEGER) AND 
        --         d.ciudad_id = (SELECT c.id FROM ciudad c WHERE INITCAP(t.ciudad_cliente) = INITCAP(c.nombre) AND INITCAP(t.pais_cliente) = INITCAP(c.pais)) 
        --         AND 
        --         ti.id = (SELECT tie.id FROM tienda tie WHERE INITCAP(tie.nombre) = INITCAP(t.tienda_preferida)) 

        -- GROUP BY( INITCAP(SPLIT_PART(t.nombre_cliente,' ', 1)), 
        --         INITCAP(SPLIT_PART(t.nombre_cliente, ' ', 2)),
        --         INITCAP(t.correo_cliente),
        --         INITCAP(t.cliente_activo),      
        --         CAST (t.fecha_creacion AS TIMESTAMP),      
        --         INITCAP(t.codigo_postal_cliente),      
        --         INITCAP(t.tienda_preferida),
        --         INITCAP(t.direccion_cliente),
        --         INITCAP(t.codigo_postal_empleado),
        --         INITCAP(t.ciudad_cliente),
        --         INITCAP(t.pais_cliente),
        --         ti.id,
        --         d.id
        --         );



        -- SELECT  INITCAP(SPLIT_PART(t.nombre_empleado,' ', 1)) nombre_empleado, 
        --         INITCAP(SPLIT_PART(t.nombre_empleado, ' ', 2)) apellido_cliente,
        --         INITCAP(t.correo_empleado) correo_empleado,
        --         INITCAP(t.usuario_empleado) usuario_empleado,
        --         INITCAP(t.contraseniaa_empleado) contraseniaa_empleado,
        --         INITCAP(t.empleado_activo) = 'Si' AS empleado_activo,
        --         ti.id TIENDA,
        --         d.id direccion,
        --         CASE
        --             WHEN    INITCAP(SPLIT_PART(t.nombre_empleado,' ', 1)) = INITCAP(SPLIT_PART(t.encargado_tienda,' ', 1)) AND
        --                     INITCAP(SPLIT_PART(t.nombre_empleado, ' ', 2)) = INITCAP(SPLIT_PART(t.encargado_tienda,' ', 2))
        --             THEN 'Encargado'
        --             ELSE 'Normal'
        --         END AS TIPO_EMPLEADO

        -- FROM TEMPORAL t, direccion d, tienda ti
        -- WHERE   t.nombre_empleado <> '-' AND t.correo_empleado <> '-' AND
        --         t.empleado_activo <> '-' AND t.tienda_empleado <> '-' AND
        --         t.direccion_empleado <> '-' AND
        --         t.ciudad_empleado <> '-' AND t.pais_empleado <> '-' AND
        --         t.usuario_empleado <> '-' AND t.contraseniaa_empleado <> '-' AND
        --         t.encargado_tienda <> '-' AND 

        --         INITCAP(d.descripcion) = INITCAP(t.direccion_empleado) AND 
        --         d.ciudad_id = (SELECT c.id FROM ciudad c WHERE INITCAP(t.ciudad_empleado) = INITCAP(c.nombre) AND INITCAP(t.pais_empleado) = INITCAP(c.pais)) 
        --         AND 
        --         ti.id = (SELECT tie.id FROM tienda tie WHERE INITCAP(tie.nombre) = INITCAP(t.tienda_empleado)) 

        -- GROUP BY( 
        --         INITCAP(SPLIT_PART(t.nombre_empleado,' ', 1)), 
        --         INITCAP(SPLIT_PART(t.nombre_empleado, ' ', 2)),
        --         INITCAP(SPLIT_PART(t.encargado_tienda,' ', 1)), 
        --         INITCAP(SPLIT_PART(t.encargado_tienda, ' ', 2)),
        --         INITCAP(t.correo_empleado),
        --         INITCAP(t.empleado_activo),      
        --         INITCAP(t.usuario_empleado),      
        --         INITCAP(t.contraseniaa_empleado),      
        --         INITCAP(t.tienda_empleado),
        --         INITCAP(t.direccion_empleado),
        --         INITCAP(t.codigo_postal_empleado),
        --         INITCAP(t.ciudad_empleado),
        --         INITCAP(t.pais_empleado),
        --         ti.id,
        --         d.id
        --         );




-- QUERY DE BUSQUEDA DE MAYOR CATEGORIA POR CIUDAD Y PAIS 
        -- SELECT  ciu.pais, ciu.nombre, cat.nombre, COUNT(cat.nombre)
        -- FROM renta re, cliente cl, direccion di, ciudad ciu, categoria cat, pelicula p,
        --         pelicula_categoria pc
        -- WHERE   re.cliente_id = cl.id AND cl.direccion_id = di.id AND di.ciudad_id = ciu.id
        --         AND re.pelicula_id = p.id AND pc.categoria_id = cat.id AND pc.pelicula_id = p.id
        --         AND ciu.pais = 'Afghanistan' AND ciu.nombre = 'Kabul'
        -- GROUP  BY(
        --         ciu.pais,
        --         ciu.nombre,
        --         cat.nombre
        --         )
        -- ORDER BY COUNT(cat.nombre) DESC LIMIT 1;

        -- cantidad de ciudades de Dayton
        -- SELECT  ciu.pais, ciu.nombre, COUNT(ciu.nombre)
        -- FROM renta re, cliente cl, direccion di, ciudad ciu
        -- WHERE re.cliente_id = cl.id AND cl.direccion_id = di.id AND di.ciudad_id = ciu.id 
        --         AND ciu.nombre = 'Dayton' AND ciu.pais = 'United States'
        -- GROUP  BY(
        --         ciu.nombre,
        --         ciu.pais
        --         )
        -- ORDER BY COUNT(ciu.nombre);



        --     SELECT  COUNT(ciu.pais), ciu.pais
--             FROM renta re, cliente cl, direccion di, ciudad ciu
--             WHERE re.cliente_id = cl.id AND cl.direccion_id = di.id AND di.ciudad_id = ciu.id 
--             GROUP  BY(
--                         ciu.pais
--                     )
--             ORDER BY COUNT(ciu.pais);


--     CONSULTA DE RENTAS POR PAIS - PAIS * 
--     SELECT  COUNT(ci.pais), ci.pais
--     FROM renta re, cliente cl, direccion di, ciudad ciu
--     WHERE re.cliente_id = cl.id AND cl.direccion_id = di.id AND di.ciudad_id = ciu.id 
--     GROUP  BY(
--                 ciu.pais
--             )
--     ORDER BY COUNT(ciu.pais);

        -- consuta de pais ciudad *
        -- SELECT  ciu.pais, ciu.nombre, COUNT(ciu.nombre)
        -- FROM renta re, cliente cl, direccion di, ciudad ciu
        -- WHERE re.cliente_id = cl.id AND cl.direccion_id = di.id AND di.ciudad_id = ciu.id 
        -- GROUP  BY(
        --         ciu.nombre,
        --         ciu.pais
        --         )
        -- ORDER BY COUNT(ciu.nombre);



-- por pais - clientes 
        -- SELECT  ci.pais pais_cliente, COUNT(ci.nombre)
        -- FROM cliente c, direccion d, ciudad ci
        -- WHERE c.direccion_id = d.id AND d.ciudad_id = ci.id
        -- GROUP  BY(
        --         ci.pais
        --         )
        -- ORDER BY ci.pais;




        -- (SELECT  COUNT(ci.pais), ci.pais
        --         FROM renta r, cliente c, direccion d, ciudad ci
        --         WHERE r.cliente_id = c.id AND c.direccion_id = d.id AND d.ciudad_id = ci.id 
        --         -- AND ci.pais = ciu.pais
        --         GROUP  BY(ci.pais)
        --         ORDER BY COUNT(ci.pais)) Porcentaje_x_pais



        -- SELECT  COUNT(ci.pais), ci.pais
        --         FROM renta r, cliente c, direccion d, ciudad ci
        --         WHERE r.cliente_id = c.id AND c.direccion_id = d.id AND d.ciudad_id = ci.id 
        --         AND ci.pais = ciu.pais
        --         GROUP  BY(ci.pais)
        --         ORDER BY COUNT(ci.pais) ;
                -- * 100 AS Porcentaje_Ciudad 

