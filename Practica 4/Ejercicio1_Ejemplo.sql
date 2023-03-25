-- Script para probar el trigger
BEGIN
    INSERT INTO EMPLEADOS (CODIGOEMPLEADO,NOMBREEMPLEADO,SUELDOEMPLEADO) VALUES (CODEMP.NEXTVAL,'Adriana',1000);
    UPDATE EMPLEADOS SET SUELDOEMPLEADO = 2000 WHERE CODIGOEMPLEADO = 1;
    UPDATE EMPLEADOS SET NOMBREEMPLEADO = 'Pedro' WHERE CODIGOEMPLEADO = 1;
    INSERT INTO EMPLEADOS (CODIGOEMPLEADO,NOMBREEMPLEADO,SUELDOEMPLEADO) VALUES (CODEMP.NEXTVAL,'Javivi',3500);
    UPDATE EMPLEADOS SET SUELDOEMPLEADO = 4000, NOMBREEMPLEADO = 'Javier' WHERE CODIGOEMPLEADO = 2;
    DELETE FROM EMPLEADOS WHERE CODIGOEMPLEADO = 1;
END;