-- Creado por: Jairo Ramirez.
-- Descripcion: Consultas solicitadas por la empresa que corresponden a la reportería.

BEGIN;

    -- Consulta 1
    SELECT COUNT(*) Disponibles, t.nombre Tienda
    FROM pelicula_tienda pt, tienda t
    WHERE pt.pelicula_id = (SELECT p.id FROM pelicula p WHERE p.titulo = 'Sugar Wonka') AND
    pt.tienda_id = t.id
    GROUP BY(t.nombre)
    UNION
    SELECT COUNT(*),'* Total encontradas *'
    FROM pelicula_tienda pt, tienda t
    WHERE pt.pelicula_id = (SELECT p.id FROM pelicula p WHERE p.titulo = 'Sugar Wonka') AND
    pt.tienda_id = t.id
    ;

    -- Consulta 2 
    SELECT  c.nombre Nombre, c.apellido Apellido, 
            ROUND(SUM(r.monto_a_pagar)::numeric,2) monto_total, COUNT(r.cliente_id) No_rentas
    FROM renta r, cliente c
    WHERE r.cliente_id = c.id
    GROUP  BY(
                c.nombre,
                c.apellido
            )
    HAVING COUNT(r.cliente_id) >= 40
    ORDER BY c.nombre DESC;

    -- Consulta 3
    SELECT a.nombre FROM actor a
    WHERE UPPER(SPLIT_PART(a.nombre, ' ', 2)) LIKE '%SON%'
    GROUP BY(a.nombre) ORDER BY LOWER(SPLIT_PART(a.nombre, ' ', 1)) ASC;

    -- Consulta 4
    SELECT a.nombre
    FROM pelicula_actor pa, pelicula p, actor a
    WHERE   pa.actor_id = a.id AND
            pa.pelicula_id = p.id AND LOWER(p.descripcion) LIKE '%crocodile%' AND LOWER(p.descripcion) LIKE '%shark%'
    GROUP BY(a.nombre) ORDER BY(LOWER(SPLIT_PART(a.nombre, ' ', 2)));

    -- Consulta 5
    SELECT  ci.pais, c.nombre Nombre, c.apellido Apellido, 
            (COUNT(r.cliente_id)/(SELECT  COUNT(ciu.pais)
            FROM renta re, cliente cl, direccion di, ciudad ciu
            WHERE re.cliente_id = cl.id AND cl.direccion_id = di.id AND di.ciudad_id = ciu.id 
                    AND ciu.pais = ci.pais
            GROUP  BY(
                        ciu.pais
                    )
            ORDER BY COUNT(ciu.pais)))*100 || '%' AS Porcentaje

    FROM renta r, cliente c, direccion d, ciudad ci
    WHERE r.cliente_id = c.id AND c.direccion_id = d.id AND d.ciudad_id = ci.id 
    GROUP  BY(
                c.nombre,
                c.apellido,
                ci.pais
            )
    ORDER BY COUNT(r.cliente_id) DESC LIMIT 1;
        
        -- Consulta 6
        -- SELECT  ciu.pais pais_cliente, ciu.nombre ciudad_cliente, 
        --         ROUND(
        --         COUNT(ciu.nombre)::NUMERIC/
        --         (SELECT COUNT(ci.pais)
        --         FROM cliente c, direccion d, ciudad ci
        --         WHERE c.direccion_id = d.id AND d.ciudad_id = ci.id
        --         AND ci.pais = ciu.pais
        --         GROUP  BY(ci.pais))::NUMERIC, 2)*100 || '%' Porcentaje
        -- FROM cliente cl, direccion di, ciudad ciu
        -- WHERE cl.direccion_id = di.id AND di.ciudad_id = ciu.id
        -- GROUP  BY(
        --         ciu.nombre,
        --         ciu.pais
        --         )
        -- ORDER BY ciu.pais;

        -- Consulta 7 
        -- SELECT  ciu.pais, ciu.nombre, 
        --         COUNT(ciu.nombre) Total_ciudad,

        --         (SELECT  COUNT(ci.pais)
        --         FROM renta r, cliente c, direccion d, ciudad ci
        --         WHERE r.cliente_id = c.id AND c.direccion_id = d.id AND d.ciudad_id = ci.id 
        --         AND ci.pais = ciu.pais
        --         GROUP  BY(ci.pais)
        --         ORDER BY COUNT(ci.pais)) As Total_pais,
                
        --         ROUND(
        --         (COUNT(ciu.nombre)::DOUBLE PRECISION/
        --         (SELECT  COUNT(ci.pais)
        --         FROM renta r, cliente c, direccion d, ciudad ci
        --         WHERE r.cliente_id = c.id AND c.direccion_id = d.id AND d.ciudad_id = ci.id 
        --         AND ci.pais = ciu.pais
        --         GROUP  BY(ci.pais)
        --         ORDER BY COUNT(ci.pais))::DOUBLE PRECISION * 100)::numeric,2) || '%' As Porcentaje

        -- FROM renta re, cliente cl, direccion di, ciudad ciu
        -- WHERE re.cliente_id = cl.id AND cl.direccion_id = di.id AND di.ciudad_id = ciu.id
        -- GROUP  BY(
        --         ciu.nombre,
        --         ciu.pais
        --         )
        -- ORDER BY ciu.pais;
        

        -- -- consulta 8
        -- SELECT  ciu.pais, cat.nombre,
        --         ROUND(
        --         COUNT(ciu.pais)::NUMERIC/
        --         (SELECT  COUNT(ci.pais)
        --         FROM renta r, cliente c, direccion d, ciudad ci
        --         WHERE r.cliente_id = c.id AND c.direccion_id = d.id AND d.ciudad_id = ci.id 
        --         AND ci.pais = ciu.pais
        --         GROUP  BY(ci.pais))::NUMERIC,2) * 100 || '%' porcentaje

        -- FROM renta re, cliente cl, direccion di, ciudad ciu, categoria cat, pelicula p,
        --         pelicula_categoria pc
        -- WHERE   re.cliente_id = cl.id AND cl.direccion_id = di.id AND di.ciudad_id = ciu.id
        --         AND re.pelicula_id = p.id AND pc.categoria_id = cat.id AND pc.pelicula_id = p.id
        --         AND LOWER(cat.nombre) = 'sports'
        -- GROUP  BY(
        --         ciu.pais,
        --         cat.nombre
        --         )
        -- ORDER BY ciu.pais;


        -- -- Consulta 9
        -- SELECT  ciu.pais, ciu.nombre, COUNT(ciu.nombre)
        -- FROM renta re, cliente cl, direccion di, ciudad ciu
        -- WHERE re.cliente_id = cl.id AND cl.direccion_id = di.id AND di.ciudad_id = ciu.id 
        --         AND ciu.pais = 'United States'
        -- GROUP  BY(
        --         ciu.nombre,
        --         ciu.pais
        --         )
        -- HAVING COUNT(ciu.nombre) >      
        -- (SELECT  COUNT(ciu.nombre)
        -- FROM renta re, cliente cl, direccion di, ciudad ciu
        -- WHERE re.cliente_id = cl.id AND cl.direccion_id = di.id AND di.ciudad_id = ciu.id 
        --         AND ciu.nombre = 'Dayton' AND ciu.pais = 'United States'
        -- GROUP  BY(ciu.nombre, ciu.pais))
        -- ORDER BY COUNT(ciu.nombre);

        -- Consulta 10
        SELECT  ciu.pais, ciu.nombre
        FROM renta re, cliente cl, direccion di, ciudad ciu
        WHERE   re.cliente_id = cl.id AND cl.direccion_id = di.id AND di.ciudad_id = ciu.id 
                AND 'horror' = 
                (SELECT  LOWER(cat.nombre)
                FROM renta r, cliente c, direccion d, ciudad ci, categoria cat, pelicula p,
                        pelicula_categoria pc
                WHERE   r.cliente_id = c.id AND c.direccion_id = d.id AND d.ciudad_id = ci.id
                        AND r.pelicula_id = p.id AND pc.categoria_id = cat.id AND pc.pelicula_id = p.id
                        AND ci.pais = ciu.pais AND ci.nombre = ciu.nombre
                GROUP  BY(
                        ciu.pais,
                        ciu.nombre,
                        cat.nombre
                        )
                ORDER BY COUNT(cat.nombre) DESC LIMIT 1)
        GROUP  BY(
                ciu.nombre,
                ciu.pais
                )
        ORDER BY ciu.pais ASC;

               
COMMIT;