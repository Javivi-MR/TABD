--Autores: Adriana Maña Watson | Francisco Javier Molina Rojas
SET SERVEROUTPUT ON;

CREATE TABLE Inventario  --Creacion tabla Inventario --
(
    NombreArt VARCHAR(15),
    NumExistencias INT,
    FechaUltAct DATE
);
    
CREATE TABLE ControlVentas  --Creacion tabla ControlVentas --
(
    Nombreart VARCHAR(15),
    UnidVendidas INT,
    FechaVenta DATE,
    Comentario CHAR
);

-- INSERCION DE DATOS --

INSERT INTO Inventario VALUES
(
    'Galletas',
    24,
    TO_DATE('2023-01-21', 'YYYY-MM-DD')
);
  
INSERT INTO Inventario VALUES
(
    'Pelota',
    0,
    TO_DATE('2023-01-10', 'YYYY-MM-DD')
);
    
INSERT INTO ControlVentas VALUES
(
    'Galletas',
    6,
    TO_DATE('2022-12-30', 'YYYY-MM-DD'),
    'S'
);
    
INSERT INTO ControlVentas VALUES
(
    'Pelota',
    1,
    TO_DATE('2023-01-15', 'YYYY-MM-DD'),
    'S'
);  

-- FIN DE INSERCION DE DATOS --

DECLARE
    articulo VARCHAR(15) := &art; --Nombre del articulo a comprar
    uds INT := &uds; --unidades a comprar
    stockdisp INT; --Stock del articulo disponible
    
BEGIN

    -- 1er bloque: Consulta SQL --
    -- Objetivo: Conseguir el numero de existencias (stock) que posee el articulo a comprar --
    SELECT NumExistencias
    INTO stockdisp
    FROM Inventario
    WHERE NombreArt = articulo;
    -- Fin Consulta SQL --
    
    
    -- 2do bloque Hay que comprbar que el stock conseguido puede satisfacer el numero de unidades que se desea comprar --
    IF stockdisp >= uds THEN -- Si se puede realizar la compra (stock disp >= uds pedidas) --
        
        -- Primero restamos del inventario las uds pedidas --
        UPDATE Inventario 
        SET NumExistencias = stockdisp - uds, FechaUltAct = SYSDATE
        WHERE NombreArt = articulo;
        
        -- Segundo creamos una instancia de la venta con el nombre del articulo, las unidades, la fecha de hoy y el caracter 'S' que indica que la venta ha sido exitosa --
        INSERT INTO ControlVentas VALUES
        (
            articulo,
            uds,
            SYSDATE,
            'S'
        );   
    
    ELSE -- Si la venta no se a podido realizar --
        dbms_output.put_line('ERROR: EL NUMERO DE UNIDADES PEDIDAS ES MAYOR QUE EL STOCK DISPONIBLE'); -- Lo indicamos --
        INSERT INTO ControlVentas VALUES -- Realizamos un registro con el nombre del articulo, las unidades, la fecha de hoy y el caracter 'N' que indica que la venta NO ha sido exitosa --   
        (
            articulo,
            uds,
            SYSDATE,
            'N'
        );
    END IF;
    
EXCEPTION 
    WHEN NO_DATA_FOUND THEN --En el caso de que el objeto a buscar NO este en la base de datos
        dbms_output.put_line('ERROR: EL ARTICULO SELECCIONADO NO EXISTE'); 

END;