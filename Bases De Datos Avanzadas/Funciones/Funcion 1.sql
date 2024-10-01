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

-- Ejemplo de uso

SELECT PonerOferta('Zentech', 'FARMA001', 3000, '2024-09-01', '2024-09-05');

SELECT * FROM Oferta;
SELECT * FROM Vende;