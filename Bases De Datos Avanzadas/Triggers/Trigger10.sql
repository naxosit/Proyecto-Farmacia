create or replace function validar_rut() returns trigger as $$
declare
    rut_sin_dv text;
    dv_calculado char(1);
    suma int := 0;
    factor int := 2;
    i int;
begin
    -- obtener el rut sin el dígito verificador
    rut_sin_dv := left(new.rut, length(new.rut) - 2); 
	--la funcion left devuelve los primeros n caracteres de una cadena de texto
	--la funcion right devuelve los ultimos n caracteres de una cadena de texto
    dv_calculado := right(new.rut, 1);

    -- calcular la suma
    for i in reverse 1 .. length(rut_sin_dv) loop
	-- el .. se usa para definir el rango del loop
        suma := suma + (substring(rut_sin_dv from i for 1)::int * factor);
	-- el operador :: se utiliza para convertir un dato en otro en este casod e texto a int
	--substring es para extraer una parte de la cadena de texto, el primer variable hace referencia la cadena que queremos
	-- el i en este caso la posicion donde empieza la extraccion 1 primer caracter, el 1 es la cantidad de caracteres que se quiere extraer
        factor := factor + 1;
        if factor > 7 then
            factor := 2;
        end if;
    end loop;

    -- obtener el módulo 11
    suma := 11 - (suma % 11);

    -- determinar el dígito verificador
    if suma = 11 then
        dv_calculado := '0';
    elsif suma = 10 then
        dv_calculado := 'k';
    else
        dv_calculado := suma::text;
    end if;

    -- comparar
    if dv_calculado <> right(new.rut, 1) then
        raise exception 'El RUT % no es válido', new.rut;
    end if;

    return new;  -- Permite que la operación continúe
end;
$$ language plpgsql;




create or replace trigger tg_validarRut_medicos
before insert or update on medicos
for each row execute procedure validar_rut();


create or replace trigger tg_validarRut_paciente
before insert or update on paciente
for each row execute procedure validar_rut();

create or replace trigger tg_validarRut_supervisor
before insert or update on supervisor
for each row execute procedure validar_rut();
