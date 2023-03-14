DECLARE    
    n1 INTEGER; -- Definimos una variable para almacenar el numero de estudiantes 
    c1 NUMBER(5); -- Definimos una variable para almacenar el codigo del curso
    e NUMBER(3); -- Definimos una variable para almacenar el codigo de la edicion
    n2 INTEGER := 4; -- Definimos una variable para almacenar el numero de estudiantes
BEGIN
    c1 := &curso; -- Asignamos el valor de la variable curso a la variable c1
    e := &edicion; -- Asignamos el valor de la variable edicion a la variable e
    
    PaqueteCursos.Descontar(n2); -- Llamamos al procedimiento descontar del paquete PaqueteCursos
    
    n1 := PaqueteCursos.NUM_ALUM(c1); -- Llamamos a la funcion NUM_ALUM del paquete PaqueteCursos
    
    DBMS_OUTPUT.PUT_LINE('Curso: ' || c1 || 'EDICION: '); -- Mostramos el curso y la edicion
    DBMS_OUTPUT.PUT_LINE('Numero de alumnos: ' || n1); -- Mostramos el numero de alumnos
END;