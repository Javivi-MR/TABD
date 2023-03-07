--Autores: Francisco Javier Molina Rojas| Adriana Maña Watson

SET SERVEROUTPUT ON; -- Habilitamos el output

-- <------ Definicion de las Tablas ------> --
CREATE TABLE CUENTAS  --Creamos tabla CUENTAS
(
    IDCuenta NUMBER(4), --IDCuenta es un numero de 4 cifras como mucho
    Valor NUMBER(11,2), --Valor es un numero de 11 cifras y dos decimales como mucho
    PRIMARY KEY(IDCuenta) -- Clave primaria IDCuenta
);

CREATE TABLE ACCIONES
(
    IdCuenta NUMBER(4), --IDCuenta es un numero de 4 cifras como mucho
    TipoOp CHAR(1), --TipoOp sera la operación a realizar
    NuevoValor NUMBER(11,2), --Nuevo Valor será el valor a tomar
    Estado VARCHAR(45), --Estado será el estado de la cuenta
    FechaMod DATE  --FechaMod será la fecha de cuando se realizo la operación
);


-- <------ FIN definicion de las Tablas ------> --

-- <------ Definicion del Script ------> --

DECLARE
-- <- Variables -> --
    IDC NUMBER(4) := &id;   -- Introducimos id 
    Operacion CHAR(1) := '&op';  -- Introducimos tipo de operacion (sin necesidad de poner '')
    ValorNuevo NUMBER(11,2) := &vn; -- Introducimos el valor nuevo de la cuenta
    Comentario VARCHAR(45) := '&c'; -- Introducimos el comentario pertinente
    
-- <- Fin Variables -> -- 
    
-- <- Excepciones -> --
    /* Necesitamos definir 3 excepciones:
        Para controlar la inserción de cuentas ya existentes, poseemos ya le excepción DUP_VAL_ON_INDEX que se salta cuando se intenta insertar una cuenta con ID ya existente
        Para controlar la actualización de cuentas que NO existen, definimos la excepción CuentaNoExiste
        Para controlar la eliminación de cuentas que NO existen, definimos la excepción BorrarCuentaNoExiste
        Para controlar realizar otro tipo de operaciones, definimos la excepción OperacionDesconocida
    */
    CuentaNoExiste EXCEPTION;  
    BorrarCuentaNoExiste EXCEPTION;
    OperacionDesconocida EXCEPTION;
-- <- Fin Excepciones -> --
    
-- <-- Comienzo del cuerpo del script --> --
BEGIN 

    -- <-- Bloque para la operacion Insertar Cuenta --> --
    
    IF Operacion = 'i' OR Operacion = 'I' THEN -- Si la operacion elegida es i o I (Insertar)
    
        INSERT INTO CUENTAS VALUES(IDC,ValorNuevo); -- Insertamos a la tabla cuentas la nueva cuenta
        /* Notese que si intentasemos insertar una cuenta ya existente, la excepción DUP_VAL_ON_INDEX
           seria levantada y no continuaremos mas allá de esta linea*/
        INSERT INTO ACCIONES VALUES(IDC,Operacion,ValorNuevo,'Se inserto la cuenta con exito',SYSDATE); -- Guardamos la operacion realizada en la tabla ACCIONES
        
    -- <-- FIN bloque para la operacion Insertar Cuenta --> --    
   
    -- <-- Bloque para la operacion Actualizar Cuenta --> --
   
    ELSIF Operacion = 'a' OR Operacion = 'A' THEN -- Si la operacion elegida es a o A (Actualizar)
        -- Intentamos actualizar el valor obtenido en la cuenta seleccionada
        UPDATE CUENTAS
        SET Valor = ValorNuevo
        WHERE IDCuenta = IDC;
        
        /* Notese que si la cuenta no existiese, la cantidad de ROWS (filas) afectadas seria 0... */
        
        IF SQL%ROWCOUNT = 0 THEN -- Si la cantidad de ROWS (filas) afectadas es 0
            RAISE CuentaNoExiste; -- Levantamos la excepcion de CuentaNoExiste
        END IF;
        
        /* Si la excepcion se levantase, no continuariamos mas allá de esta linea */
        
        INSERT INTO ACCIONES VALUES(IDC,Operacion,ValorNuevo,'Se actualizo la cuenta con exito',SYSDATE); -- Guardamos la operacion realizada en la tabla ACCIONES
        
    -- <-- FIN bloque para la operacion Actualizar Cuenta --> --
    
    -- <-- Bloque para la operacion Borrar Cuenta --> --
        
    ELSIF Operacion = 'b' OR Operacion = 'B' THEN -- Si la operacion elegida es b o B (Insertar)
        DELETE FROM CUENTAS -- Borramos de la tabla CUENTAS
        WHERE IDCuenta = IDC; -- La cuenta que tenga el ID proporcionado
        
        /* Notese que si la cuenta no existiese, la cantidad de ROWS (filas) afectadas seria 0... */
        
        IF SQL%ROWCOUNT = 0 THEN -- Si la cantidad de ROWS (filas) afectadas es 0
            RAISE BorrarCuentaNoExiste;   -- Levantamos la excepcion de BorrarCuentaNoExiste
        END IF;
        
        /* Si la excepcion se levantase, no continuariamos mas allá de esta linea */
    
        INSERT INTO ACCIONES VALUES(IDC,Operacion,ValorNuevo,'Se Borro la cuenta con exito',SYSDATE); -- Guardamos la operacion realizada en la tabla ACCIONES
        
    -- <-- FIN bloque para la operacion Borrar Cuenta --> --
    
    -- <-- En el caso que la operacion no fuese alguna de las anteriores --> --
    
    ELSE  
        raise OperacionDesconocidad; -- Levantamos la excepcion de OperacionDesconocidad
    END IF;

-- <-- FIN del cuerpo del script --> --

-- <-- Comienzo de tratamiento de excepciones --> --
EXCEPTION

    -- <-- Caso excepcion DUP_VAL_ON_INDEX (insertar una tupla con id de cuenta repetido) --> --
    WHEN DUP_VAL_ON_INDEX THEN
        /*Si estamos aqui es porque la cuenta existe, se podra actualizar siempre, no hay que tener encuenta otras excepciones */
        DBMS_OUTPUT.PUT_LINE('Error al insertar, ya existe la cuenta. Procedemos a actualizarla'); -- Mostramos mensaje de error y procedemos a actualizar la cuenta
        -- actualizamos el valor obtenido en la cuenta seleccionada
        UPDATE CUENTAS  
        SET Valor = ValorNuevo
        WHERE IDCuenta = IDC;
        
        INSERT INTO ACCIONES VALUES(IDC,Operacion,ValorNuevo,'Se actualizo la cuenta con exito',SYSDATE); -- Guardamos la operacion realizada en la tabla ACCIONES
    -- <-- FIN caso excepcion DUP_VAL_ON_INDEX (insertar una tupla con id de cuenta repetido) --> --
        
    -- <-- Caso excepcion CuentaNoExiste (actualizar una tupla con id de cuenta que no existe) --> --
    WHEN CuentaNoExiste THEN
        /*Si estamos aqui es porque la cuenta NO existe, se podra insertar siempre, no hay que tener encuenta otras excepciones */
        DBMS_OUTPUT.PUT_LINE('Error al actualizar, la cuenta no existe. Procedemos a insertarla'); -- Mostramos mensaje de error y procedemos a insertar la cuenta
        INSERT INTO CUENTAS VALUES(IDC,ValorNuevo); --Insertamos cuenta en tabla CUENTAS
        INSERT INTO ACCIONES VALUES(IDC,Operacion,ValorNuevo,'Se inserto la cuenta con exito',SYSDATE); -- Guardamos la operacion realizada en la tabla ACCIONES
    -- <-- FIN caso excepcion CuentaNoExiste (actualizar una tupla con id de cuenta que no existe) --> --
    
    -- <-- Caso excepcion BorrarCuentaNoExiste (Borrar una tupla con id de cuenta que no existe) --> --
    WHEN BorrarCuentaNoExiste THEN 
        /* En este caso no es necesario hacer nada */
        DBMS_OUTPUT.PUT_LINE('Error al borrar, la cuenta no existe'); -- Mostramos mensaje de error
    -- <-- FIN caso excepcion BorrarCuentaNoExiste (Borrar una tupla con id de cuenta que no existe) --> --
        
    -- <-- Caso excepcion OperacionDesconocidad (Operacion desconocida) --> --
    WHEN OperacionDesconocidad THEN
        /* En este caso no es necesario hacer nada */
        DBMS_OUTPUT.PUT_LINE('Error, la operacion solicitada no existe. Ningun cambio será realizado'); -- Mostramos mensaje de error
    -- <-- FIN caso excepcion OperacionDesconocidad (Operacion desconocida) --> --
    
-- <-- FIN comienzo de tratamiento de excepciones --> --

-- <-- FIN del script --> --
END;
/