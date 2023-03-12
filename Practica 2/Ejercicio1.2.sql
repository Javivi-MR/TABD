--Autores: Francisco Javier Molina Rojas| Adriana Maña Watson

SET SERVEROUTPUT ON; -- Habilitamos el output


-- <------ Definicion de las Tablas ------> --
/*
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
    ACCEPT NuevoValor NUMBER(11,2), --Nuevo Valor será el valor a tomar
    ACCEPT Estado VARCHAR(45), --Estado será el estado de la cuenta
    ACCEPT FechaMod DATE  --FechaMod será la fecha de cuando se realizo la operación
);
*/

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
    /*  Pensandolo, podemos darnos cuenta que el hecho de no poder actualizar una cuenta significaria que debemos insertarla.
        Sabiendo esto podemos reducir el codigo suponiendo que, cuando no se puede actualizar una cuenta, 
        esta no existe por lo que la insertariamos (realizando la operacion insertar). Y cuando se actualiza,
        esta cuenta, si existe, por lo que se realizaria la operacion de actualizar. No necesitamos separarlas y repetirlas en cada caso.
        
        Reduciendo asi el codigo y simplificando el script.
    */
    -- <-- Bloque para la operacion Insertar/Actualizar Cuenta --> --
    
    IF Operacion = 'i' OR Operacion = 'I'  OR Operacion = 'a' OR Operacion = 'A' THEN -- Si la operacion elegida es i o I (Insertar)  
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
        
    -- <-- FIN bloque para la operacion Insertar/Actualizar Cuenta --> --    
        
    ELSIF Operacion = 'b' OR Operacion = 'B' THEN -- Si la operacion elegida es b o B (Borrar)
        DELETE FROM CUENTAS -- Borramos de la tabla CUENTAS
        WHERE IDCuenta = IDC; -- La cuenta que tenga el ID proporcionado
        
        /* Notese que si la cuenta no existiese, la cantidad de ROWS (filas) afectadas seria 0... */
        
        IF SQL%ROWCOUNT = 0 THEN -- Si la cantidad de ROWS (filas) afectadas es 0
            RAISE BorrarCuentaNoExiste;   -- Levantamos la excepcion de BorrarCuentaNoExiste
        END IF;
        
        /* Si la excepcion se levantase, no continuariamos mas allá de esta linea */
    
        INSERT INTO ACCIONES VALUES(IDC,Operacion,NULL,'Se Borro la cuenta con exito',SYSDATE); -- Guardamos la operacion realizada en la tabla ACCIONES
        
    -- <-- FIN bloque para la operacion Borrar Cuenta --> --
    
    -- <-- En el caso que la operacion no fuese alguna de las anteriores --> --
    
    ELSE  
        raise OperacionDesconocida; -- Levantamos la excepcion de OperacionDesconocidad
    END IF;

-- <-- FIN del cuerpo del script --> --

-- <-- Comienzo de tratamiento de excepciones --> --
EXCEPTION
    -- <-- Caso excepcion CuentaNoExiste (actualizar una tupla con id de cuenta que no existe) --> --
    WHEN CuentaNoExiste THEN
        /*Si estamos aqui es porque la cuenta NO existe, se podra insertar siempre, no hay que tener encuenta otras excepciones */
        INSERT INTO CUENTAS VALUES(IDC,ValorNuevo); --Insertamos cuenta en tabla CUENTAS
        INSERT INTO ACCIONES VALUES(IDC,'i',ValorNuevo,'Se inserto la cuenta con exito',SYSDATE); -- Guardamos la operacion realizada en la tabla ACCIONES
    -- <-- FIN caso excepcion CuentaNoExiste (actualizar una tupla con id de cuenta que no existe) --> --
    
    -- <-- Caso excepcion BorrarCuentaNoExiste (Borrar una tupla con id de cuenta que no existe) --> --
    WHEN BorrarCuentaNoExiste THEN 
        /* En este caso no es necesario hacer nada */
        DBMS_OUTPUT.PUT_LINE('Error al borrar, la cuenta no existe'); -- Mostramos mensaje de error
    -- <-- FIN caso excepcion BorrarCuentaNoExiste (Borrar una tupla con id de cuenta que no existe) --> --
        
    -- <-- Caso excepcion OperacionDesconocidad (Operacion desconocida) --> --
    WHEN OperacionDesconocida THEN
        /* En este caso no es necesario hacer nada */
        DBMS_OUTPUT.PUT_LINE('Error, la operacion solicitada no existe. Ningun cambio será realizado'); -- Mostramos mensaje de error
    -- <-- FIN caso excepcion OperacionDesconocidad (Operacion desconocida) --> --
    
-- <-- FIN comienzo de tratamiento de excepciones --> --

-- <-- FIN del script --> --
END;
/