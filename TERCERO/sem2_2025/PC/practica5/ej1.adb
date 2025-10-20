with Ada.Text_IO;
use Ada.Text_IO;

with Ada.Numerics.Discrete_Random;

procedure Ej1 is
    cant: Integer := 5;

    task Control is
        entry Auto;
        entry Camioneta;
        entry Camion;
        entry Salida(P: IN integer);
    end Control;

    task type Vehiculo;
    task body Vehiculo is
        package Random_Int is new Ada.Numerics.Discrete_Random(Integer);
        Gen  : Random_Int.Generator;
        Dato : Integer;
    begin
        Random_Int.Reset(Gen);
        Dato := (Random_Int.Random(Gen) mod 3) + 1;
        Put_Line("Vehiculo tipo" & Integer'Image(Dato) & " pasando.");
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
    end Vehiculo;

    vehiculos: array(1..cant) of vehiculo;

    task body Control is
        Peso, P : Integer := 0;
    begin
        loop
            select
                when(peso < 5) => accept Auto;
                    peso:=peso+1;

                or when(peso < 4) => accept Camioneta;
                    peso:=peso+2;

                or when(peso < 3) => accept Camion;
                    peso:=peso+3;

                or accept Salida(P: IN integer) do
                    Peso := Peso - P;
                end salida;
            end select;

        Put_Line("Peso actual:" & Integer'Image(Peso));
        end  loop;
    end Control;

begin
    null;
end Ej1;

