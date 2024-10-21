create table contrato_backup(
orden_backup serial primary key,
codigo_contrato varchar(10),
fechaInicio_contrato date,
fechaTermino_contrato date,
TextoContrato varchar(500),
fecha_respaldo timestamp default current_timestamp
);


create or replace function contrato_backup() returns trigger as $$
begin
insert into contrato_backup(codigo_contrato,fechaInicio_contrato,fechaTermino_contrato,TextoContrato)
values (old.codigo, old.fechainicio, old.fechatermino, old.textocontrato);
return new;
end;
$$language 'plpgsql'


create or replace trigger tg_backupContrato
before update or delete on contrato
for each row execute procedure contrato_backup();

	
select * from contrato

select * from contrato_backup