create or replace function recetasMedicoCabecera() returns trigger as $$
begin
	if new.rutmedico in (select rutmedico from paciente) then
		raise exception 'Solo puede recetar el medico de cabecera del paciente';
	end if;
	return new;
end;
$$language plpgsql
		
	
create or replace trigger trg_medico_cabecera
before insert or update on receta
for each row execute procedure recetasMedicoCabecera();

select * from receta

insert into receta values ('31.218.507','34.219.854', 'RECETA001','2003-08-02')

