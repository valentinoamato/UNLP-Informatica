Procedure Ej2 IS
TASK Organizador IS
    AtencionDisc(dni: IN Integer, r: OUT Remera, c: OUT Chip);
    AtencionAnci(dni: IN Integer, r: OUT Remera, c: OUT Chip);
    Atencion(dni: IN Integer, r: OUT Remera, c: OUT Chip);
end Organizador;

TASK TYPE Persona;

Personas: array(1..P) of Persona;

TASK BODY Organizador IS
    dni: Integer;
begin
    for i in 1..P loop
        select
            accept AtencionDisc(dni: IN Integer, r: OUT Remera, c: OUT Chip) do
                r := obtenerRemera(dni);
                c := obtenerChip(c);
            end AtencionDisc;
        or
            when AtencionDisc'count = 0 => accept AtencionAnci(dni: IN Integer, r: OUT Remera, c: OUT Chip) do
                r := obtenerRemera(dni);
                c := obtenerChip(c);
            end AtencionAnci;

        or
            when (AtencionDisc'count = 0)  and (AtencionAnci'count = 0) => accept Atencion(dni: IN Integer, r: OUT Remera, c: OUT Chip) do
                r := obtenerRemera(dni);
                c := obtenerChip(c);
            end Atencion;
        end select;
    end loop;
end;

TASK BODY Persona IS
    dni: Integer;
    r: Remera;
    c: Chip;
    p: Integer;
begin
    dni:=obtenerDNI();
    p:=obtenerPrioridad();
    match p do
        case 0:
            Organizador.AtencionDisc(dni, r, c);

        case 0:
            Organizador.AtencionAnci(dni, r, c);

        case Others:
            Organizador.Atencion(dni, r, c);
    end match;
end;

begin
    null;
end;
