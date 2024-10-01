--F1

-- Elaborar una función que permita poner productos en oferta por un tiempo limitado.

-- Primero debemos crear la tabla Oferta para almacenar las ofertas de los medicamentos

CREATE TABLE Oferta(
	NombreComercialMedicamento VARCHAR(10),
	CodigoFarmacia VARCHAR(10),
	Precio INTEGER,
	FechaInicio DATE,
	FechaFin DATE,
	PRIMARY KEY (NombreComercialMedicamento,
CodigoFarmacia),
	FOREIGN KEY (NombreComercialMedicamento)
REFERENCES Medicamento (NombreComercial),
	FOREIGN KEY (CodigoFarmacia) REFERENCES
Farmacias (Codigo)
);

-- Una vez teniendo esta tabla, podemos crear la función para poner medicamentos en
-- oferta

CREATE OR REPLACE FUNCTION PonerOferta(
	p_nombre_comercial VARCHAR(10),
    p_codigo_farmacia VARCHAR(10),
    p_precio_oferta INTEGER,
    p_fecha_inicio DATE,
    p_fecha_fin DATE
)
RETURNS VOID AS $$
BEGIN
	-- Debemos verificar si el medicamento existe
	IF NOT EXISTS (SELECT 1 FROM Medicamento WHERE 
NombreComercial = p_nombre_comercial) THEN
	RAISE EXCEPTION 'El medicamento % no 
existe', p_nombre_comercial;
	END IF;
	
	-- Debemos verificar si la farmacia existe
	IF NOT EXISTS (SELECT 1 FROM Farmacias WHERE Codigo = p_codigo_farmacia) THEN
        RAISE EXCEPTION 'La farmacia % no existe', p_codigo_farmacia;
    END IF;

    -- Actualizar el precio en la tabla Vende
    UPDATE Vende
    SET Precio = p_precio_oferta
    WHERE NombreComercialMedicamento = p_nombre_comercial
      AND CodigoFarmacia = p_codigo_farmacia;

    -- Insertar la oferta en la tabla Oferta
    INSERT INTO Oferta (NombreComercialMedicamento, CodigoFarmacia, Precio, FechaInicio, FechaFin)
    VALUES (p_nombre_comercial, p_codigo_farmacia, p_precio_oferta, p_fecha_inicio, p_fecha_fin)
    ON CONFLICT (NombreComercialMedicamento, CodigoFarmacia)
    DO UPDATE SET Precio = p_precio_oferta, FechaInicio = p_fecha_inicio, FechaFin = p_fecha_fin;
END;
$$
 LANGUAGE plpgsql;


--F2


-- Elaborar una función que permita revertir la oferta si el tiempo ha terminado

-- Haremos uso de la tabla Oferta que creamos anteriormente en la elaboración de
-- la Función 1

CREATE OR REPLACE FUNCTION RevertirOferta (
	p_nombre_comercial VARCHAR(10),
	p_codigo_farmacia VARCHAR(10)
)
RETURNS VOID AS $$
DECLARE 
	v_precio_original INTEGER;
BEGIN 
	
	-- Debemos verificar si la oferta existe y si la fecha de fin ha pasado
	SELECT Precio INTO v_precio_original
	FROM Oferta
	WHERE NombreComercialMedicamento = p_nombre_comercial
		AND CodigoFarmacia = p_codigo_farmacia
		AND FechaFin < CURRENT_DATE;

	-- Si se encontró una oferta, revertir el precio  en la tabla Vende
	IF FOUND THEN
		UPDATE VENDE
		SET PRECIO = v_precio_original 
		WHERE NombreComercialMedicamento = p_nombre_comercial
			AND CodigoFarmacia = p_codigo_farmacia;
		
		-- Luego debemos eliminar la oferta de la tabla Oferta
		DELETE FROM Oferta 
		WHERE NombreComercialMedicamento = p_nombre_comercial
			AND CodigoFarmacia = p_codigo_farmacia;
	END IF;
END; 
$$ 
 LANGUAGE plpgsql;
 

--F3


-- Q1


CREATE OR REPLACE FUNCTION obtener_detalle_recetas()
RETURNS TABLE (
    nombre_farmacia FARMACIAS.nombre%TYPE,
    medicamento Vende.nombrecomercialmedicamento%TYPE,
    rut_paciente PACIENTE.rut%TYPE,
    nombre_paciente PACIENTE.nombre%TYPE,
    rut_medico MEDICOS.rut%TYPE,
    nombre_medico MEDICOS.nombre%TYPE,
    fecha_emision RECETA.fechaemision%TYPE,
    precio Vende.precio%TYPE
) AS $$
BEGIN
    RETURN QUERY
    SELECT DISTINCT
        f.nombre AS nombre_farmacia,
        v.nombrecomercialmedicamento AS medicamento,
        p.rut AS rut_paciente,
        p.nombre AS nombre_paciente,
        p.rutmedico,
        m.nombre AS nombre_medico,
        r.fechaemision,
        v.precio
    FROM
        paciente p
        JOIN medicos m ON p.rutmedico = m.rut
        JOIN receta r ON r.rutmedico = m.rut
        JOIN contiene c ON r.codigorecetamedica = c.codigorecetamedica
        JOIN vende v ON v.nombrecomercialmedicamento = c.nombrecomercialmedicamento
        JOIN farmacias f ON f.codigo = v.codigofarmacia
    ORDER BY
        nombre_farmacia, medicamento;
END;
$$ LANGUAGE plpgsql;


-- Q2


CREATE OR REPLACE FUNCTION obtener_atenciones_paciente()
RETURNS TABLE (
    rut_paciente paciente.rut%TYPE,
    nombre_paciente paciente.nombre%TYPE,
    especialidad especialidad.nombre%TYPE,
    atenciones BIGINT 
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        p.rut AS rut_paciente,
        p.nombre AS nombre_paciente,
        e.nombre AS especialidad,
        COUNT(*) AS atenciones
    FROM
        paciente p
        JOIN medicos m ON p.rutmedico = m.rut
        JOIN ostenta o ON m.rut = o.rutmedico
        JOIN especialidad e ON e.codigo = o.codigoespecialidad
    GROUP BY
        p.rut, e.nombre
    ORDER BY
        p.rut, p.nombre, e.nombre;
END;
$$ LANGUAGE plpgsql;


--Q3


CREATE OR REPLACE FUNCTION farmacias_sin_contrato_vigente()
RETURNS TABLE (
    codigo FARMACIAS.codigo%TYPE,
    nombre FARMACIAS.nombre%TYPE,
    direccion FARMACIAS.direccion%TYPE,
    telefono Telfar.CODIGOTELEFONO%TYPE
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        f.codigo,
        f.nombre,
        f.direccion,
        t.CODIGOTELEFONO
    FROM 
        FARMACIAS f
        JOIN telfar t ON f.codigo = t.codigofarmacia
        JOIN abarca a ON a.codigofarmacia = f.codigo
        JOIN empresafarmaceutica e ON e.codigo = a.codigoempresafarmaceutica
        LEFT JOIN contrato c ON c.codigo = a.codigocontrato
    WHERE c.fechatermino IS NULL OR c.fechatermino < NOW();
END;
$$ LANGUAGE plpgsql;


--Q4


CREATE OR REPLACE FUNCTION participaciones_supervisor()
RETURNS TABLE (
    nombre_supervisor supervisor.nombre%TYPE,
    apellido_supervisor supervisor.apellido%TYPE,
    farmacia FARMACIAS.nombre%TYPE,
    empresa EMPRESAFARMACEUTICA.nombre%TYPE,
    participaciones BIGINT 
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        s.nombre,
        s.apellido,
        f.nombre AS farmacia,
        t.nombre AS empresa,
        COUNT(*) AS participaciones
    FROM
        supervisor s
        JOIN farmacias f ON f.codigo = s.codigofarmacia
        JOIN abarca a ON f.codigo = a.codigofarmacia
        JOIN empresafarmaceutica t ON t.codigo = a.codigoempresafarmaceutica
    GROUP BY 
        s.nombre, s.apellido, f.nombre, t.nombre
    ORDER BY 
        s.nombre, s.apellido;
END;
$$ LANGUAGE plpgsql;


-- Q5


CREATE OR REPLACE FUNCTION medicamentos_recetados_mas_de_10_veces()
RETURNS TABLE (
    empresa_nombre EmpresaFarmaceutica.nombre%TYPE,
    medicamento_nombre Medicamento.nombrecomercial%TYPE,
    cantidad_recetas BIGINT 	
) AS $$
BEGIN
    RETURN QUERY
    SELECT
        e.nombre AS empresa_nombre,
        m.nombrecomercial AS medicamento_nombre,
        COUNT(c.codigorecetamedica) AS cantidad_recetas
    FROM
        EmpresaFarmaceutica e
        JOIN Produce p ON p.CodigoEmpresaFarmaceutica = e.Codigo
        JOIN Medicamento m ON m.NombreComercial = p.NombreComercialMedicamento
        JOIN contiene c ON m.nombrecomercial = c.nombrecomercialmedicamento
    GROUP BY 
        m.nombrecomercial, e.nombre
    HAVING 
        COUNT(c.codigorecetamedica) > 10;
END;
$$ LANGUAGE plpgsql;

DROP FUNCTION medicamentos_recetados_mas_de_10_veces()


-- V1


CREATE OR REPLACE FUNCTION vista_mes_sin_recetar()
RETURNS TABLE (
    rut MEDICOS.rut%TYPE,
    nombre MEDICOS.nombre%TYPE,
    apellido MEDICOS.apellido%TYPE
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        m.rut,
        m.nombre,
        m.apellido
    FROM 
        medicos m
        LEFT JOIN receta r ON r.rutmedico = m.rut
    WHERE 
        r.fechaemision IS NULL OR NOT (CURRENT_DATE - INTERVAL '1 month') < r.fechaemision;
END;
$$ LANGUAGE plpgsql;


-- V2

CREATE OR REPLACE FUNCTION obtener_total_recetas() 
RETURNS TABLE (
    rut MEDICOS.rut%TYPE,
    nombre MEDICOS.nombre%TYPE,
    apellido MEDICOS.apellido%TYPE,
    anio INTEGER,
    total_recetas BIGINT
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        m.rut,
        m.nombre,
        m.apellido,
        EXTRACT(YEAR FROM r.fechaemision)::INTEGER AS anio, -- Extraemos únicamente el año de la fecha de emisión
        COUNT(*) AS total_recetas
    FROM 
        medicos m
    JOIN receta r ON r.rutmedico = m.rut
    GROUP BY 
        EXTRACT(YEAR FROM r.fechaemision), 
        m.rut, 
        m.nombre, 
        m.apellido
    ORDER BY 
        anio;
END;
$$ LANGUAGE plpgsql;


-- V3


CREATE OR REPLACE FUNCTION obtener_info_recetas() 
RETURNS TABLE (
    nombre_paciente PACIENTE.nombre%TYPE,
    apellido_paciente PACIENTE.apellido%TYPE,
    nombre_medico MEDICOS.nombre%TYPE,
    apellido_medico MEDICOS.apellido%TYPE,
    anio INTEGER,
    total_recetas BIGINT
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        p.nombre AS nombre_paciente,
        p.apellido AS apellido_paciente,
        m.nombre AS nombre_medico,
        m.apellido AS apellido_medico,
        EXTRACT(YEAR FROM r.fechaemision)::INTEGER AS anio, -- Extraemos únicamente el año de la fecha de emisión
        COUNT(*) AS total_recetas
    FROM 
        paciente p 
    JOIN receta r ON r.rutpaciente = p.rut
    JOIN medicos m ON m.rut = r.rutmedico
    GROUP BY 
        p.nombre, 
        p.apellido, 
        m.nombre, 
        m.apellido, 
        EXTRACT(YEAR FROM r.fechaemision)
    ORDER BY 
        nombre_paciente, 
        apellido_paciente, 
        nombre_medico, 
        apellido_medico, 
        anio;
END;
$$ LANGUAGE plpgsql;


--F4


-- Para ejecutar funciones de modificación/eliminar/selección, usaremos la tabla Medicos como ejemplo

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
