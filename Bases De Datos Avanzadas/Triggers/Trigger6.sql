-- Crear la función que actualizará el stock después de cada venta
CREATE OR REPLACE FUNCTION ActualizarStockDespuésDeVenta()
RETURNS TRIGGER AS $$
BEGIN
    -- Reducir el stock en la tabla Medicamento después de una venta
    UPDATE Medicamento
    SET Stock = Stock - NEW.Cantidad  -- Suponiendo que 'Cantidad' es el número de unidades vendidas
    WHERE NombreComercial = NEW.NombreComercialMedicamento;  -- Actualizar solo el medicamento correspondiente

    -- Retornar el nuevo registro de venta
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Crear el trigger que actualiza el stock después de cada venta en la tabla Vende
CREATE TRIGGER TriggerActualizarStockDespuésDeVenta
AFTER INSERT ON Vende
FOR EACH ROW
EXECUTE FUNCTION ActualizarStockDespuésDeVenta();

-- Como mi tabla Vende no tiene una columna de cantidad, se la añadiré
ALTER TABLE Vende
ADD COLUMN Cantidad INTEGER NOT NULL DEFAULT 1; 

-- A mi tabla Medicamento también le añadiré una columna de stock
ALTER TABLE Medicamento
ADD COLUMN Stock INTEGER NOT NULL DEFAULT 0;  -- Ajusta el valor predeterminado según sea necesario

-- Primera venta de 2 unidades
INSERT INTO Vende (NombreComercialMedicamento, CodigoFarmacia, Precio, Cantidad)
VALUES ('Zentech', 'FARMA001', 3000, 2)
ON CONFLICT (NombreComercialMedicamento, CodigoFarmacia) 
DO UPDATE SET Cantidad = Vende.Cantidad + EXCLUDED.Cantidad;

-- Segunda venta de 3 unidades, lo que debería sumar 5 unidades en total
INSERT INTO Vende (NombreComercialMedicamento, CodigoFarmacia, Precio, Cantidad)
VALUES ('Zentech', 'FARMA001', 3000, 3)
ON CONFLICT (NombreComercialMedicamento, CodigoFarmacia) 
DO UPDATE SET Cantidad = Vende.Cantidad + EXCLUDED.Cantidad;

-- Verificar las ventas registradas
SELECT * FROM Vende;

SELECT * FROM Medicamento;





