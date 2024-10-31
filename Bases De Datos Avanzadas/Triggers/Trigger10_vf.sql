create or replace function validar_rut() returns trigger as $$
declare
	strlen int;
	i int := 1;
	j int := 2;
    suma numeric := 0;
	temprut varchar(12);
    verify_dv varchar(2);
begin
	strlen := length(new.rut::text);

if strlen = 8 or strlen = 7 then
        temprut := reverse(new.rut::text);

	while i <= strlen loop
            	suma := suma + (cast(substring(temprut, i, 1) as integer) * j); 
            	i := i + 1;
            
            	if j = 7 then
                	j := 2;
            	else
                	j := j + 1;
            	end if;
        end loop;

	verify_dv := 11 - (suma % 11);
        
        -- Ajustar el dígito verificador calculado
        if verify_dv = '11' then
            verify_dv := '0';
        elsif verify_dv = '10' then
            verify_dv := 'k';
        else
            verify_dv := verify_dv::varchar;
        end if;

-- Comparar el DV calculado con el DV proporcionado
        if lower(new.DigitoVerificador) = verify_dv then
           return new;
        else
            raise exception 'Digito verificador no valido';
        end if;
    end if;

    -- Retornar 0 si la longitud del RUT no es válida
    raise exception 'Rut ingresado no valido';
end;
$$ language plpgsql;

create or replace trigger tg_ValidarRutMedico before insert on medicos for
each row execute function validar_rut();


create or replace trigger tg_ValidarRutPaciente before insert on Paciente for
each row execute function validar_rut();



create or replace trigger tg_ValidarRutSupervisor before insert on Supervisor for
each row execute function validar_rut();