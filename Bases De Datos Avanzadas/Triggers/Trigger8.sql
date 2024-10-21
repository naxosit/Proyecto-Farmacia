create or replace function Supervisor_contrato() returns trigger as $$
begin
if exists (select 1 from contrato where codigo = new.codigo) then
	raise exception 'No se puede efectuar la insercion ya que no puede haber 2 contratos iguales al mismo tiempo';
end if;
return new;
end;
$$ language 'plpgsql'

create or replace trigger tg_Supervisorcontrato
before insert on contrato
for each row execute procedure Supervisor_contrato();



select * from contrato

insert into contrato(codigo) values ('ABC123XYZ')