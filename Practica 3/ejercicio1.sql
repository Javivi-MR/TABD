--Autores: Francisco Javier Molina Rojas| Adriana Maña Watson

CREATE OR REPLACE PROCEDURE Descontar -- Procedimiento Descontar
(n IN INTEGER)AS -- Recibe un entero
BEGIN
    UPDATE CURSOS -- Actualiza la tabla CURSOS
    SET PRECIO = PRECIO - PRECIO*(DESCUENTO/100) -- El precio sera el precio menos el precio por el descuento entre 100
    WHERE COD_CURSO NOT IN -- Donde el codigo del curso no este en el conjunto de codigos de curso que cumplan la siguiente condicion
         (
            SELECT COD_CURSO  -- Seleccionamos el codigo del curso
            FROM MATRICULA -- De la tabla MATRICULA
            HAVING COUNT(COD_ALUMNO) < n -- Donde el numero de alumnos sea menor que el entero proporcionado
            GROUP BY COD_CURSO,COD_EDICION -- Agrupamos por codigo de curso y codigo de edicion
         );
END;