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






