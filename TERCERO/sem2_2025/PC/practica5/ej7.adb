with Ada.Text_IO;
use Ada.Text_IO;

with Ada.Numerics.Discrete_Random;

procedure Ej7 is
type Int8 is array (1..8) of Integer;

task type BD is
    entry SetId(Id: IN Integer);
    entry Analizar(Test: IN Integer; Codigo: OUT Integer; Similitud: OUT Integer);
end BD;

BDs: array(1..8) of BD;

task Especialista is
end Especialista;

function RandomInt return Integer is
    package Random_Int is new Ada.Numerics.Discrete_Random(Integer);
    Gen  : Random_Int.Generator;
    Dato : Integer;
begin
    Random_Int.Reset(Gen);
    return Random_Int.Random(Gen) mod 101;
end RandomInt;

procedure RandomDelay is
begin
    delay Duration(RandomInt) / 20.0;
end RandomDelay;

function GetMax(Similitudes: Int8) return Integer is
    Max: Integer := -10;
    IdMax: Integer:= 0;
begin
    for I in 1..8 loop
        if Similitudes(I) > Max then
            Max:=Similitudes(I);
            IdMax:=I;
        end if;
    end loop;

    return IdMax;
end GetMax;

task body Especialista is
    Test: Integer;
    Similitudes: Int8;
    Codigos: Int8;
    MaxId: Integer;
    J: Integer;
    Exitoso: Boolean;
    Last: Integer;
begin
    loop
        -- Obtener test
        Test:=RandomInt;

        for i in 1..8 loop
            -- Inicializar codigos
            -- Si codigo es -1 se que no lo pedi
            Codigos(i):=-1;
        end loop;

        -- Hacer todas las peticiones
        -- Solo una a cada BD y sin orden
        for i in 1..8 loop
            -- Hacer la request a la BD que este disponible
            Exitoso:=False;
            J:=1;
            -- Buscar una BD que responda instantaneamente
            while (not Exitoso and J<9) loop
                if (codigos(j) = -1) then
                    Last:=j;
                    select
                        BDs(j).Analizar(Test, Codigos(j), Similitudes(j));
                        Put_Line("RECV BD: " & Integer'Image(j)&", Codigo:" & Integer'Image(Codigos(j))&", Similitud: "&Integer'Image(Similitudes(j)));
                        Exitoso:=true;
                    else
                        null;
                    end select;
                end if;
                j:=j+1;
            end loop;

            -- Si ninguna respondio al toque
            -- Esperar a que responda la ultima con la que se probo
            if not Exitoso then
                BDs(Last).Analizar(Test, Codigos(Last), Similitudes(Last));
                Put_Line("RECV BD: " & Integer'Image(Last)&", Codigo:" & Integer'Image(Codigos(Last))&", Similitud: "&Integer'Image(Similitudes(Last)));
            end if;

            delay 0.5; --Anti Spam
        end loop;

        -- Calcular maximo
        MaxId:=GetMax(Similitudes);

        --Informar
        Put_Line("BEST BD: " & Integer'Image(MaxId)&", Codigo:" & Integer'Image(Codigos(MaxId))&", Similitud: "&Integer'Image(Similitudes(MaxId)));
        Put_Line("");

        delay 3.0; --Anti Spam
    end loop;
end Especialista;

task body BD is
    Id: Integer;
begin
    -- Recibir Id
    accept SetId(Id: IN Integer) do
        BD.Id:=Id;
    end SetId;


    loop
        RandomDelay;
        accept Analizar(Test: IN Integer; Codigo: OUT Integer; Similitud: OUT Integer) do
            -- Buscar(test, codigo, valor)
            Codigo:=RandomInt;
            Similitud:=RandomInt;
        end Analizar;
    end loop;
end BD;

begin
    for I in 1..8 loop
        BDs(I).SetId(I);
    end loop;
end Ej7;

