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
