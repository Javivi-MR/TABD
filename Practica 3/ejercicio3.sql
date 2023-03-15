CREATE OR REPLACE PACKAGE PaqueteCursos AS
    --Definicion del procedimiento
    PROCEDURE Descontar(n IN INTEGER);
    
    -- Definicion de la funcion
    FUNCTION NUM_ALUM(C_Curso IN CURSOS.COD_CURSO%TYPE,C_Edicion IN EDICION.COD_EDICION%TYPE) RETURN INTEGER;
END;
/

-- Para mas informacion acerca del procedimiento y la funcion consulte Ejercicio1.sql & Ejercicio2.sql
CREATE OR REPLACE PACKAGE BODY PaqueteCursos AS
    
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
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error al actualizar la tabla Matricula');
    END;
    
    FUNCTION NUM_ALUM (C_Curso IN CURSOS.COD_CURSO%TYPE, C_Edicion IN EDICION.COD_EDICION%TYPE) RETURN INTEGER AS 
    Total INTEGER;
    BEGIN
        select count(COD_ALUMNO)
        INTO Total 
        FROM MATRICULA 
        WHERE COD_CURSO = C_Curso AND COD_EDICION = C_Edicion 
        GROUP BY COD_CURSO,COD_EDICION; 
        
        RETURN Total;

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN 0;
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error al obtener el numero de alumnos');
    END;
END;
/