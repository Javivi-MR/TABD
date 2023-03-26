--Autores: Francisco Javier Molina Rojas | Adriana Maña Watson
CREATE OR REPLACE TRIGGER EmpleadosDisp  --Creamos trigger
AFTER INSERT OR UPDATE OR DELETE ON EMPLEADOS FOR EACH ROW --Despues de que se inserte, actualice o se borre un registro de la tabla empleados
DECLARE
    usuario VARCHAR2(50); --Variable para almacenar el usuario que posee la sesion
BEGIN
    usuario := USER; --USER es una funcion que devuelve el nombre del usuario que posee la sesion actual ya implementada en Oracle

    IF INSERTING THEN --Cuando se inserte una fila:
        --Notese que a partir de ahora no se usa la secuencia para el codigo de empleado, ya que la columna CodigoEmpleado es una columna identidad que se autoincrementa cada vez que se inserta un nuevo empleado y no hace falta introducir un valor en ella
        INSERT INTO ACCIONES (NOMBREUSUARIO,HORAMODIFICACION,ACCIONREALIZADA,FILAAFECTADA) VALUES (usuario,TO_CHAR(SYSDATE,'HH24:MI:SS'),'INSERT',:NEW.CODIGOEMPLEADO);-- Insertamos en la tabla acciones los datos de la fila insertada ademas de los datos de la sesion actual, la hora actual y la accion realizada
    
    ELSIF DELETING THEN
        INSERT INTO ACCIONES (NOMBREUSUARIO,HORAMODIFICACION,ACCIONREALIZADA,FILAAFECTADA) VALUES (usuario,TO_CHAR(SYSDATE,'HH24:MI:SS'),'DELETE',:OLD.CODIGOEMPLEADO); -- Insertamos en la tabla acciones los datos de la fila borrada ademas de los datos de la sesion actual, la hora actual y la accion realizada
    
    ELSIF UPDATING ('SUELDOEMPLEADO') THEN
        INSERT INTO ACCIONES (NOMBREUSUARIO,HORAMODIFICACION,ACCIONREALIZADA,FILAAFECTADA,COLUMNAAFECTADA,VALORANTES,VALORDESPUES) VALUES (usuario,TO_CHAR(SYSDATE,'HH24:MI:SS'),'UPDATE',:NEW.CODIGOEMPLEADO,'SUELDOEMPLEADO',:OLD.SUELDOEMPLEADO,:NEW.SUELDOEMPLEADO); -- Insertamos en la tabla acciones los datos de la fila actualizada ademas de los datos de la sesion actual, la hora actual y la accion realizada
        IF :OLD.NOMBREEMPLEADO != :NEW.NOMBREEMPLEADO THEN
            INSERT INTO ACCIONES (NOMBREUSUARIO,HORAMODIFICACION,ACCIONREALIZADA,FILAAFECTADA,COLUMNAAFECTADA,VALORANTES,VALORDESPUES) VALUES (usuario,TO_CHAR(SYSDATE,'HH24:MI:SS'),'UPDATE',:NEW.CODIGOEMPLEADO,'NOMBREEMPLEADO',:OLD.NOMBREEMPLEADO,:NEW.NOMBREEMPLEADO); -- Insertamos en la tabla acciones los datos de la fila actualizada ademas de los datos de la sesion actual, la hora actual y la accion realizada
        END IF;
        
    ELSIF UPDATING ('NOMBREEMPLEADO') THEN
        INSERT INTO ACCIONES (NOMBREUSUARIO,HORAMODIFICACION,ACCIONREALIZADA,FILAAFECTADA,COLUMNAAFECTADA,VALORANTES,VALORDESPUES) VALUES (usuario,TO_CHAR(SYSDATE,'HH24:MI:SS'),'UPDATE',:NEW.CODIGOEMPLEADO,'NOMBREEMPLEADO',:OLD.NOMBREEMPLEADO,:NEW.NOMBREEMPLEADO); -- Insertamos en la tabla acciones los datos de la fila actualizada ademas de los datos de la sesion actual, la hora actual y la accion realizada
        IF :OLD.SUELDOEMPLEADO != :NEW.SUELDOEMPLEADO THEN
            INSERT INTO ACCIONES (NOMBREUSUARIO,HORAMODIFICACION,ACCIONREALIZADA,FILAAFECTADA,COLUMNAAFECTADA,VALORANTES,VALORDESPUES) VALUES (usuario,TO_CHAR(SYSDATE,'HH24:MI:SS'),'UPDATE',:NEW.CODIGOEMPLEADO,'SUELDOEMPLEADO',:OLD.SUELDOEMPLEADO,:NEW.SUELDOEMPLEADO); -- Insertamos en la tabla acciones los datos de la fila actualizada ademas de los datos de la sesion actual, la hora actual y la accion realizada
        END IF;
    END IF;
    
EXCEPTION -- Apartado de excepciones
    -- Al tratarse de un trigger con solo operaciones insert, no existen muchas excepciones que se puedan dar.
    -- por lo que decidimos que si se produce una excepcion no esperada, se muestre un mensaje de error.
    WHEN OTHERS THEN    -- Cuando ocurra una excepcion no esperada 
        DBMS_OUTPUT.PUT_LINE('Ha ocurrido un error, revisa tu operacion y comprueba que los datos son correctos'); --Mostramos un mensaje de error

END; --Fin del trigger
/