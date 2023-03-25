-- Creacion de secuencias --

CREATE SEQUENCE codemp --Creamos secuencia para el codigo de empleado
INCREMENT BY 1 --Incrementa en 1 cada vez que se use la secuencia
START WITH 1 --Comienza en 1
MAXVALUE 50000 --El valor maximo que puede tener la secuencia es 50000
NOCACHE --No se almacena en memoria
NOCYCLE; --No se reinicia cuando llega al valor maximo

CREATE SEQUENCE codacc --Creamos secuencia para el codigo de accion
INCREMENT BY 1 --Incrementa en 1 cada vez que se use la secuencia
START WITH 1 --Comienza en 1
MAXVALUE 50000 --El valor maximo que puede tener la secuencia es 50000
NOCACHE --No se almacena en memoria
NOCYCLE; --No se reinicia cuando llega al valor maximo

-- Creacion de tablas --

CREATE TABLE EMPLEADOS
(
    CodigoEmpleado INTEGER, 
    NombreEmpleado VARCHAR2(50) NOT NULL,
    SueldoEmpleado FLOAT NOT NULL,
    CONSTRAINT PK_Empleados PRIMARY KEY(CodigoEmpleado)
);


CREATE TABLE ACCIONES
(
    Identificador INTEGER NOT NULL,
    NombreUsuario VARCHAR2(50) NOT NULL,
    HoraModificacion VARCHAR2(10) NOT NULL,
    AccionRealizada VARCHAR2(7) NOT NULL,
    FilaAfectada INTEGER NOT NULL, --Codigo del empleado afectado
    -- Si la accion realizada es un update, se guardaran el nombre de la columna afectada, el valor antes de la actualizacion y el valor despues de la actualizacion
    -- Usamos VARCHAR2 porque con este podemos guardar numeros y letras
    ColumnaAfectada VARCHAR2(50),
    ValorAntes VARCHAR2(50),
    ValorDespues VARCHAR2(50)
);