-- Insercion de Datos
DECLARE
   n INTEGER;
   c1 NUMBER(5) := 1;
   c2 NUMBER(3) := 1;
   
   
BEGIN
   n := NUM_ALUM(c1,c2);
   
    select count(COD_ALUMNO)
    INTO Total
    FROM MATRICULA
    WHERE COD_CURSO = C_Curso AND COD_EDICION = C_Edicion
    GROUP BY COD_CURSO,COD_EDICION;
   
   DBMS_OUTPUT.PUT_LINE(n);
END;
