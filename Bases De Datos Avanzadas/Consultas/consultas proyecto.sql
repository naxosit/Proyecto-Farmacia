--TODOS LAS RESTRICCIONES, CONSULTAS Y VISTAS 

-- C1 Una restricción simple en cada relaci´on que corresponda que no permita que la fecha sea mayor a la
-- fecha actual (usar funci´on Now()) y tampoco menor al 1-1-1950.

alter table medicos
add constraint restriccion_FechaNacimientoMedicos
check ('1-1-1950'< fechaNacimiento and fechaNacimiento < now());

alter table receta
add constraint restriccion_fechaemision
check ('1-1-1950'< fechaEmision and fechaEmision < now());

alter table paciente
add constraint restriccion_fechaNacimientoPaciente
check ('1-1-1950'< fechaNacimiento and fechaNacimiento < now());

alter table RecetaMedica
add constraint restriccion_FechaRecetaMedica
check ('1-1-1950'< Fecha and Fecha < now());

alter table Supervisor
add constraint restriccion_FechaNacimientoSupervisor
check ('1-1-1950'< fechaNacimiento and fechaNacimiento < now());

alter table contrato 
add constraint restriccion_FechaInicioFin
check('1-1-1950' < FechaInicio and FechaInicio < now() and '1-1-1950' < FechaTermino);

alter table Supervisa
add constraint restriccion_FechaInicioFinSupervisa
check('1-1-1950'< FechaInicio and FechaInicio < now() and '1-1-1950'<FechaTermino );

alter table Nombra
add constraint restriccion_FechaInicioFinNombra
check('1-1-1950'< FechaInicio and FechaInicio < now() and '1-1-1950' < FechaFin);

-- C2 Una restricción simple que verifique que el precio de venta de un medicamento no pueda exceder los
-- 100.000 pesos.

alter table Vende
add constraint restriccion_VendePrecio
check(Precio >100.000);

--Q1 ENCONTRAR EL RUT Y EL NOMBRE DEL PACIENTE, RUT Y NOMBRE DEL MEDICO
--FECHA DE LA RECETA, NOMBRE DE LA FARMACIA, NOMBRE DEL MEDICAMENTO Y PRECIO
--SE ORDENA POR NOMBRE DE LA FARMACIA Y LUEGO POR NOMBRE DEL MEDICAMENTO
--DEBERÍA DAR 164 RESULTADOS

select distinct
	f.nombre as nombre_farmacia,
	v.nombrecomercialmedicamento as medicamento,
	p.rut as rut_paciente,
	p.nombre as nombre_paciente,
	p.rutmedico,
	m.nombre as nombre_medico,
	r.fechaemision,
	v.precio
from
	paciente p
	join medicos m on p.rutmedico =m.rut
	join receta r on r.rutmedico = m.rut
	join contiene c on r.codigorecetamedica = c.codigorecetamedica
	join vende v on v.nombrecomercialmedicamento = c.nombrecomercialmedicamento
	join farmacias f on f.codigo = v.codigofarmacia	
order by
	nombre_farmacia,medicamento;

--Q2 ENCONTRAR EL RUT Y NOMBRE DEL PACIENTE, LA ESPECIALIDAD DEL MEDICO A CARGO
--Y EL TOTAL DE VECES QUE EL PACIENTE A SIDO ATENDIDO POR UN MEDICO DE DICHA ESPECIALIDAD
--SE AGRUPA POR RUT DEL PACIENTE, NOMBRE DEL PACIENTE Y ESPECIALIDAD
--DEBERÍA DAR 21 RESULTADOS
select 
	p.rut as rut_paciente,
	p.nombre as nombre_paciente,
	e.nombre as especialidad,
	count(*) as Atenciones
from
	paciente p
	join medicos m on p.rutmedico = m.rut
	join ostenta o on m.rut = o.rutmedico
	join especialidad e on e.codigo=o.codigoespecialidad
group by
	p.rut,e.nombre
order by
	p.rut,p.nombre,e.nombre;

--Q3 ENCONTRAR EL CODIGO, NOMBRE, DIRECCION Y TELEFONO DE LAS FARMACIAS QUE NO 
--POSEEN UN CONTRATO VIGENTE CON ALGUNA EMPRESA FARMACEUTICA, PERO QUE VENDEN MEDICAMENTOS
--ELABORADOS POR DICHA EMPRESA FARMACEUTICA
--DEBERÍA DAR 8 RESULTADOS
SELECT 
	F.*, T.CODIGOTELEFONO
FROM 
	FARMACIAS F
	join telfar t on f.codigo=t.codigofarmacia
	join abarca a on a.codigofarmacia = f.codigo
	join empresafarmaceutica e on e.codigo = a.codigoempresafarmaceutica
	join contrato c on c.codigo=a.codigocontrato
	where c.fechatermino < now();
	
--Q4 ENCONTRAR EL NOMBRE DE: SUPERVISOR, FARMACIA Y EMPRESA FARMACEUTICA; Y LA CANTIDAD
--DE VECES QUE EL SUPERVISOR A PARTICIPADO EN UN CONTRATO CON DICHAS EMPRESAS
--ORDENADO POR NOMBRE DEL SUPERVISOR
--DEBERÍA DAR 22 RESULTADOS
select 
	s.nombre,
	s.apellido,
	f.nombre as farmacia,
	t.nombre as empresa,
	count(*) as participaciones
from
	supervisor s
join farmacias f on f.codigo=s.codigofarmacia
join abarca a on f.codigo= a.codigofarmacia
join empresafarmaceutica t on t.codigo =a.codigoempresafarmaceutica
group by s.nombre,s.apellido,farmacia,empresa
order by s.nombre,s.apellido;

--Q5 ENCONTRAR EL NOMBRE DE LA EMPRESA FARMACEUTICA, EL NOMBRE DEL MEDICAMENTO Y LA CANTIDAD DE VECES
--QUE EL MEDICAMENTO HA SIDO RECETADO MÁS DE 10 VECES EN DISTINTAS RECETAS
--SE AGRUPA POR NOMBRE DE LA EMPRESA FARMACEUTICA Y NOMBRE DEL MEDICAMENTO.
--DEBERÍA DAR 5 RESULTADOS

select
	e.nombre as Empresa_Nombre,
	m.nombrecomercial as Medicamento_Nombre,
	count(c.codigorecetamedica) as cantidad_recetas
from
EmpresaFarmaceutica e
join Produce p on p.CodigoEmpresaFarmaceutica = e.Codigo
join Medicamento m on m.NombreComercial = p.NombreComercialMedicamento
join contiene c on m.nombrecomercial=c.nombrecomercialmedicamento
group by Medicamento_Nombre,Empresa_nombre
having count(c.codigorecetamedica) >10


--VISTA 1 CREAR UNA VISTA QUE LISTE LOS MEDICOS QUE NO HAN EMITIDO RECETAS
--A PACIENTES EL ÚLTIMO MES
--DEBERÍA DAR 11 RESULTADOS
create or replace view vista_mes_sin_recetar as 
select 
	m.rut,
	m.nombre,
	m.apellido
from 
	medicos m
join receta r on r.rutmedico =m.rut
where not (current_date - interval '1 month') < r.fechaemision;

select * from vista_mes_sin_recetar;


--VISTA 2 CREAR UNA VISTA QUE ENTREGUE EL TOTAL DE RECETAS EMITIDAS DE CADA MEDICO,
--AGRUPADAS POR AÑO
--DEBERÍA DAR 10 RESULTADOS
create or replace view vista_total_recetas as
select distinct
	m.rut,
	m.nombre,
	m.apellido,
	r.fechaemision,
	count(*) as total_recetas
from
	medicos m
join receta r on r.rutmedico=m.rut
group by r.fechaemision,m.rut,m.nombre,m.apellido
order by r.fechaemision;

select * from vista_total_recetas;

--VISTA 3 CREAR UNA VISTA QUE ENTREGUE NOMBRE DEL PACIENTE, NOMBRE DEL MEDICO Y EL TOTAL
--DE RECETAS EMITIDAS POR UN MEDICO A UN PACIENTE
--AGRUPADAS POR PACIENTE, MEDICO Y AÑO.
--DEBERÍA DAR 11 RESULTADOS
create or replace view vista_info_recetas as
select distinct
	p.nombre as nombre_paciente,
	p.apellido as apellido_paciente,
	m.nombre as nombre_medico,
	m.apellido as apellido_medico,
	r.fechaemision as fecha_receta,
	count(*) as total_recetas
from
	paciente p 
join receta r on r.rutpaciente=p.rut
join medicos m on m.rut=r.rutmedico
group by nombre_paciente,apellido_paciente,nombre_medico,apellido_medico,fecha_receta;

select * from vista_info_recetas;