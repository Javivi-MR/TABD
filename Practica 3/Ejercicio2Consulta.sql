--Autores: Francisco Javier Molina Rojas| Adriana Maña Watson

DECLARE
    n INTEGER; -- Definimos una variable para almacenar el numero de estudiantes 
    c1 NUMBER(5); -- Definimos una variable para almacenar el codigo del curso
   
    CURSOR ConsultaCurso IS SELECT * FROM CURSOS WHERE COD_CURSO = c1; -- Definimos un cursor que almacene la row de la tabla CURSOS correspondiente a dicho curso
    CursoData CURSOS%ROWTYPE; -- Definimos una variable para almacenar dicha row
    CURSOR ConsultaEdicion IS SELECT * FROM EDICION WHERE COD_CURSO = c1; -- Definimos un cursor que almacene las rows de la tabla EDICION correspondiente a dicho curso
    EdicionData EDICION%ROWTYPE; -- Definimos una variable para almacenar dichas rows (1 a 1)    
   
BEGIN
    c1 := &codigoCurso; -- Introducimos el codigo curso por entrada
    
    OPEN ConsultaCurso; -- Abrimos el cursor
    FETCH ConsultaCurso INTO CursoData; -- Capturamos los datos (row) y los metemos en CursoData 
    IF ConsultaCurso%NOTFOUND THEN -- Si no hay datos, lanzamos la excepcion NO_DATA_FOUND
        RAISE NO_DATA_FOUND;
    END IF;
    -- Mostramos datos del curso 
    DBMS_OUTPUT.PUT_LINE('<--------- Datos del Curso --------->');
    DBMS_OUTPUT.PUT_LINE('Nombre del curso: ' || CursoData.NOMBRE);
    DBMS_OUTPUT.PUT_LINE('Descripcion del curso: ' || CursoData.DESCRIPCION);
    DBMS_OUTPUT.PUT_LINE('Precio del curso: ' || CursoData.PRECIO || '€');
    
    CLOSE ConsultaCurso; -- Como ya no vamos a usar el cursor de curso, lo cerramos
    
    OPEN ConsultaEdicion; -- Abrimos el cursor de edicion
    LOOP --BUCLE
        FETCH ConsultaEdicion INTO EdicionData; -- Capturamos los datos del cursor
        EXIT WHEN ConsultaEdicion%NOTFOUND; -- Si no quedan datos terminamos el bucle
        -- Mostramos los datos de la edicion
        DBMS_OUTPUT.PUT_LINE('----- Datos de la Edicion ' || EdicionData.COD_EDICION || ' -----');
        DBMS_OUTPUT.PUT_LINE('Fecha de inicio de la Edicion: ' || EdicionData.FECHA_INICIO);
        DBMS_OUTPUT.PUT_LINE('Fecha de fin de la Edicion: ' || EdicionData.FECHA_FIN);
        DBMS_OUTPUT.PUT_LINE('Lugar de la Edicion: ' || EdicionData.LUGAR);
        
        n := NUM_ALUM(c1,EdicionData.COD_EDICION); -- Almacenamos en n el numero de alumnos
        DBMS_OUTPUT.PUT_LINE('Numero de estudiantes de la Edicion: ' || n);
    END LOOP;
    CLOSE ConsultaEdicion; -- Como ya no vamos a usar el cursor de edicion, lo cerramos
   
EXCEPTION
    WHEN VALUE_ERROR THEN  -- Excepcion para cuando el valor asignado al codigo del curso sea incorrecto
        DBMS_OUTPUT.PUT_LINE('Error de asignacion, por favor introduce un numero ');   
        
    WHEN NO_DATA_FOUND THEN --Excepcion para cuando el curso seleccionado no existe
        DBMS_OUTPUT.PUT_LINE('Error, el curso seleccionado no existe');   
END;