DECLARE    
    n1 INTEGER; -- Definimos una variable para almacenar el numero de estudiantes 
    c1 NUMBER(5); -- Definimos una variable para almacenar el codigo del curso
    e NUMBER(3); -- Definimos una variable para almacenar el codigo de la edicion
    n2 INTEGER := 4; -- Definimos una variable para almacenar el numero de estudiantes
BEGIN
    c1 := &curso; -- Asignamos el valor de la variable curso a la variable c1
    e := &edicion; -- Asignamos el valor de la variable edicion a la variable e
    
    PaqueteCursos.Descontar(n2); -- Llamamos al procedimiento descontar del paquete PaqueteCursos
    
    n1 := PaqueteCursos.NUM_ALUM(c1,e); -- Llamamos a la funcion NUM_ALUM del paquete PaqueteCursos
    
    DBMS_OUTPUT.PUT_LINE('Curso: ' || c1 || ' EDICION: ' || e); -- Mostramos el curso y la edicion
    DBMS_OUTPUT.PUT_LINE('Numero de alumnos: ' || n1); -- Mostramos el numero de alumnos
    
EXCEPTION
    WHEN VALUE_ERROR THEN  -- Excepcion para cuando el valor asignado al codigo del curso o codigo edicion sea incorrecto
        DBMS_OUTPUT.PUT_LINE('Error de asignacion, por favor introduce un numero ');   
    WHEN OTHERS THEN -- Excepcion de cualquier tipo
        DBMS_OUTPUT.PUT_LINE('Error no identificado');
END;