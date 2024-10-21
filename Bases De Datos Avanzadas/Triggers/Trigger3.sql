-- Crear la tabla Compras
CREATE TABLE Compras (
    ID SERIAL PRIMARY KEY,  -- Definir ID como columna de tipo SERIAL que actúa como clave primaria
    CodigoFarmacia VARCHAR(10),  -- Columna para almacenar el código de la farmacia, hasta 10 caracteres
    CodigoEmpresaFarmaceutica VARCHAR(10),  -- Columna para almacenar el código de la empresa farmacéutica, hasta 10 caracteres
    Fecha DATE,  -- Columna para almacenar la fecha de la compra
    Precio INTEGER  -- Columna para almacenar el precio de la compra
);

-- Crear o reemplazar la función aplicar_descuento
CREATE OR REPLACE FUNCTION aplicar_descuento() 
RETURNS TRIGGER AS $$  -- Indicar que esta función es un trigger y devolverá un nuevo registro
DECLARE
    compras_count INTEGER;  -- Variable para contar el número de compras
    descuento INTEGER;  -- Variable para almacenar el porcentaje de descuento
BEGIN
    -- Contar las compras de la farmacia en el mes actual de la misma empresa
    SELECT COUNT(*) INTO compras_count
    FROM Compras
    WHERE CodigoFarmacia = NEW.CodigoFarmacia  -- Filtrar por la misma farmacia
      AND CodigoEmpresaFarmaceutica = NEW.CodigoEmpresaFarmaceutica  -- Filtrar por la misma empresa farmacéutica
      AND DATE_TRUNC('month', Fecha) = DATE_TRUNC('month', NEW.Fecha)  -- Comparar las fechas truncadas al mes
      AND Fecha < NEW.Fecha;  -- Solo contar compras anteriores a la compra actual

    -- Sumar 1 para incluir la compra actual en el conteo
    compras_count := compras_count + 1;

    -- Inicializar descuento
    descuento := 0;

    -- Determinar el descuento basado en el conteo de compras
    IF compras_count >= 4 THEN  -- Si hay 4 o más compras
        descuento := 10 + (compras_count - 4);  -- 10% base + 1% por cada compra adicional a partir de la 4ª
        -- Asegurarse de que el descuento no supere un límite razonable (por ejemplo, 50%)
        IF descuento > 50 THEN
            descuento := 50;  -- Limitar el descuento al 50%
        END IF;
        
        -- Aplicar el descuento al precio original
        NEW.Precio := NEW.Precio * (1 - descuento / 100.0);  -- Aplicar descuento al precio
    END IF;

    RETURN NEW;  -- Retornar el nuevo registro modificado
END;
$$
LANGUAGE plpgsql;  -- Definir el lenguaje de la función como PL/pgSQL

-- Crear o reemplazar el trigger que aplica el descuento
CREATE OR REPLACE TRIGGER trigger_aplicar_descuento
BEFORE INSERT ON Compras  -- Este trigger se ejecuta antes de cada inserción en la tabla Compras
FOR EACH ROW  -- Aplicar el trigger a cada fila
EXECUTE FUNCTION aplicar_descuento();  -- Llamar a la función aplicar_descuento

-- Limpiar la tabla Compras y reiniciar la secuencia
TRUNCATE TABLE Compras RESTART IDENTITY;  -- Eliminar todos los registros y reiniciar el contador de IDs

-- Insertar compras de prueba
INSERT INTO Compras (CodigoFarmacia, CodigoEmpresaFarmaceutica, Fecha, Precio) VALUES
('F001', 'E001', '2024-10-01', 1000),  -- Inserción 1: compra sin descuento
('F001', 'E001', '2024-10-05', 1000),  -- Inserción 2: compra sin descuento
('F001', 'E001', '2024-10-10', 1000),  -- Inserción 3: compra sin descuento
('F001', 'E001', '2024-10-15', 1000),  -- Inserción 4: se aplica 10% de descuento
('F001', 'E001', '2024-10-17', 1000),  -- Inserción 5: se aplica 11% de descuento
('F001', 'E001', '2024-10-20', 1000);  -- Inserción 6: se aplica 12% de descuento

-- Consultar y mostrar todas las filas de la tabla Compras
SELECT * FROM Compras;  

 




