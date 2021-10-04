-- Creado por: Jairo Ramirez.
-- Descripcion: COUNT’s de todas las tablas que utilizaron en su modelo relacional.

BEGIN;
    

    
    SELECT 'actor' Tabla,COUNT(*) Cantidad FROM actor 
    UNION
    SELECT 'categoria',COUNT(*) FROM categoria 
    UNION
    SELECT 'clasificacion',COUNT(*) FROM clasificacion 
    UNION
    SELECT 'pelicula',COUNT(*) FROM pelicula 
    UNION
    SELECT 'pelicula_actor',COUNT(*) FROM pelicula_actor 
    UNION
    SELECT 'pelicula_categoria',COUNT(*) FROM pelicula_categoria 
    UNION
    SELECT 'ciudad',COUNT(*) FROM ciudad 
    UNION
    SELECT 'direccion',COUNT(*) FROM direccion 
    UNION
    SELECT 'tienda',COUNT(*) FROM tienda 
    UNION
    SELECT 'cliente',COUNT(*) FROM cliente 
    UNION
    SELECT 'empleado',COUNT(*) FROM empleado 
    UNION
    SELECT 'pelicula_tienda',COUNT(*) FROM pelicula_tienda
    UNION
    SELECT 'renta',COUNT(*) FROM renta;
COMMIT;