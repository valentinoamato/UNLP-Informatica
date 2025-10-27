with Ada.Text_IO;              use Ada.Text_IO;
with Ada.Numerics.Discrete_Random;

procedure Test is
    cant : Integer := 2;

    function RandomInt return Integer is
        package Random_Int is new Ada.Numerics.Discrete_Random(Integer);
        Gen  : Random_Int.Generator;
        Dato : Integer;
    begin
        Random_Int.Reset(Gen);
        return Random_Int.Random(Gen) mod 1000;
    end RandomInt;

    task Servidor is
        entry SignalA;
        entry SignalB;
    end Servidor;
    task body Servidor is
    begin
        loop
            delay 3.0;
            select
                accept SignalA do
                    Put_Line("Signal A");
                end SignalA;
            or
                accept SignalB do
                    Put_Line("Signal B");
                end SignalB;
            end select;
        end loop;
    end Servidor;

    task type Usuario;
    task body Usuario is
    begin
         loop
            select
                Servidor.SignalA;
            or
                Servidor.SignalB;
            end select;
            delay 1.0;
        end loop;
    end Usuario;

    Usuarios: array(1..5) of Usuario;


begin
    null; -- Let tasks run
end Test;


