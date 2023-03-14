-- Definicion del paquete
CREATE OR REPLACE PACKAGE PaqueteCursos AS
    --Definicion del procedimiento
    PROCEDURE Descontar(n IN INTEGER);
    
    -- Definicion de la funcion
    FUNCTION NUM_ALUM(C_Curso IN CURSOS.COD_CURSO%TYPE,C_Edicion IN EDICION.COD_EDICION%TYPE) RETURN INTEGER;
END;
/

-- Definicion del cuerpo del paquete
-- Para consultar documentacion del codigo, consultar Practica 3\ejercicio1.sql & Practica 3\Ejercicio2.sql
CREATE OR REPLACE PACKAGE BODY PaqueteCursos AS
    
    -- Definicion del procedimiento
    PROCEDURE Descontar(n IN INTEGER)AS 
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
    
    -- Definicion de la funcion
    FUNCTION NUM_ALUM (C_Curso IN CURSOS.COD_CURSO%TYPE, C_Edicion IN EDICION.COD_EDICION%TYPE) RETURN INTEGER AS 
    Total INTEGER;
    BEGIN 
        select count(COD_ALUMNO) 
        INTO Total 
        FROM MATRICULA 
        WHERE COD_CURSO = C_Curso AND COD_EDICION = C_Edicion 
        GROUP BY COD_CURSO,COD_EDICION; 
        
        RETURN Total;
    END;
END;
/