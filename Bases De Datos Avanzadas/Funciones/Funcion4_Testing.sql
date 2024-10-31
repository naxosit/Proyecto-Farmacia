-- Revisión de la tabla PACIENTES

-- Insertar un nuevo paciente
SELECT insertar_paciente(
    '12345678-9',       -- Rut
    'Juan',             -- Nombre
    'Perez',            -- Apellido
    '1985-05-15',       -- FechaNacimiento
    'Calle Falsa 123',  -- Dirección
    'Santiago',         -- Ciudad
    'juan.perez@email.com', -- Correo
    '39.972.694',       -- RutMedico (IMPORTANTE: DEBE SER UN RUT MÉDICO EXISTENTE EN LA TABLA DE MÉDICOS)
    '2024-01-01',       -- FechaInicio
    NULL                -- FechaFin
);

-- Verificar la inserción

SELECT *  FROM Paciente WHERE Rut = '12345678-9';

-- Modificar el paciente

-- Modificar los datos del paciente
SELECT modificar_paciente(
    '12345678-9',       -- Rut
    'Juan Carlos',      -- Nombre modificado
    'Perez Gomez',      -- Apellido modificado
    '1985-05-15',       -- FechaNacimiento
    'Avenida Siempre Viva 456', -- Dirección modificada
    'Santiago',         -- Ciudad
    'juan.c.perez@email.com', -- Correo modificado
    '39.972.694',       -- RutMedico
    '2024-01-01',       -- FechaInicio
    NULL                -- FechaFin
);

-- Verificar la modificación
SELECT * FROM Paciente WHERE Rut = '12345678-9';

-- Eliminar el paciente
SELECT eliminar_paciente('12345678-9');

-- Verificar la eliminación
SELECT * FROM Paciente WHERE Rut = '12345678-9';

-- Insertar un paciente nuevamente para el ejemplo de selección
SELECT insertar_paciente(
    '12345678-9', 
    'Juan Carlos', 
    'Perez Gomez', 
    '1985-05-15', 
    'Avenida Siempre Viva 456', 
    'Santiago', 
    'juan.c.perez@email.com', 
    '39.972.694', 
    '2024-01-01', 
    NULL
);

-- Seleccionar el paciente
SELECT * FROM seleccionar_paciente('12345678-9');

-- MEDICO DE CABECERA

-- Insertar un médico de cabecera para un paciente
SELECT insertar_medico_cabecera('12345678-9', '39.972.694', '2024-01-01', '2024-12-31');

-- Verificar el resultado
SELECT * FROM Paciente WHERE Rut = '12345678-9';

-- Modificar el médico de cabecera de un paciente
SELECT modificar_medico_cabecera('12345678-9', '38.201.817', '2024-02-01', '2024-11-30');

-- Verificar el resultado
SELECT * FROM Paciente WHERE Rut = '12345678-9';

-- Eliminar el médico de cabecera de un paciente
SELECT eliminar_medico_cabecera('12345678-9');

-- Verificar el resultado
SELECT * FROM Paciente WHERE Rut = '12345678-9';

-- Seleccionar el médico de cabecera de un paciente
SELECT * FROM seleccionar_medico_cabecera('12345678-9');
