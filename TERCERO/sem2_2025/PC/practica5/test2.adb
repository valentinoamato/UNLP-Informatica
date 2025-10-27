with Ada.Text_IO;              use Ada.Text_IO;
with Ada.Numerics.Discrete_Random;

procedure Test2 is
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
                when False => accept SignalA do
                    Put_Line("Signal A");
                end SignalA;
            or
                when False => accept SignalB do
                    Put_Line("Signal B");
                end SignalB;
            else 
                Put_Line("Delay");
            end select;
        end loop;
    end Servidor;

    task type Usuario;
    task body Usuario is
    begin
         loop
            Servidor.SignalA;
            delay 3.0;
        end loop;
    end Usuario;

    Usuarios: array(1..5) of Usuario;


begin
    null; -- Let tasks run
end Test2;


