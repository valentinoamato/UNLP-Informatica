with Ada.Text_IO;              use Ada.Text_IO;
with Ada.Strings.Unbounded;    use Ada.Strings.Unbounded;
with Ada.Numerics.Discrete_Random;

procedure Ej2a is
    cant : Integer := 5;

    -- Short name for convenience
    subtype UString is Unbounded_String;

    function GetSolicitud return String is
        package Random_Int is new Ada.Numerics.Discrete_Random(Integer);
        Gen  : Random_Int.Generator;
        Dato : Integer;
    begin
        Random_Int.Reset(Gen);
        Dato := Random_Int.Random(Gen) mod 1000;
        return ("Solicitud" & Integer'Image(Dato));
    end GetSolicitud;

    -------------------------------------------------
    -- EMPLEADO
    -------------------------------------------------
    task Empleado is
        entry RealizarPago(S : in String; C : out UString);
    end Empleado;

    task body Empleado is
    begin
        loop
            accept RealizarPago(S : in String; C : out UString) do
                C := To_Unbounded_String("Comprobante de " & S);
                Put_Line(To_String(C));
            end RealizarPago;
        end loop;
    end Empleado;

    -------------------------------------------------
    -- CLIENTE
    -------------------------------------------------
    task type Cliente;
    task body Cliente is
        Solicitud   : constant String := GetSolicitud;
        Comprobante : UString;
    begin
        Put_Line(Solicitud);
        Empleado.RealizarPago(Solicitud, Comprobante);
        -- Optionally show the comprobante received:
        Put_Line("Cliente recibió: " & To_String(Comprobante));
    end Cliente;

    -- Create all clients
    Clientes : array (1 .. cant) of Cliente;

begin
    null; -- Let tasks run
end Ej2a;

