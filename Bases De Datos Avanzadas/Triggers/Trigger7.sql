create or replace function recetasMedico()
returns trigger as $$
begin
if new.rutmedico = new.rutpaciente then
	raise exception 'El medico no puede recetarse a si mismo';
end if;
return New;
end;
$$ language 'plpgsql'


create or replace trigger tg_recetasMedico
before insert or update on receta
for each row execute procedure recetasMedico();


insert into receta(rutpaciente,rutmedico) values ('32.345.678', '32.345.678')