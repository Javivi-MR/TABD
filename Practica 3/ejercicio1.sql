--Autores: Francisco Javier Molina Rojas| Adriana Maña Watson

CREATE OR REPLACE PROCEDURE Descontar
(n IN INTEGER)AS    
BEGIN
    
    UPDATE CURSOS
    SET PRECIO = PRECIO - PRECIO*(DESCUENTO/100)
    WHERE COD_CURSO NOT IN
         (
            SELECT COD_CURSO
            FROM MATRICULA
            HAVING COUNT(COD_ALUMNO) < n
            GROUP BY COD_CURSO,COD_EDICION
         );
END;