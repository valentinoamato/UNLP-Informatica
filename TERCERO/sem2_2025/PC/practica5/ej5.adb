with Ada.Text_IO;
use Ada.Text_IO;

with Ada.Numerics.Discrete_Random;

procedure Ej5 is
    type Int5 is array (1..5) of Integer;

function RandomInt return Integer is
    package Random_Int is new Ada.Numerics.Discrete_Random(Integer);
    Gen  : Random_Int.Generator;
    Dato : Integer;
begin
    Random_Int.Reset(Gen);
    return Random_Int.Random(Gen) mod 10;
end RandomInt;

procedure RandomDelay is
begin
    delay Duration(RandomInt) / 3.0;
end RandomDelay;

function GetGrupo(Id: Integer) return Integer is
begin
    return ((Id - 1) mod 5) + 1;
end GetGrupo;

function GetMax(Montos: Int5) return Integer is
    Max: Integer := -10;
    IdMax: Integer:= 0;
begin
    for I in 1..5 loop
        if Montos(I) > Max then
            Max:=Montos(I);
            IdMax:=I;
        end if;
    end loop;

    return IdMax;
end GetMax;

    task type Persona is
        entry SetId(Id: IN Integer; Equipo: IN Integer);
        entry Barrera;
        entry GrupoMax(M: IN Integer);
    end Persona;


    Personas: array(1..20) of Persona;

    task Coordinador is
        entry Llegue(Equipo: IN Integer);
        entry SumarMonto(M: IN Integer; Equipo: IN Integer);
    end Coordinador;
    task body Coordinador is
        cant: Int5:= (0,0,0,0,0); --Cant integrantes
        montos: Int5:=(0,0,0,0,0); --Monto de cada equipo
        aux: Integer;
    begin
        -- Barrera
        for I in 1..20 loop
            accept Llegue(Equipo: IN Integer) do
                Put(Integer'Image(Equipo) & " ");
                aux:=Equipo;
                cant(Equipo):=cant(Equipo)+1;
            end Llegue;

            -- Si llegaron todos
            if Cant(aux) = 4 then
                Put_Line("");
                Put_Line("Equipo " & Integer'Image(aux) & "listo.");

                -- Despertar a todos (EJ. 1,6,11,16)
                for J in 0..3 loop
                    Personas(aux + (J * 5)).Barrera;
                    Put_Line("Despertate " & Integer'Image(aux + (J * 5)));
                end loop;
            end if;
        end loop;

        -- Actualizar los montos
        for I in 1..20 loop
            accept SumarMonto(M: IN Integer; Equipo: IN Integer) do
                montos(Equipo):=montos(Equipo)+M;
            end SumarMonto;
        end loop;

        -- Calcular el maximo
        aux:=GetMax(Montos);

        for I in 1..5 loop
            Put_Line("El equipo " & Integer'Image(I) & " junto " & Integer'Image(montos(I)));
        end loop;

        -- Informar a todos quien junto mas
        for I in 1..20 loop
            Personas(I).GrupoMax(aux);
        end loop;

    end Coordinador;

    task body Persona is
        Monto: Integer:=0;
        Id: Integer;
        Equipo: Integer;
    begin
        -- Recibir Id y Codigo de equipo
        accept SetId(Id: IN Integer; Equipo: IN Integer) do
            Persona.Id:=Id;
            Persona.Equipo:=Equipo;
        end SetId;

        RandomDelay;

        -- Aviso que llegue
        Coordinador.llegue(Equipo);

        -- Esperar a que este mi equipo
        accept Barrera;

        -- Juntar monedas
        for I in 1..15 loop
            Monto:=Monto+RandomInt;
        end loop;

        -- Informar Monto
        Coordinador.SumarMonto(Monto, Equipo);

        -- Obtener el ganador
        accept GrupoMax(M: IN Integer) do
            Put_Line("Gano el equipo "& Integer'Image(M));
        end GrupoMax;
    end Persona;


begin
    for I in 1..20 loop
        Personas(I).SetId(I, GetGrupo(I));
    end loop;
end Ej5;

