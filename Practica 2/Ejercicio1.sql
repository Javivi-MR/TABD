--Autores: Adriana Maña Watson | Francisco Javier Molina Rojas

-- <------ Definicion de las Tablas ------> --

SET SERVEROUTPUT ON;


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
    IDC NUMBER(4) := &id;
    Operacion CHAR(1) := '&op';
    ValorNuevo NUMBER(11,2) := &vn;
    Comentario VARCHAR(45) := '&c';
    
-- <- Fin Variables -> -- 
    
-- <- Excepciones -> --
    CuentaNoExiste EXCEPTION;
    BorrarCuentaNoExiste EXCEPTION;
-- <- Fin Excepciones -> --
    
BEGIN
    IF Operacion = 'i' OR Operacion = 'I' THEN
        INSERT INTO CUENTAS VALUES(IDC,ValorNuevo);
        INSERT INTO ACCIONES VALUES(IDC,Operacion,ValorNuevo,'Se inserto la cuenta con exito',SYSDATE);
        
    ELSIF Operacion = 'a' OR Operacion = 'A' THEN
        UPDATE CUENTAS
        SET Valor = ValorNuevo
        WHERE IDCuenta = IDC;
        
        IF SQL%ROWCOUNT = 0 THEN
            RAISE CuentaNoExiste;
        END IF;
        
        INSERT INTO ACCIONES VALUES(IDC,Operacion,ValorNuevo,'Se actualizo la cuenta con exito',SYSDATE);
        
    ELSIF Operacion = 'b' OR Operacion = 'B' THEN
        DELETE FROM CUENTAS
        WHERE IDCuenta = IDC;
        
        IF SQL%ROWCOUNT = 0 THEN
            RAISE BorrarCuentaNoExiste;
        END IF;
    
        INSERT INTO ACCIONES VALUES(IDC,Operacion,ValorNuevo,'Se Borro la cuenta con exito',SYSDATE);
    
    END IF;

EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('Error al insertar, ya existe la cuenta. Procedemos a actualizarla');
        
        UPDATE CUENTAS
        SET Valor = ValorNuevo
        WHERE IDCuenta = IDC;
        
        INSERT INTO ACCIONES VALUES(IDC,Operacion,ValorNuevo,'Se actualizo la cuenta con exito',SYSDATE);
        
        
    WHEN BorrarCuentaNoExiste THEN 
        DBMS_OUTPUT.PUT_LINE('Error al borrar, la cuenta no existe');
        
    WHEN CuentaNoExiste THEN

        DBMS_OUTPUT.PUT_LINE('Error al actualizar, la cuenta no existe. Procedemos a insertarla');
        INSERT INTO CUENTAS VALUES
        (
            IDC,
            ValorNuevo
        );
        INSERT INTO ACCIONES VALUES
        (
            IDC,
            Operacion,
            ValorNuevo,
            'Se inserto la cuenta con exito',
            SYSDATE
        );
END;
/