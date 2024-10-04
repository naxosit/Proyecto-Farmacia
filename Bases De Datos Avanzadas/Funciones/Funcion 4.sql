-- MEDICOS

-- Función para insertar un médico dentro de la tabla Medicos (inserción)


CREATE OR REPLACE FUNCTION insertar_medico(
    p_Rut Medicos.Rut%TYPE,
    p_AniosServicio Medicos.AniosServicio%TYPE,
    p_Nombre Medicos.Nombre%TYPE,
    p_Apellido Medicos.Apellido%TYPE,
    p_FechaNacimiento Medicos.FechaNacimiento%TYPE,
    p_Direccion Medicos.Direccion%TYPE,
    p_Ciudad Medicos.Ciudad%TYPE,
    p_Correo Medicos.Correo%TYPE
)
RETURNS VOID AS $$
BEGIN
    INSERT INTO Medicos (Rut, AniosServicio, Nombre, Apellido, FechaNacimiento, Direccion, Ciudad, Correo)
    VALUES (p_Rut, p_AniosServicio, p_Nombre, p_Apellido, p_FechaNacimiento, p_Direccion, p_Ciudad, p_Correo);
END;
$$ LANGUAGE plpgsql;


-- Función para modificar un médico dentro de la tabla Médicos (modificación)


CREATE OR REPLACE FUNCTION modificar_medico(
    p_Rut Medicos.Rut%TYPE,
    p_AniosServicio Medicos.AniosServicio%TYPE,
    p_Nombre Medicos.Nombre%TYPE,
    p_Apellido Medicos.Apellido%TYPE,
    p_FechaNacimiento Medicos.FechaNacimiento%TYPE,
    p_Direccion Medicos.Direccion%TYPE,
    p_Ciudad Medicos.Ciudad%TYPE,
    p_Correo Medicos.Correo%TYPE
)
RETURNS VOID AS $$
BEGIN
    UPDATE Medicos
    SET AniosServicio = p_AniosServicio,
        Nombre = p_Nombre,
        Apellido = p_Apellido,
        FechaNacimiento = p_FechaNacimiento,
        Direccion = p_Direccion,
        Ciudad = p_Ciudad,
        Correo = p_Correo
    WHERE Rut = p_Rut;
END;
$$ LANGUAGE plpgsql;


-- Función para eliminar un médico dentro de la tabla Medicos (eliminación)


CREATE OR REPLACE FUNCTION eliminar_medico(p_Rut Medicos.Rut%TYPE)
RETURNS VOID AS $$
BEGIN
    DELETE FROM Medicos
    WHERE Rut = p_Rut;
END;
$$ LANGUAGE plpgsql;


-- Función para seleccionar un médico dentro de la tabla Médicos (Selección)


CREATE OR REPLACE FUNCTION seleccionar_medico(p_Rut Medicos.Rut%TYPE)
RETURNS TABLE (
    Rut Medicos.Rut%TYPE,
    AniosServicio Medicos.AniosServicio%TYPE,
    Nombre Medicos.Nombre%TYPE,
    Apellido Medicos.Apellido%TYPE,
    FechaNacimiento Medicos.FechaNacimiento%TYPE,
    Direccion Medicos.Direccion%TYPE,
    Ciudad Medicos.Ciudad%TYPE,
    Correo Medicos.Correo%TYPE
) AS $$
BEGIN
    RETURN QUERY
    SELECT
        m.Rut,
        m.AniosServicio,
        m.Nombre,
        m.Apellido,
        m.FechaNacimiento,
        m.Direccion,
        m.Ciudad,
        m.Correo
    FROM Medicos m
    WHERE m.Rut = p_Rut;
END;
$$ LANGUAGE plpgsql;


-- PACIENTES

-- Función para insertar un paciente (inserción)

CREATE OR REPLACE FUNCTION insertar_paciente(
    p_Rut Paciente.Rut%TYPE,
    p_Nombre Paciente.Nombre%TYPE,
    p_Apellido Paciente.Apellido%TYPE,
    p_FechaNacimiento Paciente.FechaNacimiento%TYPE,
    p_Direccion Paciente.Direccion%TYPE,
    p_Ciudad Paciente.Ciudad%TYPE,
    p_Correo Paciente.Correo%TYPE,
    p_RutMedico Paciente.RutMedico%TYPE,
    p_FechaInicio Paciente.FechaInicio%TYPE,
    p_FechaFin Paciente.FechaFin%TYPE
)
RETURNS VOID AS $$
BEGIN
    INSERT INTO Paciente (Rut, Nombre, Apellido, FechaNacimiento, Direccion, Ciudad, Correo, RutMedico, FechaInicio, FechaFin)
    VALUES (p_Rut, p_Nombre, p_Apellido, p_FechaNacimiento, p_Direccion, p_Ciudad, p_Correo, p_RutMedico, p_FechaInicio, p_FechaFin);
END;
$$ LANGUAGE plpgsql;

-- Función para modificar un paciente (modificación)

CREATE OR REPLACE FUNCTION modificar_paciente(
	p_Rut Paciente.Rut%TYPE,
    p_Nombre Paciente.Nombre%TYPE,
    p_Apellido Paciente.Apellido%TYPE,
    p_FechaNacimiento Paciente.FechaNacimiento%TYPE,
    p_Direccion Paciente.Direccion%TYPE,
    p_Ciudad Paciente.Ciudad%TYPE,
    p_Correo Paciente.Correo%TYPE,
    p_RutMedico Paciente.RutMedico%TYPE,
    p_FechaInicio Paciente.FechaInicio%TYPE,
    p_FechaFin Paciente.FechaFin%TYPE
)
RETURNS VOID AS $$
BEGIN 
	UPDATE Paciente
	SET Nombre = p_Nombre,
		Apellido = p_Apellido,
		FechaNacimiento = p_FechaNacimiento,
		Direccion = p_Direccion,
		Ciudad = p_Ciudad,
		Correo = p_Correo,
		RutMedico = p_RutMedico,
		FechaInicio = p_FechaInicio,
		FechaFin = p_FechaFin
	WHERE Rut = p_Rut;
END;
$$ LANGUAGE plpgsql;

-- Función para eliminar un paciente (eliminación)

CREATE OR REPLACE FUNCTION eliminar_paciente(p_Rut Paciente.Rut%TYPE)
RETURNS VOID AS $$
BEGIN
	DELETE FROM Paciente
	WHERE Rut = p_Rut;
END;
$$ LANGUAGE plpgsql;

-- Función para seleccionar un paciente (selección)

CREATE OR REPLACE FUNCTION seleccionar_paciente(p_Rut Paciente.Rut%TYPE)
RETURNS TABLE (
    Rut Paciente.Rut%TYPE,
    Nombre Paciente.Nombre%TYPE,
    Apellido Paciente.Apellido%TYPE,
    FechaNacimiento Paciente.FechaNacimiento%TYPE,
    Direccion Paciente.Direccion%TYPE,
    Ciudad Paciente.Ciudad%TYPE,
    Correo Paciente.Correo%TYPE,
    RutMedico Paciente.RutMedico%TYPE,
    FechaInicio Paciente.FechaInicio%TYPE,
    FechaFin Paciente.FechaFin%TYPE
) AS $$
BEGIN
    RETURN QUERY
    SELECT
        p.Rut,
        p.Nombre,
        p.Apellido,
        p.FechaNacimiento,
        p.Direccion,
        p.Ciudad,
        p.Correo,
        p.RutMedico,
        p.FechaInicio,
        p.FechaFin
    FROM Paciente p
    WHERE p.Rut = p_Rut;
END;
$$ LANGUAGE plpgsql;

-- EMPRESAS

-- Función para insertar un registro en la tabla EmpresaFarmaceutica

CREATE OR REPLACE FUNCTION insertar_empresa_farmaceutica(
	p_Codigo EmpresaFarmaceutica.Codigo%TYPE,
	p_Nombre EmpresaFarmaceutica.Nombre%TYPE
)
RETURNS VOID AS $$
BEGIN
	-- Insertamos un nuevo registro en la tabla EmpresaFarmaceutica con los valores proporcionados
	INSERT INTO EmpresaFarmaceutica (Codigo, Nombre)
	VALUES (p_Codigo, p_Nombre);
END;
$$ LANGUAGE plpgsql;

-- Función para modificar un registro existente en la tabla EmpresaFarmacia

CREATE OR REPLACE FUNCTION modificar_empresa_farmaceutica(
	p_Codigo EmpresaFarmaceutica.Codigo%TYPE,
	p_Nombre EmpresaFarmaceutica.Nombre%TYPE
)
RETURNS VOID AS $$ 
BEGIN
	-- Actualizamos el registro de la empresa farmacéutica 
	UPDATE EmpresaFarmaceutica
	SET Nombre = p_Nombre -- Se actualiza el nombre de la empresa
	WHERE Codigo = p_Codigo; -- Condición para identificar el registro a modificar
END;
$$ LANGUAGE plpgsql;

-- Función para eliminar un registro de la tabla EmpresaFarmaceutica

CREATE OR REPLACE FUNCTION eliminar_empresa_farmaceutica(p_Codigo EmpresaFarmaceutica.Codigo%TYPE)
RETURNS VOID AS $$
BEGIN
	-- Eliminamos el registro
	DELETE FROM EmpresaFarmaceutica
	WHERE Codigo = p_Codigo; -- Condición para identificar el registro a eliminar
END;
$$ LANGUAGE plpgsql;

-- Función para seleccionar un registro de la tabla EmpresaFarmaceutica

CREATE OR REPLACE FUNCTION seleccionar_empresa_farmaceutica(p_Codigo EmpresaFarmaceutica.Codigo%TYPE)	
RETURNS TABLE (
	Codigo EmpresaFarmaceutica.Codigo%TYPE,
	Nombre EmpresaFarmaceutica.Nombre%TYPE
) AS $$
BEGIN
	-- Retornamos el registro
	RETURN QUERY
	SELECT 
		e.Codigo, -- Codigo de la empresa farmacéutica
		e.Nombre -- Nombre de la empresa farmacéutica
	FROM EmpresaFarmaceutica e
	WHERE e.Codigo = p_Codigo; -- Condición para identificar el registro a seleccionar
END;
$$ LANGUAGE plpgsql;

-- TELEFONOS

-- Función para insertar un teléfono (inserción)

CREATE OR REPLACE FUNCTION insertar_telefono(
	p_Codigo Telefono.Codigo%TYPE
)
RETURNS VOID AS $$
BEGIN
	-- Insertamos un nuevo registro en la tabla Telefono
	INSERT INTO Telefono (Codigo)
	VALUES (p_Codigo);
END; 
$$ LANGUAGE plpgsql;

-- Función para modificar un teléfono (modificación)

CREATE OR REPLACE FUNCTION modificar_telefono(
	p_CodigoViejo Telefono.Codigo%TYPE, -- Código actual del teléfono a modificar
	p_CodigoNuevo Telefono.Codigo%TYPE -- Nuevo código que reemplazará al existente
)
RETURNS VOID AS $$
BEGIN
	-- Actualizamos el registro de la tabla Telefono
	UPDATE Telefono
	SET Codigo = p_CodigoNuevo -- Se actualiza el código del teléfono
	WHERE Codigo = p_CodigoViejo; -- Condición para identificar el registro a modificar
END;
$$ LANGUAGE plpgsql;

-- Función para eliminar un teléfono (eliminación)

CREATE OR REPLACE FUNCTION eliminar_telefono(p_Codigo Telefono.Codigo%TYPE)
RETURNS VOID AS $$
BEGIN 
	-- Eliminamos el registro 
	DELETE FROM Telefono
	WHERE Codigo = p_Codigo; -- Condición para identificar el registro a eliminar
END; 
$$ LANGUAGE plpgsql;

-- Función para seleccionar un teléfono (selección)

CREATE OR REPLACE FUNCTION seleccionar_telefono(p_Codigo Telefono.Codigo%TYPE)
RETURNS TABLE (
	Codigo Telefono.Codigo%TYPE
) AS $$
BEGIN
	-- Retornamos el registro 
	RETURN QUERY
	SELECT
		t.Codigo -- Código del teléfono
	FROM Telefono t
	WHERE t.Codigo = p_Codigo; -- Condición para identificar el registro a seleccionar
END;
$$ LANGUAGE plpgsql;

-- ESPECIALIDAD

-- Función para insertar una especialidad (inserción)

CREATE OR REPLACE FUNCTION insertar_especialidad(
	p_Codigo Especialidad.Codigo%TYPE, -- Código de la especialidad
	p_Nombre Especialidad.Nombre%TYPE -- Nombre de la especialidad
)
RETURNS VOID AS $$ 
BEGIN 
	-- Insertamos un nuevo registro en la tabla Especialidad
	INSERT INTO Especialidad (Codigo, Nombre)
	VALUES (p_Codigo, p_Nombre);
END;
$$ LANGUAGE plpgsql;

-- Función para modificar una especialidad (modificación)

CREATE OR REPLACE FUNCTION modificar_especialidad(
	p_Codigo Especialidad.Codigo%TYPE, -- Código de la especialidad a modificar
	p_Nombre Especialidad.Nombre%TYPE --Nuevo nombre que reemplazará al existente
)
RETURNS VOID AS $$
BEGIN
	-- Actualizamos el registro de la tabla Especialidad
	UPDATE Especialidad
	SET Nombre = p_Nombre -- Se actualiza el nombre de la especialidad
	WHERE Codigo = p_Codigo; -- Condición apra identificar el registro a modificar
END;
$$ LANGUAGE plpgsql;

-- Función para eliminar una especialidad (eliminación)

CREATE OR REPLACE FUNCTION eliminar_especialidad(p_Codigo Especialidad.Codigo%TYPE)
RETURNS VOID AS $$
BEGIN 
	-- Eliminamos el registro 
	DELETE FROM Especialidad
	WHERE Codigo = p_Codigo; -- Condición para identificar el registro a eliminar
END;
$$ LANGUAGE plpgsql;

-- Función para seleccionar una especialidad (selección)

CREATE OR REPLACE FUNCTION seleccionar_especialidad(p_Codigo Especialidad.Codigo%TYPE)
RETURNS TABLE (
	Codigo Especialidad.Codigo%TYPE, -- Código de la especialidad
	Nombre Especialidad.Nombre%TYPE -- Nombre de la especialidad
) AS $$
BEGIN
	-- Retornamos el registro 
	RETURN QUERY
	SELECT
		e.Codigo, -- Código de la especialidad
		e.Nombre -- Nombre de la especialidad
	FROM Especialidad e
	WHERE e.Codigo = p_Codigo; -- Condición para identificar el registro a seleccionar
END;
$$ LANGUAGE plpgsql;

-- RECETA MEDICA

-- Función para insertar una receta médica (inserción)

CREATE OR REPLACE FUNCTION insertar_receta_medica(
	p_Codigo RecetaMedica.Codigo%TYPE, -- Código de la receta médica
	p_TextoDescripcion RecetaMedica.TextoDescripcion%TYPE, -- Descripción de la receta médica
	p_Fecha RecetaMedica.Fecha%TYPE -- Fecha de emisión de la receta médica
)
RETURNS VOID AS $$
BEGIN
	-- Insertamos un nuevo registro en la tabla RecetaMedica
	INSERT INTO RecetaMedica(Codigo, TextoDescripcion, Fecha)
	VALUES (p_Codigo, p_TextoDescripcion, p_Fecha);
END;
$$ LANGUAGE plpgsql;

-- Función para modificar una receta médica (modificación)

CREATE OR REPLACE FUNCTION modificar_receta_medica(
	p_Codigo RecetaMedica.Codigo%TYPE, -- Código de la receta médica a modificar
	p_TextoDescripcion RecetaMedica.TextoDescripcion%TYPE, -- Nueva descripción de la receta
	p_Fecha RecetaMedica.Fecha%TYPE -- Nueva fecha de la receta
)
RETURNS VOID AS $$
BEGIN
	-- Actualizamos el registro de la tabla RecetaMedica
	UPDATE RecetaMedica
	SET TextoDescripcion = p_TextoDescripcion, -- Se actualiza la descripción de la receta médica
		Fecha = p_Fecha -- Se actualiza la fecha de emisión de la receta médica
	WHERE Codigo = p_Codigo; -- Condición para identificar el registro a modificar
END;
$$ LANGUAGE plpgsql;

-- Función para eliminar una receta médica (eliminación)

CREATE OR REPLACE FUNCTION eliminar_receta_medica(p_Codigo RecetaMedica.Codigo%TYPE)
RETURNS VOID AS $$
BEGIN
	-- Eliminamos el registro 
	DELETE FROM RecetaMedica
	WHERE Codigo = p_Codigo; -- Condición para identificar el registro a eliminar
END;
$$ LANGUAGE plpgsql;

-- Función para seleccionar una receta médica (selección)

CREATE OR REPLACE FUNCTION seleccionar_receta_medica(p_Codigo RecetaMedica.Codigo%TYPE)
RETURNS TABLE (
	Codigo RecetaMedica.Codigo%TYPE, -- Código de la receta médica
	TextoDescripcion RecetaMedica.TextoDescripcion%TYPE, -- Descripción de la receta médica
	Fecha RecetaMedica.Fecha%TYPE -- Fecha de emisión de la receta médica
) AS $$
BEGIN
	-- Retornamos el registro que coincide con el código proporcionado
	RETURN QUERY
	SELECT 
		r.Codigo, -- Código de la receta médica
		r.TextoDescripcion, -- Descripción de la receta médica
		r.Fecha -- Fecha de la receta médica
	FROM RecetaMedica r
	WHERE r.Codigo = p_Codigo; -- Condición para identificar el registro a seleccionar
END;
$$ LANGUAGE plpgsql;

-- PREVISION

-- Función para insertar una previsión (inserción)

CREATE OR REPLACE FUNCTION insertar_prevision(
	p_Codigo Prevision.Codigo%TYPE, -- Código de la previsión
	p_Nombre Prevision.Nombre%TYPE, -- Nombre de la previsión
	p_Tipo Prevision.Tipo%TYPE -- Tipo de previsión
)
RETURNS VOID AS $$
BEGIN
	-- Insertamos un nuevo registro en la tabla Prevision
	INSERT INTO Prevision (Codigo, Nombre, Tipo)
	VALUES (p_Codigo, p_Nombre, p_Tipo);
END;
$$ LANGUAGE plpgsql;

-- Función para modificar una previsión (modificación)

CREATE OR REPLACE FUNCTION modificar_prevision (
	p_codigo Prevision.Codigo%TYPE, -- Código de la previsión a modificar
	p_nombre Prevision.Nombre%TYPE, -- Nuevo nombre de la previsión
	p_Tipo Prevision.Tipo%TYPE -- Nuevo tipo de previsión
)
RETURNS VOID AS $$
BEGIN
	-- Actualizamos el registro de la tabla Prevision
	UPDATE PREVISION
	SET Nombre = p_nombre, --Se actualiza el nombre de la previsión
		Tipo = p_Tipo -- Se actualiza el tipo de previsión
	WHERE Codigo = p_Codigo -- Condición para identificar el registro a modificar
END;
$$ LANGUAGE plpgsql;

-- Función para eliminar una previsión (eliminación)

CREATE OR REPLACE FUNCTION eliminar_prevision(p_codigo Prevision.Codigo%TYPE)
RETURNS VOID AS $$
BEGIN
	-- Eliminamos el registro 
	DELETE FROM Prevision
	WHERE Codigo = p_Codigo; -- Condición para identificar el registro a eliminar
END;
$$ LANGUAGE plpgsql;

-- Función para seleccionar una previsión (selección)

CREATE OR REPLACE FUNCTION sleccionar_prevision(p_Codigo Prevision.Codigo%TYPE)
RETURNS TABLE (
	Codigo Prevision.Codigo%TYPE, -- Código de la previsión
	Nombre Prevision.Nombre%TYPE, -- Nombre de la previsión
	Tipo Prevision.Tipo%TYPE -- Tipo de previsión
) AS $$
BEGIN
	-- Retornamos el registro que coincide con el código proporcionado
	RETURN QUERY
	SELECT
		p.Codigo, -- Código de la previsión
		p.Nombre, -- Nombre de la previsión
		p.Tipo -- Tipo de previsión
	FROM Prevision p
	WHERE p.Codigo = p_Codigo; -- Condición para identificar el registro a seleccionar
END;
$$ LANGUAGE plpgsql;

-- CONTRATO

-- Función para insertar un contrato (inserción)
CREATE OR REPLACE FUNCTION insertar_contrato(
    p_Codigo Contrato.Codigo%TYPE,         -- Código del contrato
    p_FechaInicio Contrato.FechaInicio%TYPE, -- Fecha de inicio del contrato
    p_FechaTermino Contrato.FechaTermino%TYPE, -- Fecha de término del contrato
    p_TextoContrato Contrato.TextoContrato%TYPE -- Texto descriptivo del contrato
)
RETURNS VOID AS $$
BEGIN
    -- Insertamos un nuevo registro en la tabla Contrato 
    INSERT INTO Contrato (Codigo, FechaInicio, FechaTermino, TextoContrato)
    VALUES (p_Codigo, p_FechaInicio, p_FechaTermino, p_TextoContrato);
END;
$$ LANGUAGE plpgsql;


-- Función para modificar un contrato (modificación)

CREATE OR REPLACE FUNCTION modificar_contrato(
    p_Codigo Contrato.Codigo%TYPE,         -- Código del contrato a modificar
    p_FechaInicio Contrato.FechaInicio%TYPE, -- Nueva fecha de inicio del contrato
    p_FechaTermino Contrato.FechaTermino%TYPE, -- Nueva fecha de término del contrato
    p_TextoContrato Contrato.TextoContrato%TYPE -- Nuevo texto descriptivo del contrato
)
RETURNS VOID AS $$
BEGIN
    -- Actualizamos el registro de la tabla Contrato que coincide con el código proporcionado
    UPDATE Contrato
    SET FechaInicio = p_FechaInicio,   -- Se actualiza la fecha de inicio del contrato
        FechaTermino = p_FechaTermino, -- Se actualiza la fecha de término del contrato
        TextoContrato = p_TextoContrato -- Se actualiza el texto del contrato
    WHERE Codigo = p_Codigo;           -- Condición para identificar el registro a modificar
END;
$$ LANGUAGE plpgsql;


-- Función para eliminar un contrato (eliminación)

CREATE OR REPLACE FUNCTION eliminar_contrato(p_Codigo Contrato.Codigo%TYPE)
RETURNS VOID AS $$
BEGIN
    -- Eliminamos el registro que coincide con el código proporcionado
    DELETE FROM Contrato
    WHERE Codigo = p_Codigo; -- Condición para identificar el registro a eliminar
END;
$$ LANGUAGE plpgsql;

-- Función para seleccionar un contrato (selección)

CREATE OR REPLACE FUNCTION seleccionar_contrato(p_Codigo Contrato.Codigo%TYPE)
RETURNS TABLE (
    Codigo Contrato.Codigo%TYPE,         -- Código del contrato
    FechaInicio Contrato.FechaInicio%TYPE, -- Fecha de inicio del contrato
    FechaTermino Contrato.FechaTermino%TYPE, -- Fecha de término del contrato
    TextoContrato Contrato.TextoContrato%TYPE -- Texto descriptivo del contrato
) AS $$
BEGIN
    -- Retornamos el registro que coincide con el código proporcionado
    RETURN QUERY
    SELECT
        c.Codigo,         -- Código del contrato
        c.FechaInicio,    -- Fecha de inicio del contrato
        c.FechaTermino,   -- Fecha de término del contrato
        c.TextoContrato   -- Texto descriptivo del contrato
    FROM Contrato c
    WHERE c.Codigo = p_Codigo; -- Condición para identificar el registro a seleccionar
END;
$$ LANGUAGE plpgsql;

-- FARMACIAS 

-- Función para insertar una farmacia (inserción)

CREATE OR REPLACE FUNCTION insertar_farmacia(
    p_Codigo Farmacias.Codigo%TYPE,         -- Código de la farmacia
    p_Nombre Farmacias.Nombre%TYPE,         -- Nombre de la farmacia
    p_Direccion Farmacias.Direccion%TYPE    -- Dirección de la farmacia
)
RETURNS VOID AS $$
BEGIN
    -- Insertamos un nuevo registro en la tabla Farmacias con los valores proporcionados
    INSERT INTO Farmacias (Codigo, Nombre, Direccion)
    VALUES (p_Codigo, p_Nombre, p_Direccion);
END;
$$ LANGUAGE plpgsql;

-- Función para modificar una farmacia (modificación)

CREATE OR REPLACE FUNCTION modificar_farmacia(
    p_Codigo Farmacias.Codigo%TYPE,         -- Código de la farmacia a modificar
    p_Nombre Farmacias.Nombre%TYPE,         -- Nuevo nombre de la farmacia
    p_Direccion Farmacias.Direccion%TYPE    -- Nueva dirección de la farmacia
)
RETURNS VOID AS $$
BEGIN
    -- Actualizamos el registro de la tabla Farmacias que coincide con el código proporcionado
    UPDATE Farmacias
    SET Nombre = p_Nombre,         -- Se actualiza el nombre de la farmacia
        Direccion = p_Direccion    -- Se actualiza la dirección de la farmacia
    WHERE Codigo = p_Codigo;       -- Condición para identificar el registro a modificar
END;
$$ LANGUAGE plpgsql;

-- Función para eliminar una farmacia (eliminación)

CREATE OR REPLACE FUNCTION eliminar_farmacia(p_Codigo Farmacias.Codigo%TYPE)
RETURNS VOID AS $$
BEGIN
    -- Eliminamos el registro que coincide con el código proporcionado
    DELETE FROM Farmacias
    WHERE Codigo = p_Codigo; -- Condición para identificar el registro a eliminar
END;
$$ LANGUAGE plpgsql;

-- Función para seleccionar una farmacia (selección)

CREATE OR REPLACE FUNCTION seleccionar_farmacia(p_Codigo Farmacias.Codigo%TYPE)
RETURNS TABLE (
    Codigo Farmacias.Codigo%TYPE,         -- Código de la farmacia
    Nombre Farmacias.Nombre%TYPE,         -- Nombre de la farmacia
    Direccion Farmacias.Direccion%TYPE    -- Dirección de la farmacia
) AS $$
BEGIN
    -- Retornamos el registro que coincide con el código proporcionado
    RETURN QUERY
    SELECT
        f.Codigo,         -- Código de la farmacia
        f.Nombre,         -- Nombre de la farmacia
        f.Direccion       -- Dirección de la farmacia
    FROM Farmacias f
    WHERE f.Codigo = p_Codigo; -- Condición para identificar el registro a seleccionar
END;
$$ LANGUAGE plpgsql;

-- MEDICAMENTO

-- Función para insertar un medicamento (inserción)

CREATE OR REPLACE FUNCTION insertar_medicamento(
    p_NombreComercial Medicamento.NombreComercial%TYPE,  -- Nombre comercial del medicamento
    p_Formula Medicamento.Formula%TYPE                   -- Fórmula del medicamento
)
RETURNS VOID AS $$
BEGIN
    -- Insertamos un nuevo medicamento en la tabla Medicamento
    INSERT INTO Medicamento (NombreComercial, Formula)
    VALUES (p_NombreComercial, p_Formula);
END;
$$ LANGUAGE plpgsql;

-- Función para modificar un medicamento (modificación)

CREATE OR REPLACE FUNCTION modificar_medicamento(
    p_NombreComercial Medicamento.NombreComercial%TYPE,  -- Nombre comercial del medicamento a modificar
    p_Formula Medicamento.Formula%TYPE                   -- Nueva fórmula del medicamento
)
RETURNS VOID AS $$
BEGIN
    -- Actualizamos el registro que coincide con el nombre comercial proporcionado
    UPDATE Medicamento
    SET Formula = p_Formula  -- Se actualiza la fórmula del medicamento
    WHERE NombreComercial = p_NombreComercial;  -- Condición para identificar el medicamento
END;
$$ LANGUAGE plpgsql;

-- Función para eliminar un medicamento (eliminación)

CREATE OR REPLACE FUNCTION eliminar_medicamento(p_NombreComercial Medicamento.NombreComercial%TYPE)
RETURNS VOID AS $$
BEGIN
    -- Eliminamos el medicamento que coincide con el nombre comercial proporcionado
    DELETE FROM Medicamento
    WHERE NombreComercial = p_NombreComercial;  -- Condición para identificar el medicamento a eliminar
END;
$$ LANGUAGE plpgsql;

-- Función para seleccionar un medicamento (selección)

CREATE OR REPLACE FUNCTION seleccionar_medicamento(p_NombreComercial Medicamento.NombreComercial%TYPE)
RETURNS TABLE (
    NombreComercial Medicamento.NombreComercial%TYPE,  -- Nombre comercial del medicamento
    Formula Medicamento.Formula%TYPE                  -- Fórmula del medicamento
) AS $$
BEGIN
    -- Retornamos el registro que coincide con el nombre comercial proporcionado
    RETURN QUERY
    SELECT
        m.NombreComercial,  -- Nombre comercial del medicamento
        m.Formula           -- Fórmula del medicamento
    FROM Medicamento m
    WHERE m.NombreComercial = p_NombreComercial;  -- Condición para seleccionar el medicamento
END;
$$ LANGUAGE plpgsql;

-- SUPERVISOR

-- Función para insertar un supervisor (insercion)

CREATE OR REPLACE FUNCTION insertar_supervisor(
    p_Rut Supervisor.Rut%TYPE,                   -- RUT del supervisor
    p_Nombre Supervisor.Nombre%TYPE,             -- Nombre del supervisor
    p_Apellido Supervisor.Apellido%TYPE,         -- Apellido del supervisor
    p_FechaNacimiento Supervisor.FechaNacimiento%TYPE, -- Fecha de nacimiento del supervisor
    p_Direccion Supervisor.Direccion%TYPE,       -- Dirección del supervisor
    p_Ciudad Supervisor.Ciudad%TYPE,             -- Ciudad del supervisor
    p_Correo Supervisor.Correo%TYPE,             -- Correo electrónico del supervisor
    p_CodigoFarmacia Supervisor.CodigoFarmacia%TYPE -- Código de la farmacia asignada al supervisor
)
RETURNS VOID AS $$
BEGIN
    -- Insertamos un nuevo registro en la tabla Supervisor
    INSERT INTO Supervisor (Rut, Nombre, Apellido, FechaNacimiento, Direccion, Ciudad, Correo, CodigoFarmacia)
    VALUES (p_Rut, p_Nombre, p_Apellido, p_FechaNacimiento, p_Direccion, p_Ciudad, p_Correo, p_CodigoFarmacia);
END;
$$ LANGUAGE plpgsql;

-- Función para modificar un supervisor (modificación)

CREATE OR REPLACE FUNCTION modificar_supervisor(
    p_Rut Supervisor.Rut%TYPE,                   -- RUT del supervisor a modificar
    p_Nombre Supervisor.Nombre%TYPE,             -- Nuevo nombre del supervisor
    p_Apellido Supervisor.Apellido%TYPE,         -- Nuevo apellido del supervisor
    p_FechaNacimiento Supervisor.FechaNacimiento%TYPE, -- Nueva fecha de nacimiento del supervisor
    p_Direccion Supervisor.Direccion%TYPE,       -- Nueva dirección del supervisor
    p_Ciudad Supervisor.Ciudad%TYPE,             -- Nueva ciudad del supervisor
    p_Correo Supervisor.Correo%TYPE,             -- Nuevo correo electrónico del supervisor
    p_CodigoFarmacia Supervisor.CodigoFarmacia%TYPE -- Nuevo código de la farmacia asignada
)
RETURNS VOID AS $$
BEGIN
    -- Actualizamos el registro de la tabla Supervisor 
    UPDATE Supervisor
    SET Nombre = p_Nombre,                    -- Se actualiza el nombre
        Apellido = p_Apellido,                -- Se actualiza el apellido
        FechaNacimiento = p_FechaNacimiento,  -- Se actualiza la fecha de nacimiento
        Direccion = p_Direccion,              -- Se actualiza la dirección
        Ciudad = p_Ciudad,                    -- Se actualiza la ciudad
        Correo = p_Correo,                    -- Se actualiza el correo electrónico
        CodigoFarmacia = p_CodigoFarmacia     -- Se actualiza el código de la farmacia asignada
    WHERE Rut = p_Rut;                        -- Condición para identificar el supervisor
END;
$$ LANGUAGE plpgsql;

-- Función para eliminar un supervisor (eliminación)

CREATE OR REPLACE FUNCTION eliminar_supervisor(p_Rut Supervisor.Rut%TYPE)
RETURNS VOID AS $$
BEGIN
    -- Eliminamos el registro que coincide con el RUT proporcionado
    DELETE FROM Supervisor
    WHERE Rut = p_Rut;  -- Condición para identificar el supervisor a eliminar
END;
$$ LANGUAGE plpgsql;

-- Función para seleccionar un supervisor (selección)

CREATE OR REPLACE FUNCTION seleccionar_supervisor(p_Rut Supervisor.Rut%TYPE)
RETURNS TABLE (
    Rut Supervisor.Rut%TYPE,                   -- RUT del supervisor
    Nombre Supervisor.Nombre%TYPE,             -- Nombre del supervisor
    Apellido Supervisor.Apellido%TYPE,         -- Apellido del supervisor
    FechaNacimiento Supervisor.FechaNacimiento%TYPE, -- Fecha de nacimiento del supervisor
    Direccion Supervisor.Direccion%TYPE,       -- Dirección del supervisor
    Ciudad Supervisor.Ciudad%TYPE,             -- Ciudad del supervisor
    Correo Supervisor.Correo%TYPE,             -- Correo del supervisor
    CodigoFarmacia Supervisor.CodigoFarmacia%TYPE -- Código de la farmacia asignada
) AS $$
BEGIN
    -- Retornamos el registro que coincide con el RUT proporcionado
    RETURN QUERY
    SELECT
        s.Rut,                -- RUT del supervisor
        s.Nombre,             -- Nombre del supervisor
        s.Apellido,           -- Apellido del supervisor
        s.FechaNacimiento,    -- Fecha de nacimiento del supervisor
        s.Direccion,          -- Dirección del supervisor
        s.Ciudad,             -- Ciudad del supervisor
        s.Correo,             -- Correo electrónico del supervisor
        s.CodigoFarmacia      -- Código de la farmacia asignada
    FROM Supervisor s
    WHERE s.Rut = p_Rut;  -- Condición para seleccionar el supervisor
END;
$$ LANGUAGE plpgsql;

-- VENDE

-- Función para insertar un registro en "Vende" (inserción)

CREATE OR REPLACE FUNCTION insertar_vende(
    p_NombreComercialMedicamento Vende.NombreComercialMedicamento%TYPE, -- Nombre comercial del medicamento
    p_CodigoFarmacia Vende.CodigoFarmacia%TYPE,                         -- Código de la farmacia que vende el medicamento
    p_Precio Vende.Precio%TYPE                                          -- Precio del medicamento
)
RETURNS VOID AS $$
BEGIN
    -- Insertamos un nuevo registro en la tabla Vende
    INSERT INTO Vende (NombreComercialMedicamento, CodigoFarmacia, Precio)
    VALUES (p_NombreComercialMedicamento, p_CodigoFarmacia, p_Precio);
END;
$$ LANGUAGE plpgsql;

-- Función para modificar un registro en "Vende" (modificación)

CREATE OR REPLACE FUNCTION modificar_vende(
    p_NombreComercialMedicamento Vende.NombreComercialMedicamento%TYPE, -- Nombre comercial del medicamento
    p_CodigoFarmacia Vende.CodigoFarmacia%TYPE,                         -- Código de la farmacia que vende el medicamento
    p_Precio Vende.Precio%TYPE                                          -- Nuevo precio del medicamento
)
RETURNS VOID AS $$
BEGIN
    -- Actualizamos el registro en la tabla Vende
    UPDATE Vende
    SET Precio = p_Precio                 -- Se actualiza el precio del medicamento
    WHERE NombreComercialMedicamento = p_NombreComercialMedicamento  -- Condición para identificar el medicamento
      AND CodigoFarmacia = p_CodigoFarmacia; -- Condición para identificar la farmacia
END;
$$ LANGUAGE plpgsql;

-- Función para eliminar un registro en "Vende" (eliminación)

CREATE OR REPLACE FUNCTION eliminar_vende(
    p_NombreComercialMedicamento Vende.NombreComercialMedicamento%TYPE, -- Nombre comercial del medicamento
    p_CodigoFarmacia Vende.CodigoFarmacia%TYPE                         -- Código de la farmacia que vende el medicamento
)
RETURNS VOID AS $$
BEGIN
    -- Eliminamos el registro que coincide con el nombre comercial y la farmacia
    DELETE FROM Vende
    WHERE NombreComercialMedicamento = p_NombreComercialMedicamento  -- Condición para identificar el medicamento
      AND CodigoFarmacia = p_CodigoFarmacia; -- Condición para identificar la farmacia
END;
$$ LANGUAGE plpgsql;

-- Función para seleccionar un registro en "Vende" (selección)

CREATE OR REPLACE FUNCTION seleccionar_vende(
    p_NombreComercialMedicamento Vende.NombreComercialMedicamento%TYPE, -- Nombre comercial del medicamento
    p_CodigoFarmacia Vende.CodigoFarmacia%TYPE                         -- Código de la farmacia que vende el medicamento
)
RETURNS TABLE (
    NombreComercialMedicamento Vende.NombreComercialMedicamento%TYPE,  -- Nombre comercial del medicamento
    CodigoFarmacia Vende.CodigoFarmacia%TYPE,                          -- Código de la farmacia
    Precio Vende.Precio%TYPE                                           -- Precio del medicamento
) AS $$
BEGIN
    -- Retornamos el registro que coincide con el nombre comercial y la farmacia
    RETURN QUERY
    SELECT
        v.NombreComercialMedicamento, -- Nombre comercial del medicamento
        v.CodigoFarmacia,             -- Código de la farmacia
        v.Precio                      -- Precio del medicamento
    FROM Vende v
    WHERE v.NombreComercialMedicamento = p_NombreComercialMedicamento  -- Condición para seleccionar el medicamento
      AND v.CodigoFarmacia = p_CodigoFarmacia; -- Condición para seleccionar la farmacia
END;
$$ LANGUAGE plpgsql;


-- MEDICO DE CABECERA ¿?

-- TRES MODIFICACIONES ELEGIDAS GRUPALMENTE

-- 1. OSTENTA

-- Función para insertar un registro en "Ostenta" (inserción)

CREATE OR REPLACE FUNCTION insertar_ostenta(
    p_CodigoEspecialidad Ostenta.CodigoEspecialidad%TYPE, -- Código de la especialidad del médico
    p_RutMedico Ostenta.RutMedico%TYPE                    -- RUT del médico
)
RETURNS VOID AS $$
BEGIN
    -- Insertamos un nuevo registro en la tabla Ostenta
    INSERT INTO Ostenta (CodigoEspecialidad, RutMedico)
    VALUES (p_CodigoEspecialidad, p_RutMedico);
END;
$$ LANGUAGE plpgsql;

-- Función para modificar un registro en "Ostenta" (modificación)

-- NOTA: En este caso, la modificación es poco común ya que ambos campos forman la clave primaria.
-- Sin embargo, modificamos la especialidad de un médico usando el RUT.
CREATE OR REPLACE FUNCTION modificar_ostenta(
    p_CodigoEspecialidad Ostenta.CodigoEspecialidad%TYPE, -- Nuevo código de la especialidad
    p_RutMedico Ostenta.RutMedico%TYPE                    -- RUT del médico a modificar
)
RETURNS VOID AS $$
BEGIN
    -- Actualizamos el código de la especialidad de un médico identificado por su RUT
    UPDATE Ostenta
    SET CodigoEspecialidad = p_CodigoEspecialidad        -- Actualizamos la especialidad del médico
    WHERE RutMedico = p_RutMedico;                       -- Condición para identificar al médico
END;
$$ LANGUAGE plpgsql;

-- Función para eliminar un registro en "Ostenta" (eliminación)

CREATE OR REPLACE FUNCTION eliminar_ostenta(
    p_CodigoEspecialidad Ostenta.CodigoEspecialidad%TYPE, -- Código de la especialidad
    p_RutMedico Ostenta.RutMedico%TYPE                    -- RUT del médico
)
RETURNS VOID AS $$
BEGIN
    -- Eliminamos el registro que coincide con el código de especialidad y el RUT del médico
    DELETE FROM Ostenta
    WHERE CodigoEspecialidad = p_CodigoEspecialidad      -- Condición para identificar la especialidad
      AND RutMedico = p_RutMedico;                       -- Condición para identificar al médico
END;
$$ LANGUAGE plpgsql;

-- Función para seleccionar un registro en "Ostenta" (selección)

CREATE OR REPLACE FUNCTION seleccionar_ostenta(
    p_CodigoEspecialidad Ostenta.CodigoEspecialidad%TYPE, -- Código de la especialidad
    p_RutMedico Ostenta.RutMedico%TYPE                    -- RUT del médico
)
RETURNS TABLE (
    CodigoEspecialidad Ostenta.CodigoEspecialidad%TYPE,  -- Código de la especialidad
    RutMedico Ostenta.RutMedico%TYPE                     -- RUT del médico
) AS $$
BEGIN
    -- Retornamos el registro que coincide con la especialidad y el RUT del médico
    RETURN QUERY
    SELECT
        o.CodigoEspecialidad,  -- Código de la especialidad
        o.RutMedico            -- RUT del médico
    FROM Ostenta o
    WHERE o.CodigoEspecialidad = p_CodigoEspecialidad    -- Condición para seleccionar la especialidad
      AND o.RutMedico = p_RutMedico;                     -- Condición para seleccionar al médico
END;
$$ LANGUAGE plpgsql;

-- 2. CONTIENE

-- Función para insertar un registro en "Contiene" (inserción)

CREATE OR REPLACE FUNCTION insertar_contiene(
    p_CodigoRecetaMedica Contiene.CodigoRecetaMedica%TYPE,   -- Código de la receta médica
    p_NombreComercialMedicamento Contiene.NombreComercialMedicamento%TYPE, -- Nombre comercial del medicamento
    p_Cantidad Contiene.Cantidad%TYPE                        -- Cantidad del medicamento en la receta
)
RETURNS VOID AS $$
BEGIN
    -- Insertamos un nuevo registro en la tabla Contiene
    INSERT INTO Contiene (CodigoRecetaMedica, NombreComercialMedicamento, Cantidad)
    VALUES (p_CodigoRecetaMedica, p_NombreComercialMedicamento, p_Cantidad);
END;
$$ LANGUAGE plpgsql;

-- Función para modificar un registro existente en "Contiene" (modificación)

CREATE OR REPLACE FUNCTION modificar_contiene(
    p_CodigoRecetaMedica Contiene.CodigoRecetaMedica%TYPE,   -- Código de la receta médica
    p_NombreComercialMedicamento Contiene.NombreComercialMedicamento%TYPE, -- Nombre comercial del medicamento
    p_Cantidad Contiene.Cantidad%TYPE                        -- Nueva cantidad de medicamento
)
RETURNS VOID AS $$
BEGIN
    -- Actualizamos la cantidad de medicamento de una receta específica
    UPDATE Contiene
    SET Cantidad = p_Cantidad                               -- Actualizamos la cantidad de medicamento
    WHERE CodigoRecetaMedica = p_CodigoRecetaMedica         -- Condición para seleccionar la receta
      AND NombreComercialMedicamento = p_NombreComercialMedicamento; -- Condición para seleccionar el medicamento
END;
$$ LANGUAGE plpgsql;

-- Función para eliminar un registro en "Contiene" (eliminación)

CREATE OR REPLACE FUNCTION eliminar_contiene(
    p_CodigoRecetaMedica Contiene.CodigoRecetaMedica%TYPE,   -- Código de la receta médica
    p_NombreComercialMedicamento Contiene.NombreComercialMedicamento%TYPE -- Nombre comercial del medicamento
)
RETURNS VOID AS $$
BEGIN
    -- Eliminamos el registro que coincide con el código de la receta y el nombre del medicamento
    DELETE FROM Contiene
    WHERE CodigoRecetaMedica = p_CodigoRecetaMedica          -- Condición para seleccionar la receta
      AND NombreComercialMedicamento = p_NombreComercialMedicamento; -- Condición para seleccionar el medicamento
END;
$$ LANGUAGE plpgsql;

-- Función para seleccionar un registro en "Contiene" (selección)

CREATE OR REPLACE FUNCTION seleccionar_contiene(
    p_CodigoRecetaMedica Contiene.CodigoRecetaMedica%TYPE,   -- Código de la receta médica
    p_NombreComercialMedicamento Contiene.NombreComercialMedicamento%TYPE -- Nombre comercial del medicamento
)
RETURNS TABLE (
    CodigoRecetaMedica Contiene.CodigoRecetaMedica%TYPE,     -- Código de la receta médica
    NombreComercialMedicamento Contiene.NombreComercialMedicamento%TYPE, -- Nombre comercial del medicamento
    Cantidad Contiene.Cantidad%TYPE                          -- Cantidad de medicamento en la receta
) AS $$
BEGIN
    -- Retornamos el registro que coincide con el código de la receta y el medicamento
    RETURN QUERY
    SELECT
        c.CodigoRecetaMedica,           -- Código de la receta médica
        c.NombreComercialMedicamento,    -- Nombre comercial del medicamento
        c.Cantidad                      -- Cantidad de medicamento en la receta
    FROM Contiene c
    WHERE c.CodigoRecetaMedica = p_CodigoRecetaMedica       -- Condición para seleccionar la receta
      AND c.NombreComercialMedicamento = p_NombreComercialMedicamento; -- Condición para seleccionar el medicamento
END;
$$ LANGUAGE plpgsql;

-- 3. ADQUIERE

-- Función para insertar un nuevo registro en "Adquiere" (inserción)

CREATE OR REPLACE FUNCTION insertar_adquiere(
    p_RutPaciente Adquiere.RutPaciente%TYPE,                         -- RUT del paciente que adquiere el medicamento
    p_NombreComercialMedicamento Adquiere.NombreComercialMedicamento%TYPE -- Nombre comercial del medicamento adquirido
)
RETURNS VOID AS $$
BEGIN
    -- Insertamos un nuevo registro en la tabla Adquiere
    INSERT INTO Adquiere (RutPaciente, NombreComercialMedicamento)
    VALUES (p_RutPaciente, p_NombreComercialMedicamento);            -- Insertamos el paciente y el medicamento adquirido
END;
$$ LANGUAGE plpgsql;

-- Función para modificar un registro "Adquiere" (modificación)

CREATE OR REPLACE FUNCTION modificar_adquiere(
    p_RutPaciente Adquiere.RutPaciente%TYPE,                         -- RUT del paciente
    p_NombreComercialMedicamento Adquiere.NombreComercialMedicamento%TYPE, -- Nombre comercial del medicamento
    p_NuevoNombreComercialMedicamento Adquiere.NombreComercialMedicamento%TYPE -- Nuevo nombre comercial del medicamento
)
RETURNS VOID AS $$
BEGIN
    -- Actualizamos el medicamento adquirido por el paciente
    UPDATE Adquiere
    SET NombreComercialMedicamento = p_NuevoNombreComercialMedicamento -- Modificamos el nombre comercial del medicamento
    WHERE RutPaciente = p_RutPaciente                                  -- Condición para seleccionar el paciente
      AND NombreComercialMedicamento = p_NombreComercialMedicamento;   -- Condición para seleccionar el medicamento actual
END;
$$ LANGUAGE plpgsql;

-- Función para eliminar un registro en "Adquiere" (eliminación)

CREATE OR REPLACE FUNCTION eliminar_adquiere(
    p_RutPaciente Adquiere.RutPaciente%TYPE,                         -- RUT del paciente
    p_NombreComercialMedicamento Adquiere.NombreComercialMedicamento%TYPE -- Nombre comercial del medicamento
)
RETURNS VOID AS $$
BEGIN
    -- Eliminamos el registro que coincide con el paciente y el medicamento adquirido
    DELETE FROM Adquiere
    WHERE RutPaciente = p_RutPaciente                                -- Condición para seleccionar el paciente
      AND NombreComercialMedicamento = p_NombreComercialMedicamento;  -- Condición para seleccionar el medicamento adquirido
END;
$$ LANGUAGE plpgsql;

-- Función para seleccionar un registro en "Adquiere" (selección)

CREATE OR REPLACE FUNCTION seleccionar_adquiere(
    p_RutPaciente Adquiere.RutPaciente%TYPE,                         -- RUT del paciente
    p_NombreComercialMedicamento Adquiere.NombreComercialMedicamento%TYPE -- Nombre comercial del medicamento adquirido
)
RETURNS TABLE (
    RutPaciente Adquiere.RutPaciente%TYPE,                           -- RUT del paciente
    NombreComercialMedicamento Adquiere.NombreComercialMedicamento%TYPE -- Nombre comercial del medicamento adquirido
) AS $$
BEGIN
    -- Retornamos el registro que coincide con el paciente y el medicamento adquirido
    RETURN QUERY
    SELECT
        a.RutPaciente,                    -- RUT del paciente
        a.NombreComercialMedicamento      -- Nombre comercial del medicamento adquirido
    FROM Adquiere a
    WHERE a.RutPaciente = p_RutPaciente   -- Condición para seleccionar el paciente
      AND a.NombreComercialMedicamento = p_NombreComercialMedicamento; -- Condición para seleccionar el medicamento adquirido
END;
$$ LANGUAGE plpgsql;

