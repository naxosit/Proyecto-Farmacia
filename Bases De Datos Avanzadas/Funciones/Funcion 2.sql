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
 
-- Ejemplo de uso

-- EJEMPLO DE PonerOferta con fecha pasada (testeo realizado el 2024-09-06)
-- SELECT PonerOferta('Zentech', 'FARMA001', 3000, '2024-09-01', '2024-09-05'); 

SELECT RevertirOferta('Zentech', 'FARMA001'); -- NOTA: ES IMPORTANTE TESTEAR CON UNA FECHA QUE YA HAYA CADUCADO (COMENTARIOS ANTERIORES)

SELECT * FROM Oferta;