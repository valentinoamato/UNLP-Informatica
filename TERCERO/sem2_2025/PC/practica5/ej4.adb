with Ada.Text_IO;              use Ada.Text_IO;
with Ada.Numerics.Discrete_Random;

procedure ej4 is
    cant : Integer := 2;

    function RandomInt return Integer is
        package Random_Int is new Ada.Numerics.Discrete_Random(Integer);
        Gen  : Random_Int.Generator;
        Dato : Integer;
    begin
        Random_Int.Reset(Gen);
        return Random_Int.Random(Gen) mod 1000;
    end RandomInt;

    task Consultorio is
        entry Dejar(N: IN Integer);
        entry Tomar(N: OUT Integer);
    end Consultorio;
    task body Consultorio is
        Notas: array (0 .. 2000) of Integer;
        I: Integer := 0; -- Indice Dejar
        J: Integer := 0; -- Indice Tomar
        C: Integer := 0; -- Cantidad
    begin
        loop
            select
                accept Dejar(N: IN Integer) do
                    Notas(I) := N; -- Tomar la nota
                    I:=I+1;
                    C:=C+1;
                    Put_Line("Nota Dejada");
                end Dejar;
            or
                when(C > 0) => accept Tomar(N: OUT Integer) do
                    N:= Notas(J); -- Dejar la nota
                    I:=I+1;
                    C:=C-1;
                    Put_Line("Nota Tomada");
                end Tomar;
            end select;
        end loop;
    end Consultorio;

    task Medico is
        entry AtencionP(A: IN Integer);
        entry AtencionE(A: IN Integer);
    end Medico;

    task body Medico is
        Nota: Integer;
    begin
        loop
            select
                accept AtencionP(A: IN Integer) do
                    Put_Line("Atendiendo Persona.");
                end AtencionP;
            or
                accept AtencionE(A: IN Integer) do
                    Put_Line("Atendiendo Enfermera.");
                end AtencionE;
            else
                select -- Si no hay personas o enfermeras esperando
                    Consultorio.Tomar(Nota);
                    Put_Line("Tomando Nota.");
                else -- Si no hay notas continuar
                    null;
                end select;
            end select;
            delay 2.0;
        end loop;
    end Medico;

    task type Persona;
    task body Persona is
    begin
        for I in 1 .. 3 loop
            select
                Medico.AtencionP(RandomInt);
                exit;
            or delay 3.0; -- Espera a que lo atiendan
                delay 3.0; -- Si no lo atienden espera y intenta devuelta
            end select;
        end loop;
        Put_Line("Persona Se Va");
    end Persona;
    Personas: array(1..5) of Persona;

    task type Enfermera;
    task body Enfermera is
        Nota: Integer;
    begin
        loop
            Nota := RandomInt;
            select
                Medico.AtencionE(Nota);
            else -- Si no la antiendo el medico, deja la nota
                Consultorio.Dejar(Nota); -- Si no la atienden deja la nota
            end select;
            delay 4.0;
        end loop;
    end Enfermera;
    Enfermeras: array(1..2) of Enfermera;

begin
    null; -- Let tasks run
end ej4;

