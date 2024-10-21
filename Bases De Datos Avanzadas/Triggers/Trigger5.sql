-- Crear la función que verifica si hay una oferta vigente antes de permitir la inserción de una nueva oferta
CREATE OR REPLACE FUNCTION VerificarOfertaVigenteAntesDeInsertar()
RETURNS TRIGGER AS $$
BEGIN
    -- Verificar si ya hay una oferta activa para el mismo medicamento y farmacia
    IF EXISTS (
        SELECT 1
        FROM Oferta
        WHERE NombreComercialMedicamento = NEW.NombreComercialMedicamento
        AND CodigoFarmacia = NEW.CodigoFarmacia
        AND CURRENT_DATE < FechaFin  -- La oferta es vigente si la fecha actual es menor que FechaFin
    ) THEN
        -- Si existe una oferta vigente, lanzar una excepción
        RAISE EXCEPTION 'No se puede insertar una nueva oferta para el medicamento % en la farmacia % porque ya existe una oferta vigente.',
        NEW.NombreComercialMedicamento, NEW.CodigoFarmacia;
    END IF;
    
    -- Si no hay oferta vigente, permitir la inserción
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Crear el trigger que verifica la existencia de una oferta vigente antes de insertar una nueva en la tabla Oferta
CREATE TRIGGER TriggerVerificarOfertaVigenteAntesDeInsertar
BEFORE INSERT ON Oferta
FOR EACH ROW
EXECUTE FUNCTION VerificarOfertaVigenteAntesDeInsertar();

-- Ejemplificación de uso
INSERT INTO Oferta (NombreComercialMedicamento, CodigoFarmacia, Precio, FechaInicio, FechaFin)
VALUES ('Zentech', 'FARMA001', 2500, '2024-10-22', '2024-10-30');

-- Lo anterior lanzará un error de tipo: ERROR: No se puede insertar una nueva oferta para el medicamento Zentech en la farmacia 
-- FARMA001 porque ya existe una oferta vigente.
