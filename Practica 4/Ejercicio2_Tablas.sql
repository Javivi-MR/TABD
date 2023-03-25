-- creacion de tablas --

CREATE TABLE EMPLEADOS
(
    CodigoEmpleado INTEGER GENERATED ALWAYS AS IDENTITY, --Creamos una columna identidad que se autoincrementa cada vez que se inserta un nuevo empleado
    NombreEmpleado VARCHAR2(50) NOT NULL,
    SueldoEmpleado FLOAT NOT NULL,
    CONSTRAINT PK_Empleados PRIMARY KEY(CodigoEmpleado)
);

CREATE TABLE ACCIONES
(
    Identificador INTEGER GENERATED ALWAYS AS IDENTITY, --Creamos una columna identidad que se autoincrementa cada vez que se inserta una nueva accion
    NombreUsuario VARCHAR2(50) NOT NULL,
    HoraModificacion VARCHAR2(10) NOT NULL,
    AccionRealizada VARCHAR2(7) NOT NULL,
    FilaAfectada INTEGER NOT NULL,
    ColumnaAfectada VARCHAR2(50),
    ValorAntes VARCHAR2(50),
    ValorDespues VARCHAR2(50)
);