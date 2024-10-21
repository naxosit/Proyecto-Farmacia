create or replace function medicosP() returns trigger as $$
declare contador int;
begin
select count (*) into contador from paciente where rut =new.rut;

if contador >0 then
	raise exception 'No es posible insertar un nuevo medico ya que existe ya un medico designado';
end if;
return new;
end;
$$ language 'plpgsql'

create or replace trigger tr_medicos
before insert on paciente
for each row execute procedure medicosP();


insert into paciente(rut,rutmedico) values ('31.218.508','34.219.854')

select * from paciente