with Ada.Text_IO;              use Ada.Text_IO;
with Ada.Numerics.Discrete_Random;

procedure ej3 is
    cant : Integer := 2;

    function RandomInt return Integer is
        package Random_Int is new Ada.Numerics.Discrete_Random(Integer);
        Gen  : Random_Int.Generator;
        Dato : Integer;
    begin
        Random_Int.Reset(Gen);
        return Random_Int.Random(Gen) mod 1000;
    end RandomInt;

    -------------------------------------------------
    -- Timer
    -------------------------------------------------
    task Timer is
        entry Start;
        entry Finish;
    end Timer;

    task body Timer is
    begin
        loop
            accept Start;
            Put_Line("Timer Start");
            delay 10.0;
            Put_Line("Timer Finish");
            accept Finish;
        end loop;
    end Timer;

    -------------------------------------------------
    -- Central
    -------------------------------------------------
    task Central is
        entry Signal1(S: IN Integer);
        entry Signal2(S: IN Integer);
    end Central;

    task body Central is
    begin
        accept Signal1(S: IN Integer);
        Put_Line("Got signal 1, starting...");
        loop
            select
                accept Signal1(S: IN Integer) do
                    Put_Line("Received signal 1");
                end Signal1;
            or
                accept Signal2(S: IN Integer) do
                    Put_Line("Received signal 2");
                    Timer.Start; -- Start timer
                end Signal2;

                loop
                    select
                        Timer.Finish;
                        exit; -- Si termino el timer salir
                    else -- Si no termino el timer, seguir aceptando Signal2
                        accept Signal2(S: IN Integer);
                        Put_Line("Received signal 2");
                        delay 1.0;
                    end select;
                end loop;
            end select;
            delay 1.0;
        end loop;
    end Central;

    task Proceso1;
    task body Proceso1 is
    begin
        loop
            select
                Central.Signal1(RandomInt); -- Esperar a enviar 2' o desechar
            or delay 2.0;
                null;
            end select;
            delay 2.0;
        end loop;
    end Proceso1;

    task Proceso2;
    task body Proceso2 is
        S: Integer;
    begin

        S := RandomInt;
        loop
            select
                Central.Signal2(S); -- Enviar inmediatamente
                S := RandomInt;
            else
                null;
                delay 1.0; -- Sino esperar y reintentar
            end select;
            delay 1.0; -- Anti Spam
        end loop;
    end Proceso2;

begin
    null; -- Let tasks run
end ej3;
