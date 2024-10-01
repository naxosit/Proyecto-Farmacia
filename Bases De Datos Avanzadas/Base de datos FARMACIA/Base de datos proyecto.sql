CREATE TABLE Medicos (
	Rut VARCHAR(10) PRIMARY KEY,
	AniosServicio INTEGER,
	Nombre VARCHAR(30),
	Apellido VARCHAR(30),
	FechaNacimiento DATE,
	Direccion VARCHAR(20),
	Ciudad VARCHAR(20),
	Correo VARCHAR(100),
	check(FechaNacimiento <= now())
);

CREATE TABLE Telefono (
	Codigo VARCHAR(10) PRIMARY KEY
);

CREATE TABLE Especialidad (
	Codigo VARCHAR(10) PRIMARY KEY,
	Nombre VARCHAR(20)
);

CREATE TABLE RecetaMedica (
	Codigo VARCHAR(10) PRIMARY KEY,
	TextoDescripcion VARCHAR(300),
	Fecha DATE
);

CREATE TABLE Prevision (
	Codigo VARCHAR(10) PRIMARY KEY,
	Nombre VARCHAR(20),
	Tipo VARCHAR(10)
);
CREATE TABLE Contrato ( 
    Codigo VARCHAR(10) PRIMARY KEY, 
    FechaInicio DATE,
    FechaTermino DATE, 
    TextoContrato VARCHAR(500)
);

CREATE TABLE Farmacias (
    Codigo VARCHAR(10) PRIMARY KEY,
    Nombre VARCHAR(30),
    Direccion VARCHAR(30)
);

CREATE TABLE EmpresaFarmaceutica (
    Codigo VARCHAR(10) PRIMARY KEY,
    Nombre VARCHAR(20)
);

CREATE TABLE Medicamento (
    NombreComercial VARCHAR(10) PRIMARY KEY,
    Formula VARCHAR(30)
);




CREATE TABLE Paciente (
	Rut VARCHAR(10),
	Nombre VARCHAR(30),
	Apellido VARCHAR(30),
	FechaNacimiento DATE,
	Direccion VARCHAR(30),
	Ciudad VARCHAR(20),
	Correo VARCHAR(100),
	RutMedico VARCHAR(10),
	FechaInicio date,
	FechaFin date,
	check(FechaNacimiento <= now()),
	PRIMARY KEY (Rut),
	FOREIGN KEY (RutMedico) REFERENCES Medicos (Rut) on update cascade on delete cascade
);

CREATE TABLE Supervisor (
	Rut VARCHAR(10),
	Nombre VARCHAR(30),
	Apellido VARCHAR(30),
	FechaNacimiento DATE,
	Direccion VARCHAR(30),
	Ciudad VARCHAR(20),
	Correo VARCHAR(100),
	CodigoFarmacia VARCHAR(100),
	check(FechaNacimiento <= now()),
	PRIMARY KEY (Rut),
	FOREIGN KEY (CodigoFarmacia) REFERENCES Farmacias (Codigo) on update cascade on delete cascade
);



CREATE TABLE Nombra (
    CodigoContrato VARCHAR(10),
    RutSupervisor VARCHAR(10),
    CodigoFarmacia VARCHAR(10),
    FechaInicio DATE,
    FechaFin DATE,
    PRIMARY KEY (CodigoContrato, RutSupervisor, CodigoFarmacia),
    FOREIGN KEY (RutSupervisor) REFERENCES Supervisor (Rut) on update cascade on delete cascade,
    FOREIGN KEY (CodigoFarmacia) REFERENCES Farmacias (Codigo) on update cascade on delete cascade
);

CREATE TABLE Vende (
    NombreComercialMedicamento VARCHAR(10),
    CodigoFarmacia VARCHAR(10),
    Precio INTEGER,
    PRIMARY KEY (NombreComercialMedicamento, CodigoFarmacia),
    FOREIGN KEY (NombreComercialMedicamento) REFERENCES Medicamento (NombreComercial) on update cascade on delete cascade,
    FOREIGN KEY (CodigoFarmacia) REFERENCES Farmacias (Codigo) on update cascade on delete cascade
);

CREATE TABLE Contiene (
    CodigoRecetaMedica VARCHAR(10),
    NombreComercialMedicamento VARCHAR(20),
    Cantidad INTEGER,
    PRIMARY KEY (CodigoRecetaMedica, NombreComercialMedicamento),
    FOREIGN KEY (CodigoRecetaMedica) REFERENCES RecetaMedica (Codigo) on update cascade on delete cascade,
    FOREIGN KEY (NombreComercialMedicamento) REFERENCES Medicamento (NombreComercial) on update cascade on delete cascade
);

CREATE TABLE Supervisa (
    RutSupervisor VARCHAR(10),
    CodigoContrato VARCHAR(10),
    FechaInicio DATE,
    FechaTermino DATE,
    PRIMARY KEY (RutSupervisor, CodigoContrato),
    FOREIGN KEY (RutSupervisor) REFERENCES Supervisor (Rut) on update cascade on delete cascade,
    FOREIGN KEY (CodigoContrato) REFERENCES Contrato (Codigo) on update cascade on delete cascade
);

CREATE TABLE Receta (
    RutPaciente VARCHAR(10),
    RutMedico VARCHAR(10),
    CodigoRecetaMedica VARCHAR(10),
    FechaEmision DATE,
    PRIMARY KEY (RutPaciente, RutMedico, CodigoRecetaMedica),
    FOREIGN KEY (RutPaciente) REFERENCES Paciente( Rut) on update cascade on delete cascade,
    FOREIGN KEY (RutMedico) REFERENCES Medicos (Rut) on update cascade on delete cascade,
	FOREIGN KEY (CodigoRecetaMedica) REFERENCES RecetaMedica (Codigo) on update cascade on delete cascade
);



CREATE TABLE Ostenta(
	CodigoEspecialidad VARCHAR(10),
	RutMedico VARCHAR(10),
	FOREIGN KEY (CodigoEspecialidad) REFERENCES Especialidad (Codigo) on update cascade on delete cascade,
	FOREIGN KEY (RutMedico) REFERENCES Medicos (Rut) on update cascade on delete cascade,
	PRIMARY KEY(CodigoEspecialidad, RutMedico)
);

CREATE TABLE Tiene(
	RutPaciente VARCHAR(10),
	CodigoPrevision VARCHAR(10),
	FOREIGN KEY (RutPaciente) REFERENCES Paciente (Rut) on update cascade on delete cascade,
	FOREIGN KEY (CodigoPrevision) REFERENCES Prevision(Codigo) on update cascade on delete cascade,
	PRIMARY KEY(RutPaciente, CodigoPrevision)
);

CREATE TABLE Adquiere(
	RutPaciente VARCHAR(10),
	NombreComercialMedicamento VARCHAR(10),
	FOREIGN KEY (RutPaciente) REFERENCES Paciente(Rut) on update cascade on delete cascade,
	FOREIGN KEY (NombreComercialMedicamento) REFERENCES Medicamento (NombreComercial) on update cascade on delete cascade,
	PRIMARY KEY (RutPaciente, NombreComercialMedicamento)
);

CREATE TABLE TelMed(
	RutMedico VARCHAR(10),
	CodigoTelefono VARCHAR(10),
	FOREIGN KEY (RutMedico) REFERENCES Medicos (Rut) on update cascade on delete cascade,
	FOREIGN KEY (CodigoTelefono) REFERENCES Telefono (Codigo) on update cascade on delete cascade,
	PRIMARY KEY (RutMedico, CodigoTelefono)
);

CREATE TABLE TelPac(
	RutPaciente VARCHAR(10),
	CodigoTelefono VARCHAR(10),
	FOREIGN KEY (RutPaciente) REFERENCES Paciente (Rut) on update cascade on delete cascade,
	FOREIGN KEY (CodigoTelefono) REFERENCES Telefono (Codigo) on update cascade on delete cascade,
	PRIMARY KEY (RutPaciente, CodigoTelefono)
);

CREATE TABLE TelSup(
	RutSupervisor VARCHAR(10),
	CodigoTelefono VARCHAR(10),
	FOREIGN KEY (RutSupervisor) REFERENCES Supervisor (Rut) on update cascade on delete cascade,
	FOREIGN KEY (CodigoTelefono) REFERENCES Telefono (Codigo) on update cascade on delete cascade,
	PRIMARY KEY (RutSupervisor, CodigoTelefono)
);
	
CREATE TABLE TelEmpFar(
	CodigoTelefono VARCHAR(10),
	CodigoEmpresaFarmaceutica VARCHAR(10),
	FOREIGN KEY (CodigoTelefono) REFERENCES Telefono (Codigo) on update cascade on delete cascade,
	FOREIGN KEY (CodigoEmpresaFarmaceutica) REFERENCES EmpresaFarmaceutica (Codigo) on update cascade on delete cascade,
	PRIMARY KEY (CodigoTelefono, CodigoEmpresaFarmaceutica)
);
	
CREATE TABLE TelFar(
	CodigoFarmacia VARCHAR(10),
	CodigoTelefono VARCHAR(10),
	FOREIGN KEY (CodigoFarmacia) REFERENCES Farmacias (Codigo) on update cascade on delete cascade,
	FOREIGN KEY (CodigoTelefono) REFERENCES Telefono (Codigo) on update cascade on delete cascade,
	PRIMARY KEY (CodigoFarmacia, CodigoTelefono)
	);
	
CREATE TABLE Abarca(
	CodigoContrato VARCHAR(10),
	CodigoFarmacia VARCHAR(10),
	CodigoEmpresaFarmaceutica VARCHAR(10),
	FOREIGN KEY (CodigoContrato) REFERENCES Contrato (Codigo) on update cascade on delete cascade,
	FOREIGN KEY (CodigoFarmacia) REFERENCES Farmacias (Codigo) on update cascade on delete cascade,
	FOREIGN KEY (CodigoEmpresaFarmaceutica) REFERENCES EmpresaFarmaceutica (Codigo) on update cascade on delete cascade,
	PRIMARY KEY (CodigoContrato, CodigoFarmacia, CodigoEmpresaFarmaceutica)
	);
	
CREATE TABLE Produce(
	NombreComercialMedicamento VARCHAR(10),
	CodigoEmpresaFarmaceutica VARCHAR(10),
	FOREIGN KEY (NombreComercialMedicamento) REFERENCES Medicamento (NombreComercial) on update cascade on delete cascade,
	FOREIGN KEY (CodigoEmpresaFarmaceutica) REFERENCES EmpresaFarmaceutica (Codigo) on update cascade on delete cascade,
	PRIMARY KEY (NombreComercialMedicamento, CodigoEmpresaFarmaceutica)
	);
	
	
	
----  FIN CREATE TABLE
----  INICIO INSERT TABLE

-- INSERT de tablas PK

INSERT INTO Medicos VALUES

('32.345.678', '1', 'Juan', 'García', '1985-01-15', 'Calle Baquedano 123', 'Santiago', 'juan.perez@hotmail.com'),
('34.219.854', '2', 'María', 'Rodríguez', '1990-02-20', 'Juan Mackenna 456', 'Concepción', 'maria.garcia@gmail.com'),
('38.201.817', '3', 'Pedro', 'González', '1983-03-10', 'Manuel Rodríguez 789', 'Valparaíso', 'carlos.fernandez@hotmail.co'),
('32.207.834', '4', 'Ana', 'Fernández', '1995-04-25', 'Los Carrera 101', 'Viña del Mar', 'ana.lopez@gmail.com'),
('35.029.464', '5', 'José', 'Pérez', '1987-05-30', 'Avenida Zenteno 202', 'Antofagasta', 'luis.martinez@hotmail.com'),
('39.972.694', '6', 'Laura', 'López', '1992-06-05', 'Matta 303', 'Temuco', 'laura.gomez@gmail.com');

SELECT * FROM Medicos;


INSERT INTO Telefono VALUES

('9122334455'),
('933445566'),
('944556677'),
('955667788'),
('977889900'),
('966778899'),
('988990011'),
('999001122'),
('900112233'),
('911223344'),
('922334455'),
('933445266'),
('944526677'),
('955267788'),
('966778829'),
('977882900'),
('988920011'),
('999021122'),
('900412233'),
('941223344'),
('922334454'),
('933445546'),
('944546677'),
('954667788'),
('966748899'),
('977889700'),
('988990711'),
('999001722'),
('900112733'),
('911223744'),
('922334755'),
('933445766'),
('944556777'),
('955667778'),
('966778879'),
('977889970'),
('988990411'),
('212345678'),
('230987654'),
('265432109'),
('273456789'),
('284567890'),
('216543210'),
('295678901'),
('222222222'),
('201234567'),
('288888888'),
('298765432'),
('209876543'),
('250000000'),
('233333333'),
('255555555'),
('278888888'),
('266666666'),
('244444444'),
('277777777'),
('211111111'),
('244544444'),
('236333333'),
('221222222');


SELECT * FROM Telefono;

INSERT INTO Especialidad VALUES

('MEDGEN1', 'Cardiología'),
('CARDIO2', 'Dermatología'),
('NEURO3', 'Neurología'),
('ORTOP4', 'Pediatría'),
('ONCOL5', 'Ginecología'),
('PEDIAT6', 'Obstetricia');

SELECT * FROM Especialidad;

INSERT INTO RecetaMedica VALUES

('RECETA001', 'Analgésico para aliviar el dolor leve.', '2003-11-17'),
('MEDIC2345', 'Antibiótico para tratar infecciones bacterianas.', '2009-06-02'),
('RX789ABC', 'Antipirético para reducir la fiebre.', '2015-09-21'),
('DOCTOR123', 'Antihistamínico para aliviar alergias.', '2020-03-05'),
('SALUD7890', 'Antiinflamatorio para reducir la inflamación.', '2012-07-29'),

('CURA45678', 'Suplemento vitamínico para mejorar la salud general.', '2018-01-12'),
('FARMACIA1', 'Antitusivo para calmar la tos.', '2006-10-18'),
('VITAMINAS', 'Antidiarreico para tratar la diarrea.', '2014-05-09'),
('DOSIS3456', 'Antidepresivo para trastornos del estado de ánimo.', '2011-08-27'),
('TERAPEUTA', 'Antiséptico para limpiar heridas.', '2017-02-14'),
('PANACEA12', 'Laxante para aliviar el estreñimiento.', '2019-11-30'),
('SANIDAD34', 'Protector gástrico para evitar irritación del estómago.', '2005-04-25'),
('BIENESTAR', 'Antiespasmódico para calmar los espasmos musculares.', '2013-06-10'),
('DOSIFICAR', 'Anestésico tópico para adormecer la piel.', '2008-09-06'),
('ANALGESIA', 'Antifúngico para tratar infecciones por hongos.', '2010-12-19');

SELECT * FROM RecetaMedica;

INSERT INTO Prevision VALUES

('FONASA001', 'FONASA', 'FONASA'),
('ISAPRE1234', 'ISAPRE', 'ISAPRE'),
('BANMEDICA5', 'Banmédica', 'ISAPRE'),
('CONSALUD6', 'Consalud', 'ISAPRE'),
('COLMENA789', 'Colmena', 'ISAPRE'),
('CRUZBLANCA', 'CruzBlanca', 'ISAPRE');

SELECT * FROM Prevision;

INSERT INTO Contrato VALUES

('ABC123XYZ', '25-03-2005', '10-08-2018', 'Contrato de Suministro entre Farmacia "Salud y Bienestar" y Empresa Farmacéutica "VitalPharm"
Detalles: Salud y Bienestar se compromete a adquirir exclusivamente productos de VitalPharm para su venta al público. Se establece un sistema de entrega regular y se garantiza la calidad de los productos.'),
('DEF456JKL', '12-08-2012', '05-06-2026', 'Acuerdo de Distribución entre Farmacia "BienestarTotal" y Empresa Farmacéutica "NovaPharm"
Detalles: BienestarTotal distribuirá productos de NovaPharm en su área de influencia. NovaPharm proporcionará materiales promocionales y apoyo técnico para maximizar las ventas.'),
('GHI789MNO', '06-05-2018', '20-11-2028', 'Acuerdo de Distribución entre Farmacia "SaludPerfecta" y Empresa Farmacéutica "Farmex"
Detalles: SaludPerfecta distribuirá productos de Farmex en sus sucursales. Farmex ofrecerá capacitación periódica al personal de SaludPerfecta sobre los nuevos productos.'),
('PQRS321TUV', '19-11-2023', '03-02-2031', 'Contrato de Suministro entre Farmacia "VitalCare" y Empresa Farmacéutica "PharmaCore"
Detalles: VitalCare adquiere productos exclusivamente de PharmaCore. PharmaCore proporcionará un descuento especial por volumen de compra y apoyo en campañas publicitarias locales.'),
('WXYZ987DEF', '03-09-2007', '28-04-2021', 'Acuerdo de Distribución entre Farmacia "Salud y Vida" y Empresa Farmacéutica "HealthCo"
Detalles: Salud y Vida distribuirá productos de HealthCo en sus sucursales. HealthCo ofrecerá un programa de incentivos para las ventas más altas de sus productos.'),
('123ABCXYZ', '14-02-2015', '09-11-2029', 'Contrato de Suministro entre Farmacia "BienestarTotal" y Empresa Farmacéutica "GenPharma"
Detalles: BienestarTotal adquiere productos exclusivamente de GenPharma, incluidos medicamentos genéricos y de marca. GenPharma ofrecerá asistencia técnica y formación continua al personal de la farmacia.');

SELECT * FROM Contrato;

INSERT INTO Farmacias VALUES

('FARMA001', 'SaludPharma', 'Calle Sol 123'),
('PHARCO002', 'BienestarMeds', 'Av. Libertad 456'),
('DRUGSTORE3', 'VitaFarmacia', 'Carrera 7 Este 789'),
('RXSHOP004', 'Curafarma', 'Paseo del Norte 234'),
('MEDS005', 'CuraSalud', 'Av. Principal 567'),
('HEALTH006', 'HealthMeds', 'Calle Mayor 890');

SELECT * FROM Farmacias;

INSERT INTO EmpresaFarmaceutica VALUES

('PFZ101', 'PharmaCore'),
('MED204', 'MediCo'),
('FMP312', 'BioHealth'),
('RXB403', 'RxSolutions'),
('VPH510', 'VitaPharm'),
('GNC625', 'GenPharma');

SELECT * FROM EmpresaFarmaceutica;

INSERT INTO Medicamento VALUES

('Zentech', 'C8H9NO2 (Paracetamol)'),
('FlexiTech', 'C18H21NO3 (Codeína)'),
('BrightWays', 'C17H21NO4 (Morfina)'),
('EverGlow', 'C17H19ClFN3O (Ciprofloxacina)'),
('Innovatech', 'C16H21NO2 (Oxicodona)'),
('SparkleTec', 'C19H24N2O2 (Oxycodone)');

SELECT * FROM Medicamento;

-- INSERT de tablas FK

INSERT INTO Paciente VALUES

('31.218.508', 'Carlos', 'Martínez', '1989-07-15', 'Calle Bilbao 404', 'La Serena', 'pedro.gonzalez@hotmail.com', 		'32.345.678', '30-10-2010', '02-06-2023'),
('36.207.778', 'Sofía', 'Ramírez', '1984-08-20', 'Avenida República 505', 'Iquique', 'sofia.rodriguez@gmail.com', 		'34.219.854', '08-06-2016', '25-12-2028'),
('33.021.494', 'Luis', 'Díaz', '1993-09-10', 'Calle Cochrane 606', 'Talcahuano', 'jorge.ramirez@hotmail.com', 		'38.201.817', '17-12-2021', '05-08-2035'),
('40.071.303', 'Andrea', 'Sánchez', '1986-10-25', 'Calle Freire 707', 'Rancagua', 'marta.torres@gmail.com', 		'32.345.678', '21-07-2004', '09-03-2018'),
('31.207.834', 'Miguel', 'Romero', '1991-11-30', 'Calle Yungay 808', 'Arica', 'pablo.sanchez@hotmail.com', 		'38.201.817', '09-04-2013', '27-08-2025'),
('37.207.778', 'Claudia', 'Torres', '1988-12-05', 'Calle Lynch 909', 'Puerto Montt', 'sara.ruiz@gmail.com', 		'32.207.834', '27-01-2019', '14-05-2031'),
('35.029.464', 'Alejandro', 'Suárez', '1980-01-14', 'Avenida Alemania 111', 'Chillán', 'diego.morales@hotmail.com', 		'32.207.834', '18-09-2008', '18-07-2035'),
('38.201.817', 'Valentina', 'Gómez', '1981-02-18', 'Calle Santa Rosa 222', 'Calama', 'elena.alvarez@gmail.com', 		'34.219.854', '05-12-2017', '03-05-2022'),
('32.345.678', 'Daniel', 'Vásquez', '1982-03-22', 'Calle Errázuriz 333', 'Osorno', 'javier.ortiz@hotmail.com', 		'32.345.678', '23-06-2011', '20-09-2029'),
('39.972.694', 'Camila', 'Flores', '1983-04-26', 'Calle Echeverría 444', 'Copiapó', 'lucia.vargas@gmail.com', 		'35.029.464', '10-03-2020', '07-02-2024'),
('31.218.507', 'David', 'Morales', '1984-05-30', 'Avenida Mackenna 555', 'Quilpué', 'manuel.navarro@hotmail.com', 		'39.972.694', '26-05-2006', '25-11-2033');

SELECT * FROM Paciente;

INSERT INTO Supervisor VALUES

('36.207.777', 'Natalia', 'Castillo', '1985-06-15', 'Calle OHiggins 666', 'Los Ángeles', 'teresa.molina@gmail.com', 		'FARMA001'),
('33.021.494', 'Fernando', 'Acosta', '1986-07-20', 'Calle Eleuterio Ramírez 777', 'Punta Arenas', 'andres.castillo@hotmail.com', 		'FARMA001'),
('40.071.303', 'Paula', 'Ríos', '1987-08-25', 'Calle Bulnes 888', 'Curicó', 'natalia.ramos@gmail.com', 		'PHARCO002'),
('31.207.834', 'Roberto', 'Silva', '1988-09-30', 'Calle Lord Cochrane 999', 'San Antonio', 'ricardo.dominguez@hotmail.com', 		'PHARCO002'),
('37.207.778', 'Patricia', 'Castro', '1989-10-05', 'Calle Mackenna 121', 'Castro', 'carmen.silva@gmail.com', 		'FARMA001'),
('35.029.464', 'Javier', 'Espinoza', '1990-11-15', 'Calle Figueroa 234', 'Ovalle', 'fernando.mendez@hotmail.com', 		'DRUGSTORE3'),
('38.201.817', 'Jessica', 'Miranda', '1991-12-20', 'Avenida César Ercilla 345', 'Linares', 'beatriz.martin@gmail.com', 		'RXSHOP004'),
('32.345.678', 'Manuel', 'Aguilar', '1992-01-25', 'Calle Diego Portales 456', 'Quillota', 'raul.pena@hotmail.com', 		'DRUGSTORE3'),
('39.972.694', 'Diana', 'Mendoza', '1993-02-28', 'Calle Colón 567', 'Valdivia', 'clara.soto@gmail.com', 		'MEDS005'),
('31.218.506', 'Ricardo', 'Ortiz', '1994-03-30', 'Calle Pedro Montt 678', 'San Felipe', 'francisco.iglesias@hotmail.com', 		'HEALTH006'),
('36.207.779', 'Gabriela', 'Jiménez', '1995-04-05', 'Avenida Ejército 789', 'Los Andes', 'susana.rodriguez@gmail.com', 		'MEDS005');


SELECT * FROM Supervisor;

-- INSERT de tablas PFK y otro

INSERT INTO Nombra VALUES

('ABC123XYZ', '36.207.777', 'FARMA001', '25-03-2005', '10-08-2018'),
('DEF456JKL', '33.021.494', 'FARMA001', '12-08-2012', '05-06-2026'),
('GHI789MNO', '40.071.303', 'PHARCO002', '06-05-2018', '20-11-2028'),
('PQRS321TUV', '31.207.834', 'PHARCO002', '19-11-2023', '03-02-2031'),
('ABC123XYZ', '37.207.778', 'FARMA001', '25-03-2005', '10-08-2018'),
('DEF456JKL', '35.029.464', 'DRUGSTORE3', '12-08-2012', '05-06-2026'),
('GHI789MNO', '38.201.817', 'RXSHOP004', '06-05-2018', '20-11-2028'),
('WXYZ987DEF', '32.345.678', 'DRUGSTORE3', '03-09-2007', '28-04-2021'),
('ABC123XYZ', '39.972.694', 'MEDS005', '25-03-2005', '10-08-2018'),
('123ABCXYZ', '31.218.506', 'HEALTH006', '14-02-2015', '09-11-2029'),
('123ABCXYZ', '36.207.779', 'MEDS005', '14-02-2015', '09-11-2029');

SELECT * FROM Nombra;

INSERT INTO Vende VALUES

('Zentech', 'FARMA001', '2500'),
('FlexiTech', 'PHARCO002', '1800'),
('BrightWays', 'DRUGSTORE3', '2200'),
('EverGlow', 'RXSHOP004', '3500'),
('Zentech', 'RXSHOP004', '4000'),
('FlexiTech', 'FARMA001', '2700'),
('BrightWays', 'MEDS005', '3200'),
('Innovatech', 'DRUGSTORE3', '2900'),
('Zentech', 'PHARCO002', '4500'),
('FlexiTech', 'HEALTH006', '3600'),
('SparkleTec', 'FARMA001', '3100');

SELECT * FROM Vende;

INSERT INTO Contiene VALUES

('RECETA001', 'FlexiTech', '2'),
('RECETA001', 'BrightWays', '2'),
('MEDIC2345', 'BrightWays', '5'),
('MEDIC2345', 'FlexiTech', '5'),
('MEDIC2345', 'Zentech', '5'),
('RX789ABC', 'Zentech', '7'),
('RX789ABC', 'BrightWays', '7'),
('RECETA001', 'EverGlow', '3'),
('DOCTOR123', 'FlexiTech', '2'),
('DOCTOR123', 'BrightWays', '2'),
('DOCTOR123', 'Zentech', '2'),
('MEDIC2345', 'Innovatech', '7'),
('CURA45678', 'Zentech', '6'),
('CURA45678', 'FlexiTech', '6'),
('CURA45678', 'BrightWays', '6'),
('SALUD7890', 'BrightWays', '5'),
('SALUD7890', 'FlexiTech', '5'),
('RECETA001', 'Zentech', '1'),
('CURA45678', 'SparkleTec', '3'),
('MEDIC2345', 'SparkleTec', '8'),

('FARMACIA1', 'Zentech', '5'),
('VITAMINAS', 'Zentech', '9'),
('ANALGESIA', 'Zentech', '3'),
('VITAMINAS', 'EverGlow', '7'),
('ANALGESIA', 'FlexiTech', '2'),
('DOSIS3456', 'Zentech', '4'),
('DOSIFICAR', 'Zentech', '6'),
('FARMACIA1', 'SparkleTec', '1'),
('TERAPEUTA', 'Zentech', '8'),
('VITAMINAS', 'FlexiTech', '9'),
('PANACEA12', 'FlexiTech', '2'),
('TERAPEUTA', 'FlexiTech', '7'),
('BIENESTAR', 'FlexiTech', '4'),
('PANACEA12', 'Zentech', '6'),
('FARMACIA1', 'FlexiTech', '3'),
('DOSIS3456', 'FlexiTech', '5'),
('FARMACIA1', 'Innovatech', '1'),
('SANIDAD34', 'BrightWays', '8'),
('VITAMINAS', 'BrightWays', '9'),
('PANACEA12', 'BrightWays', '2'),
('DOSIS3456', 'BrightWays', '4'),
('FARMACIA1', 'BrightWays', '3'),
('DOSIS3456', 'EverGlow', '5'),
('VITAMINAS', 'Innovatech', '7'),
('SANIDAD34', 'EverGlow', '6'),
('FARMACIA1', 'EverGlow', '1');

SELECT * FROM Contiene;

INSERT INTO Supervisa VALUES

('36.207.777', 'ABC123XYZ', '25-03-2005', '10-08-2018'),
('33.021.494', 'DEF456JKL', '12-08-2012', '05-06-2026'),
('40.071.303', 'GHI789MNO', '06-05-2018', '20-11-2028'),
('31.207.834', 'PQRS321TUV', '19-11-2023', '03-02-2031'),
('37.207.778', 'ABC123XYZ', '25-03-2005', '10-08-2018'),
('35.029.464', 'DEF456JKL', '12-08-2012', '05-06-2026'),
('38.201.817', 'GHI789MNO', '06-05-2018', '20-11-2028'),
('32.345.678', 'WXYZ987DEF', '03-09-2007', '28-04-2021'),
('39.972.694', 'ABC123XYZ', '25-03-2005', '10-08-2018'),
('31.218.506', '123ABCXYZ', '14-02-2015', '09-11-2029'),
('36.207.779', '123ABCXYZ', '14-02-2015', '09-11-2029');

SELECT * FROM Supervisa;

INSERT INTO Receta VALUES

('31.218.508', '32.345.678', 'RECETA001', '2003-11-17'),
('36.207.778', '34.219.854', 'MEDIC2345', '2009-06-02'),
('33.021.494', '38.201.817', 'RX789ABC', '2015-09-21'),
('40.071.303', '32.345.678', 'RECETA001', '2003-11-17'),
('31.207.834', '38.201.817', 'CURA45678', '2012-07-29'),
('37.207.778', '32.207.834', 'SALUD7890', '2012-07-29'),
('35.029.464', '32.207.834', 'DOCTOR123', '2020-03-05'),
('38.201.817', '34.219.854', 'RECETA001', '2003-11-17'),
('32.345.678', '32.345.678', 'CURA45678', '2012-07-29'),
('39.972.694', '35.029.464', 'MEDIC2345', '2009-06-02'),
('31.218.507', '39.972.694', 'DOCTOR123', '2020-03-05');

SELECT * FROM Receta;

INSERT INTO Ostenta VALUES

('MEDGEN1', '32.345.678'),
('CARDIO2', '34.219.854'),
('NEURO3', '32.345.678'),
('MEDGEN1', '34.219.854'),
('ORTOP4', '38.201.817'),
('ONCOL5', '32.207.834'),
('PEDIAT6', '38.201.817'),
('CARDIO2', '35.029.464'),
('MEDGEN1', '35.029.464'),
('PEDIAT6', '39.972.694'),
('CARDIO2', '32.207.834');

SELECT * FROM Ostenta;

INSERT INTO Tiene VALUES

('31.218.508', 'FONASA001'),
('36.207.778', 'ISAPRE1234'),
('33.021.494', 'BANMEDICA5'),
('40.071.303', 'CONSALUD6'),
('31.207.834', 'FONASA001'),
('37.207.778', 'COLMENA789'),
('35.029.464', 'ISAPRE1234'),
('38.201.817', 'CRUZBLANCA'),
('32.345.678', 'FONASA001'),
('39.972.694', 'COLMENA789'),
('31.218.507', 'BANMEDICA5');

SELECT * FROM Tiene;

INSERT INTO Adquiere VALUES

('31.218.508', 'Zentech'),
('36.207.778', 'FlexiTech'),
('33.021.494', 'BrightWays'),
('40.071.303', 'EverGlow'),
('31.207.834', 'Zentech'),
('37.207.778', 'Innovatech'),
('35.029.464', 'FlexiTech'),
('38.201.817', 'SparkleTec'),
('32.345.678', 'Zentech'),
('39.972.694', 'Innovatech'),
('31.218.507', 'BrightWays');

SELECT * FROM Adquiere;

INSERT INTO TelMed VALUES

('32.345.678', '9122334455'),
('34.219.854', '933445566'),
('35.029.464', '944556677'),
('34.219.854', '955667788'),
('32.207.834', '966778899'),
('38.201.817', '977889900'),
('32.345.678', '988990011'),
('32.207.834', '999001122'),
('38.201.817', '900112233'),
('35.029.464', '911223344'),
('39.972.694', '922334455');

SELECT * FROM TelMed;

INSERT INTO TelPac VALUES

('31.218.508', '933445266'),
('36.207.778', '944526677'),
('33.021.494', '955267788'),
('40.071.303', '966778829'),
('31.207.834', '977882900'),
('37.207.778', '988920011'),
('35.029.464', '999021122'),
('38.201.817', '900412233'),
('32.345.678', '941223344'),
('39.972.694', '922334454'),
('31.218.507', '933445546');

SELECT * FROM TelPac;

INSERT INTO TelSup VALUES

('36.207.777', '944546677'),
('33.021.494', '954667788'),
('40.071.303', '966748899'),
('31.207.834', '977889700'),
('37.207.778', '988990711'),
('35.029.464', '999001722'),
('38.201.817', '900112733'),
('32.345.678', '911223744'),
('39.972.694', '922334755'),
('31.218.506', '933445766'),
('36.207.779', '944556777');

SELECT * FROM TelSup;

INSERT INTO TelEmpFar VALUES

('212345678', 'PFZ101'),
('230987654', 'MED204'),
('265432109', 'FMP312'),
('273456789', 'GNC625'),
('284567890', 'VPH510'),
('216543210', 'PFZ101'),
('295678901', 'MED204'),
('222222222', 'RXB403'),
('201234567', 'FMP312'),
('288888888', 'PFZ101'),
('298765432', 'GNC625');

SELECT * FROM TelEmpFar;

INSERT INTO TelFar VALUES

('FARMA001', '209876543'),
('PHARCO002', '250000000'),
('DRUGSTORE3', '233333333'),
('MEDS005', '255555555'),
('HEALTH006', '278888888'),
('FARMA001', '266666666'),
('MEDS005', '244444444'),
('DRUGSTORE3', '277777777'),
('PHARCO002', '211111111'),
('FARMA001', '244544444'),
('RXSHOP004', '236333333');

SELECT * FROM TelFar;

INSERT INTO Abarca VALUES

('ABC123XYZ', 'FARMA001', 'PFZ101'),
('DEF456JKL', 'PHARCO002', 'MED204'),
('GHI789MNO', 'DRUGSTORE3', 'FMP312'),
('PQRS321TUV', 'RXSHOP004', 'RXB403'),
('ABC123XYZ', 'RXSHOP004', 'PFZ101'),
('DEF456JKL', 'FARMA001', 'MED204'),
('GHI789MNO', 'MEDS005', 'FMP312'),
('WXYZ987DEF', 'DRUGSTORE3', 'VPH510'),
('ABC123XYZ', 'PHARCO002', 'PFZ101'),
('DEF456JKL', 'HEALTH006', 'MED204'),
('123ABCXYZ', 'FARMA001', 'GNC625');

SELECT * FROM Abarca;

INSERT INTO Produce VALUES

('Zentech', 'PFZ101'),
('FlexiTech', 'MED204'),
('SparkleTec', 'RXB403'),
('Innovatech', 'GNC625'),
('BrightWays', 'FMP312'),
('Zentech', 'FMP312'),
('EverGlow', 'RXB403'),
('Innovatech', 'VPH510'),
('FlexiTech', 'FMP312'),
('SparkleTec', 'GNC625'),
('EverGlow', 'VPH510');

SELECT * FROM Produce;


