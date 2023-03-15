--Autores: Francisco Javier Molina Rojas| Adriana Maña Watson

CREATE OR REPLACE FUNCTION NUM_ALUM -- Funcion llamada num_alum
(C_Curso IN CURSOS.COD_CURSO%TYPE, -- C_Curso sera de tipo COD_CURSO
C_Edicion IN EDICION.COD_EDICION%TYPE) -- C_Edicion sera de tipo COD_EDICION
RETURN INTEGER AS -- Devuelve un entero
-- Definiciones
Total INTEGER; --Definimos una variable para almacenar el total de alumnos

BEGIN -- Comienza la funcion 
    select count(COD_ALUMNO) -- Seleccionamos el numero de COD_ALUM
    INTO Total -- Lo alamcenamos en total
    FROM MATRICULA -- De la tabla MATRICULA
    WHERE COD_CURSO = C_Curso AND COD_EDICION = C_Edicion -- Donde COD_CURSO sea el proporcionado y COD_EDICION sea el proporcionado
    GROUP BY COD_CURSO,COD_EDICION; -- Lo agrupamos por COD_CURSO y COD_EDICION, con el objetivo de contar los alumnos por curso y edicion
    
    RETURN Total; -- Devolvemos el total

EXCEPTION
    WHEN NO_DATA_FOUND THEN -- Cuando no se encuentre datos 
        RETURN 0;
    WHEN OTHERS THEN  -- Si se procude una excepcion de cualquier tipo
        DBMS_OUTPUT.PUT_LINE('Error al obtener el numero de alumnos');
END;