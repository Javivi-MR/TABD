--Autores: Francisco Javier Molina Rojas | Adriana Maña Watson
CREATE OR REPLACE TRIGGER EmpleadosDisp  --Creamos trigger
AFTER INSERT OR UPDATE OR DELETE ON EMPLEADOS FOR EACH ROW  --Despues de que se inserte, actualice o se borre un registro de la tabla empleados 
DECLARE
    usuario VARCHAR2(50); --Variable para almacenar el usuario que posee la sesion
BEGIN
    usuario := USER; --USER es una funcion que devuelve el nombre del usuario que posee la sesion actual ya implementada en Oracle

    IF INSERTING THEN --Cuando se inserte una fila:
        INSERT INTO ACCIONES (IDENTIFICADOR,NOMBREUSUARIO,HORAMODIFICACION,ACCIONREALIZADA,FILAAFECTADA) VALUES (CODACC.NEXTVAL,usuario,TO_CHAR(SYSDATE,'HH24:MI:SS'),'INSERT',:NEW.CODIGOEMPLEADO); -- Insertamos en la tabla acciones los datos de la fila insertada ademas de los datos de la sesion actual, la hora actual y la accion realizada
    
    ELSIF DELETING THEN --Cuando se borre una fila:
        INSERT INTO ACCIONES (IDENTIFICADOR,NOMBREUSUARIO,HORAMODIFICACION,ACCIONREALIZADA,FILAAFECTADA) VALUES (CODACC.NEXTVAL,usuario,TO_CHAR(SYSDATE,'HH24:MI:SS'),'DELETE',:OLD.CODIGOEMPLEADO); -- Insertamos en la tabla acciones los datos de la fila borrada ademas de los datos de la sesion actual, la hora actual y la accion realizada
 
    -- Hay que tener en cuenta que a la hora de actualizar los datos de un empleado, se puede actualizar el sueldo o el nombre, o ambos a la vez
    -- Si se actualizacen ambos, el trigger solo recoge el primero que se actualice, por lo que hay que comprobar si se ha actualizado el sueldo o el nombre

    ELSIF UPDATING ('SUELDOEMPLEADO') THEN --Cuando se actualice el sueldo de un empleado :
        INSERT INTO ACCIONES (IDENTIFICADOR,NOMBREUSUARIO,HORAMODIFICACION,ACCIONREALIZADA,FILAAFECTADA,COLUMNAAFECTADA,VALORANTES,VALORDESPUES) VALUES (CODACC.NEXTVAL,usuario,TO_CHAR(SYSDATE,'HH24:MI:SS'),'UPDATE',:NEW.CODIGOEMPLEADO,'SUELDOEMPLEADO',:OLD.SUELDOEMPLEADO,:NEW.SUELDOEMPLEADO); -- Insertamos en la tabla acciones los datos de la fila actualizada con los datos del sueldo ademas de los datos de la sesion actual, la hora actual y la accion realizada
        -- tambien debemos comprobar si se ha actualizado el nombre del empleado
        IF :OLD.NOMBREEMPLEADO != :NEW.NOMBREEMPLEADO THEN 
            INSERT INTO ACCIONES (IDENTIFICADOR,NOMBREUSUARIO,HORAMODIFICACION,ACCIONREALIZADA,FILAAFECTADA,COLUMNAAFECTADA,VALORANTES,VALORDESPUES) VALUES (CODACC.NEXTVAL,usuario,TO_CHAR(SYSDATE,'HH24:MI:SS'),'UPDATE',:NEW.CODIGOEMPLEADO,'NOMBREEMPLEADO',:OLD.NOMBREEMPLEADO,:NEW.NOMBREEMPLEADO); -- Insertamos en la tabla acciones los datos de la fila actualizada con los datos del nombre ademas de los datos de la sesion actual, la hora actual y la accion realizada
        END IF;
        
    ELSIF UPDATING ('NOMBREEMPLEADO') THEN --Cuando se actualice el nombre de un empleado:
        INSERT INTO ACCIONES (IDENTIFICADOR,NOMBREUSUARIO,HORAMODIFICACION,ACCIONREALIZADA,FILAAFECTADA,COLUMNAAFECTADA,VALORANTES,VALORDESPUES) VALUES (CODACC.NEXTVAL,usuario,TO_CHAR(SYSDATE,'HH24:MI:SS'),'UPDATE',:NEW.CODIGOEMPLEADO,'NOMBREEMPLEADO',:OLD.NOMBREEMPLEADO,:NEW.NOMBREEMPLEADO); -- Insertamos en la tabla acciones los datos de la fila actualizada con los datos del nombre ademas de los datos de la sesion actual, la hora actual y la accion realizada
        -- tambien debemos comprobar si se ha actualizado el sueldo del empleado
        IF :OLD.SUELDOEMPLEADO != :NEW.SUELDOEMPLEADO THEN
            INSERT INTO ACCIONES (IDENTIFICADOR,NOMBREUSUARIO,HORAMODIFICACION,ACCIONREALIZADA,FILAAFECTADA,COLUMNAAFECTADA,VALORANTES,VALORDESPUES) VALUES (CODACC.NEXTVAL,usuario,TO_CHAR(SYSDATE,'HH24:MI:SS'),'UPDATE',:NEW.CODIGOEMPLEADO,'SUELDOEMPLEADO',:OLD.SUELDOEMPLEADO,:NEW.SUELDOEMPLEADO); -- Insertamos en la tabla acciones los datos de la fila actualizada con los datos del sueldo ademas de los datos de la sesion actual, la hora actual y la accion realizada
        END IF; 
    END IF;
    
EXCEPTION -- Apartado de excepciones
    -- Al tratarse de un trigger con solo operaciones insert, no existen muchas excepciones que se puedan dar.
    -- por lo que decidimos que si se produce una excepcion no esperada, se muestre un mensaje de error.
    WHEN OTHERS THEN    -- Cuando ocurra una excepcion no esperada 
        DBMS_OUTPUT.PUT_LINE('Ha ocurrido un error, revisa tu operacion y comprueba que los datos son correctos'); --Mostramos un mensaje de error

END;
/