--Autores: Adriana Maña Watson | Francisco Javier Molina Rojas
SET SERVEROUTPUT ON;

DECLARE
	Temperatura REAL := &temp;
	Escala CHAR := &esc;
    tcalculada REAL;
BEGIN

	IF Escala = 'C' THEN
		tcalculada := (9/5)*Temperatura+32;
		dbms_output.put_line('La temperatura en Farenheit es: ' || tcalculada);
	ELSIF Escala = 'F' THEN
		tcalculada := (5/9)*(Temperatura-32);
		dbms_output.put_line('La temperatura en Celcius es: ' || tcalculada);
    ELSE
        dbms_output.put_line('ERROR: ESCALA NO ACEPTADA'); 
    END IF;
EXCEPTION WHEN OTHERS THEN
    dbms_output.put_line('ERROR: EXCEPCION'); 
	
END;