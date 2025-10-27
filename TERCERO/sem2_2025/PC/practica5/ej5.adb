with Ada.Text_IO;
use Ada.Text_IO;

with Ada.Numerics.Discrete_Random;

function RandomInt return Integer is
    package Random_Int is new Ada.Numerics.Discrete_Random(Integer);
    Gen  : Random_Int.Generator;
    Dato : Integer;
begin
    Random_Int.Reset(Gen);
    return Random_Int.Random(Gen) mod 1000;
end RandomInt;

procedure Ej5 is
    cant: Integer := 20;

    task Coordinador is
        entry Llegue(Equipo: OUT Integer);
        entry SumarMonto(M: IN Integer, Equipo: IN Integer);
    end Coordinador;
    task body Coordinador is
        cant: array(1..5) of Integer; --Cant integrantes
        montos: array(1..5) of Integer; --Monto de cada equipo
        aux: Integer;
    begin
        for I in 1..20 loop
            Persona(I).SetId(I, I mod 4);
        end loop;

        for I in 1..20 loop
            accept GetId(Id: OUT Integer; Equipo: OUT Integer) do
                Id:=I;
                Equipo:=I mod 4;
                aux:=equipo;
                cant(Equipo):=cant(Equipo)+1;
            end GetId;
            if Cant(aux) = 4 then
                for J in 1..4 do
                    Persona(aux * J).Barrera;
                end loop;
            end if;
        end loop;

        for I in 1..20 loop
            accept SumarMonto(M: IN Integer; Equipo: IN Integer) do
                montos(Equipo):=montos(Equipo)+M;
            end GetId;
        end loop;

        if montos(1)>montos(2) and montos(1) > montos(3) and montos(1) > montos(4) then
            aux:=1;

        if montos(2)>montos(1) and montos(2) > montos(3) and montos(2) > montos(4) then
            aux:=2;

        if montos(3)>montos(1) and montos(3) > montos(2) and montos(3) > montos(4) then
            aux:=3;
        else
            aux:=4;
        end if

        for I in 1..20 loop
            Persona(I).GrupoMax(aux);
        end loop;

    end Coordinador;

    task type Persona is
        entry SetId(Id: OUT Integer; Equipo: OUT Integer);
        entry Barrera;
        entry GrupoMax(M: IN Integer);
    end Persona;
    task body Persona is
    begin
        Random_Int.Reset(Gen);
        Dato := (Random_Int.Random(Gen) mod 3) + 1;
        Put_Line("Persona tipo" & Integer'Image(Dato) & " pasando.");
        case Dato is
            when 1 =>
                Control.auto;
            when 2 =>
                Control.camioneta;
            when 3 =>
                Control.camion;
            when others =>
                null;
        end case;

        delay 1.0;

        Control.salida(Dato);
    end Persona;

    Personas: array(1..cant) of vehiculo;

begin
    null;
end Ej5;

