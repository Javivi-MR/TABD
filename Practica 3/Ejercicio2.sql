--Autores: Francisco Javier Molina Rojas| Adriana Maña Watson

CREATE OR REPLACE FUNCTION NUM_ALUM 
(C_Curso IN CURSOS.COD_CURSO%TYPE,
C_Edicion IN EDICION.COD_EDICION%TYPE)
RETURN INTEGER AS

Total INTEGER;

BEGIN
    
    select count(COD_ALUMNO)
    INTO Total
    FROM MATRICULA
    WHERE COD_CURSO = C_Curso AND COD_EDICION = C_Edicion
    GROUP BY COD_CURSO,COD_EDICION;
    
    RETURN Total;
END;