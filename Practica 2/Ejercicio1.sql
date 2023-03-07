--Autores: Adriana Maña Watson | Francisco Javier Molina Rojas

-- <------ Definicion de las Tablas ------> --

SET SERVEROUTPUT ON;

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
    NuevoValor NUMBER(11,2), --Nuevo Valor será el valor a tomar
    Estado VARCHAR(45), --Estado será el estado de la cuenta
    FechaMod DATE,  --FechaMod será la fecha de cuando se realizo la operación
    CONSTRAINT fk_cuenta FOREIGN KEY (IdCuenta) REFERENCES CUENTAS(IDCuenta) -- Definimos una clave foranea
);
*/

-- <------ FIN definicion de las Tablas ------> --

-- <------ Definicion del Script ------> --

DECLARE
-- <- Variables -> --
    Idcuenta NUMBER(4) := &id;
    Operacion CHAR(1) := &op;
    ValorNuevo NUMBER(11,2) := &vn;
    Comentario VARCHAR(45) := &c;
    
-- <- Fin Variables -> -- 
    
-- <- Excepciones -> --
    CuentaYaExiste EXCEPTION;
    CuentaNoExiste EXCEPTION;
    BorrarCuentaNoExiste EXCEPTION;
-- <- Fin Excepciones -> --
    
BEGIN
    IF Operacion = 'i' OR Operacion = 'I' THEN
        INSERT INTO CUENTAS VALUES
        (
            idcuenta,
            ValorNuevo
        );
        
        INSERT INTO ACCIONES VALUES
        (
            Idcuenta,
            Operacion,
            ValorNuevo,
            'Se inserto la cuenta con exito',
            SYSDATE
        );
        
    ELSIF Operacion = 'a' OR Operacion = 'A' THEN
        UPDATE CUENTAS
        SET Valor = ValorNuevo
        where IDCuenta = Idcuenta;
        
        INSERT INTO ACCIONES VALUES
        (
            Idcuenta,
            Operacion,
            ValorNuevo,
            'Se actualizo la cuenta con exito',
            SYSDATE
        );
        
    END IF;

EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('Datos no insertados');
    WHEN NO_DATA_FOUND THEN 
        DBMS_OUTPUT.PUT_LINE('Datos no actualizados');
    WHEN OTHERS THEN
        IF SQLCODE = -2291 THEN
            -- El codigo -2291 se corresponde con la excepcion ORA-02291: Intento de acceder a una clave foranea la cual no tiene una clave primaria coincidente
            -- Para mas informacion: https://docs.oracle.com/en/database/oracle/oracle-database/21/errmg/ORA-02100.html#GUID-008ABD32-275E-467A-AE6B-04976F2A8462
            DBMS_OUTPUT.PUT_LINE('Error al actualizar, la cuenta no existe. Procedemos a insertarla');
            INSERT INTO CUENTAS VALUES
            (
                idcuenta,
                ValorNuevo
            );
            INSERT INTO ACCIONES VALUES
            (
                Idcuenta,
                Operacion,
                ValorNuevo,
                'Se inserto la cuenta con exito',
                SYSDATE
            );           
            -- AQUI
        END IF;
END;
/