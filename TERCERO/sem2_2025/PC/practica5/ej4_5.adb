with Ada.Text_IO;              use Ada.Text_IO;
with Ada.Numerics.Discrete_Random;

procedure ej4_5 is
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
        entry Presentar(N: IN Integer; E: OUT Boolean);
    end Servidor;
    task body Servidor is
    begin
        loop
            accept Presentar(N: IN Integer; E: OUT Boolean) do
                -- "Procesar Trabajo"
                if (N < 500) then
                    E := True;
                else
                    E := False;
                end if;
                Put_Line("Resultado: " & Boolean'image(E));
            end Presentar;
            delay 1.0;
        end loop;
    end Servidor;

    task type Usuario;
    task body Usuario is
        Doc: Integer;
        Continuar: Boolean := True;
        Error: Boolean;
    begin
        Doc := RandomInt; -- "Trabajar en el documento"
        while Continuar loop
            select
                Servidor.Presentar(Doc, Error); -- Presentar el documento
                if not Error then
                    Put_Line("Presentacion terminada");
                    Continuar := False;
                else
                    -- Si hay un error, "vuelvo a trabajar en el documento"
                    Doc := RandomInt;
                end if;
            or delay 2.0; -- Espera a que lo atiendan
                delay 2.0; -- Si no lo atienden espera y intenta devuelta
            end select;
            delay 1.0;
        end loop;
    end Usuario;

    Usuarios: array(1..5) of Usuario;


begin
    null; -- Let tasks run
end ej4_5;

