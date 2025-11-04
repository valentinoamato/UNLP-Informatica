with Ada.Text_IO;
use Ada.Text_IO;

with Ada.Numerics.Discrete_Random;

procedure Ej1 is
task type Banco is
    entry SetId(Id: IN Integer);
    entry GetPrecio(Precio: OUT Integer);
end Banco;

Bancos: array(1..20) of Banco;

task BancoCentral;

function RandomInt return Integer is
    package Random_Int is new Ada.Numerics.Discrete_Random(Integer);
    Gen  : Random_Int.Generator;
    Dato : Integer;
begin
    Random_Int.Reset(Gen);
    return ((Random_Int.Random(Gen)-1) mod 100) + 1;
end RandomInt;

procedure RandomDelay is
    num: Integer;
begin
    num := RandomInt mod 10;
    Put_Line(Integer'Image(num));
    -- delay Duration(RandomInt) / 50.0;
    if num  = 5 then
        delay 3.0;
    end if;
end RandomDelay;


task body BancoCentral is
    Precios: array(1..20) of Integer;
begin
    for i in 1..20 loop
        Precios(i):=-1;
    end loop;

    loop
        for i in 1..20 loop
            delay 0.2;
            select
                Bancos(i).GetPrecio(Precios(i));
            or delay 0.5;
                null;
            end select;

        end loop;

        for i in 1..20 loop
            if (Precios(i) = -1) then
                Put_Line("Precio banco "&Integer'Image(i)&": Sin Respuesta");
            else
                Put_Line("Precio banco "&Integer'Image(i)&": "&Integer'Image(Precios(i)));
            end if;
        end loop;

        delay 4.0;
    end loop;
end BancoCentral;

task body Banco is
    Id: Integer;
begin
    -- Recibir Id
    accept SetId(Id: IN Integer) do
        Banco.Id:=Id;
    end SetId;

    loop
        RandomDelay;
        accept GetPrecio(Precio: OUT Integer) do
            Precio:=RandomInt;
        end GetPrecio;
    end loop;
end Banco;

begin
    for I in 1..20 loop
        Bancos(I).SetId(I);
    end loop;
end Ej1;


