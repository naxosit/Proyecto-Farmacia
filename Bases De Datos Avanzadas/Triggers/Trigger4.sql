-- Crear la función que aplicará el precio de la oferta si existe alguna vigente
-- Se usará la tabla de la función 1 de la entrega anterior (tabla Oferta)
CREATE OR REPLACE FUNCTION AplicarPrecioOferta()
RETURNS TRIGGER AS $$
BEGIN
    -- Verificar si existe una oferta vigente para el producto y la farmacia
    IF EXISTS (
        SELECT 1
        FROM Oferta
        WHERE NombreComercialMedicamento = NEW.NombreComercialMedicamento
        AND CodigoFarmacia = NEW.CodigoFarmacia
        AND CURRENT_DATE BETWEEN FechaInicio AND FechaFin
    ) THEN
        -- Si existe una oferta vigente, actualizar el precio del producto
        SELECT Precio
        INTO NEW.Precio
        FROM Oferta
        WHERE NombreComercialMedicamento = NEW.NombreComercialMedicamento
        AND CodigoFarmacia = NEW.CodigoFarmacia
        AND CURRENT_DATE BETWEEN FechaInicio AND FechaFin;
    END IF;
    
    -- Retornar el nuevo valor (actualizado o no) para continuar con la operación
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Crear el trigger que aplicará la función antes de cada operación de INSERT o UPDATE en la tabla Vende
CREATE TRIGGER TriggerAplicarPrecioOferta
BEFORE INSERT OR UPDATE ON Vende
FOR EACH ROW
EXECUTE FUNCTION AplicarPrecioOferta();


-- Ejemplificación

-- Insertaremos una oferta en la tabla Oferta
INSERT INTO Oferta (NombreComercialMedicamento, CodigoFarmacia, Precio, FechaInicio, FechaFin)
VALUES ('Zentech', 'FARMA001', 3000, '2024-10-20', '2024-10-25');

-- En caso de tener error al insertar valores por violación de claves primarias
UPDATE Oferta
SET Precio = 3000, FechaInicio = '2024-10-20', FechaFin = '2024-10-25'
WHERE NombreComercialMedicamento = 'Zentech' AND CodigoFarmacia = 'FARMA001';

-- Insertamos un producto en la tabla Vende
INSERT INTO Vende (NombreComercialMedicamento, CodigoFarmacia, Precio)
VALUES ('Zentech', 'FARMA001', 5000);

-- En caso de tener error al insertar valores por violación de claves primarias
UPDATE Vende
SET Precio = 5000
WHERE NombreComercialMedicamento = 'Zentech' AND CodigoFarmacia = 'FARMA001';

SELECT * FROM Vende WHERE NombreComercialMedicamento = 'Zentech' AND CodigoFarmacia = 'FARMA001';

