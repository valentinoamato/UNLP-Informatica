with Ada.Text_IO;
use Ada.Text_IO;

with Ada.Numerics.Discrete_Random;

procedure Ej2 is
P: Integer:=10;
type IntP is array (1..P) of Integer;

task type Persona is
    entry SetId(Id: IN Integer);
    entry Resultado(Vuelto: IN Integer; Recibo: IN Integer);
end Persona;

Personas: array(1..P) of Persona;

task Cola is
    entry Esperar(Boletas: IN Integer; Dinero: IN Integer; Tipo: IN Integer; Id: IN Integer);
    entry Next(Boletas: OUT Integer; Dinero: OUT Integer; Id: OUT Integer);
end Cola;

task Caja;

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
    delay Duration(RandomInt) / 50.0;
end RandomDelay;

function GetTipo return Integer is --1: Embarazada, 2:Pocos Items, 3:Normal
begin
    return ((RandomInt - 1) mod 3) + 1;
end GetTipo;

task body Caja is
    Id: Integer;
    Boletas: Integer;
    Recibo: Integer;
    Dinero: Integer;
    Tipo: Integer;
begin

    for i in 1..P loop
        Cola.Next(Boletas, Dinero, Id);
        Put_Line("Atendiendo Persona "&Integer'Image(Id));
        --Resolver pedido
        Dinero:=Dinero-RandomInt;
        Recibo:=RandomInt;
        --Enviar Resultado
        Personas(Id).Resultado(Dinero, Recibo);
        delay 0.5; --Anti Spam
    end loop;
end Caja;

task body Persona is
    Id: Integer;
    Boletas: Integer;
    Recibo: Integer;
    Dinero: Integer;
    Tipo: Integer;
begin
    -- Recibir Id
    accept SetId(Id: IN Integer) do
        Persona.Id:=Id;
    end SetId;

    RandomDelay;

    Boletas:=RandomInt;
    Dinero:=RandomInt;
    Tipo:=GetTipo;

    Cola.Esperar(Boletas, Dinero, Tipo, Id);
    Put_Line("Persona "&Integer'Image(Id)&", Tipo: "&Integer'Image(Tipo)&" Esperando");
    accept Resultado(Vuelto: IN Integer; Recibo: IN Integer) do
        Dinero:=Vuelto;
        Persona.Recibo:=Recibo;
    end Resultado;

    Put_Line("Persona "&Integer'Image(Id)&", Tipo: "&Integer'Image(Tipo)&" Recibio resultado");
end Persona;

task body Cola is
    Ids1: array(1..1000) of Integer; --Ids de embarazadas
    Boletas1: array(1..1000) of Integer; --Boletas de las embarazadas
    Dinero1: array(1..1000) of Integer; --Dinero de las embarazadas
    i1: Integer:=1; --Embarazada a guardar
    j1: Integer:=1; --Embarazada a atender
    c1: Integer:=0; --Embarazadas en la cola

    Ids2: array(1..1000) of Integer; --Ids de Personas B<5s
    Boletas2: array(1..1000) of Integer; --Boletas de las Personas B<5s
    Dinero2: array(1..1000) of Integer; --Dinero de las Personas B<5s
    i2: Integer:=1; --Persona B<5 a guardar
    j2: Integer:=1; --Persona B<5 a atender
    c2: Integer:=0; --Personas B<5 en la cola

    Ids3: array(1..1000) of Integer; --Ids de personas normales
    Boletas3: array(1..1000) of Integer; --Boletas de las personas normales
    Dinero3: array(1..1000) of Integer; --Dinero de las personas normales
    i3: Integer:=1; --Persona a guardar
    j3: Integer:=1; --Persona  a atender
    c3: Integer:=0; --Personas normales en la cola

    c:Integer:=0; --Personas en la cola
begin
    for i in 1..(P*2) loop
        select
            accept Esperar(Boletas: IN Integer; Dinero: IN Integer; Tipo: IN Integer; Id: IN Integer) do
                if Tipo = 1 then
                    Ids1(i1):=Id;
                    Boletas1(i1):=Boletas;
                    Dinero1(i1):=Dinero;
                    c:=c+1;
                    c1:=c1+1;
                    i1:=i1+1;
                elsif Tipo = 2 then
                    Ids2(i2):=Id;
                    Boletas2(i2):=Boletas;
                    Dinero2(i2):=Dinero;
                    c:=c+1;
                    c2:=c2+1;
                    i2:=i2+1;
                else
                    Ids3(i3):=Id;
                    Boletas3(i3):=Boletas;
                    Dinero3(i3):=Dinero;
                    c:=c+1;
                    c3:=c3+1;
                    i3:=i3+1;
                end if;
            end Esperar;
        or
            when c > 0 => accept Next(Boletas: OUT Integer; Dinero: OUT Integer; Id: OUT Integer) do
                if (c1>0) then
                    Boletas:=Boletas1(j1);
                    Id:=Ids1(j1);
                    Dinero:=Dinero1(j1);
                    c1:=c1-1;
                    j1:=j1+1;
                    c:=c-1;
                elsif (c2>0) then
                    Boletas:=Boletas2(j2);
                    Id:=Ids2(j2);
                    Dinero:=Dinero2(j2);
                    c2:=c2-1;
                    j2:=j2+1;
                    c:=c-1;
                else
                    Boletas:=Boletas3(j3);
                    Id:=Ids3(j3);
                    Dinero:=Dinero3(j3);
                    c3:=c3-1;
                    j3:=j3+1;
                    c:=c-1;
                end if;
            end Next;
        end select;
    end loop;
end Cola;

begin
    for I in 1..P loop
        Personas(I).SetId(I);
    end loop;
end Ej2;


