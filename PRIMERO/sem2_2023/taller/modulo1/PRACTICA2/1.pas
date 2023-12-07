program ejercicio1;
type 
    tipovector = array [1..10] of char;

    tipolista =^ tiponodo;
    tiponodo = record 
        sig:tipolista;
        dato:char;
    end;

procedure leerChar(var c:char);
begin 
    write('Ingrese un caracter ("."):');
    readln(c);
end;

procedure moduloa(var vector:tipovector;var diml:integer);
var 
    i:integer;
    c:char;
begin 
    i:=1;
    leerChar(c);
    while (i<10) and (c<>'.') do 
        begin 
            vector[i]:=c;
            leerChar(c);
            i:=i+1;
        end;
    diml:=i-1;
end;

procedure modulob(vector:tipovector;diml:integer);
var 
    i:integer;
begin 
    for i:=1 to diml do 
        writeln(i,': ',vector[i]);
end;

procedure moduloc(vector:tipovector;diml:integer;inicio:integer);
begin 
    if (inicio<=diml) then
        begin
            writeln(inicio,': ',vector[inicio]);
            moduloc(vector,diml,inicio+1);
        end;
end;

function modulod():integer;
var 
    c:char;
begin 
    leerChar(c);
    if (c<>'.') then 
        modulod:=modulod()+1
    else 
        modulod:=0;
end;

procedure agregar(var pri:tipolista;c:char);
var 
    aux:tipolista;
begin 
    new(aux);
    aux^.sig:=pri;
    aux^.dato:=c;
    pri:=aux;
end;

procedure moduloe(var pri:tipolista);
var 
    c:char;
begin 
    leerChar(c);
    if (c<>'.') then 
        begin 
            agregar(pri,c);
            moduloe(pri);
        end
end;

procedure modulof(pri:tipolista);
begin 
    if (pri<>nil) then 
        begin 
            writeln(pri^.dato);
            modulof(pri^.sig);
        end;
end;

procedure modulog(pri:tipolista);
begin 
    if (pri<>nil) then 
        begin 
            modulog(pri^.sig);
            writeln(pri^.dato);
        end;
end;

var 
    pri:tipolista;
    diml:integer;
    vector:tipovector;
begin
    pri:=nil;

    writeln('Modulo A:');
    moduloa(vector,diml);

    writeln('Modulo B:');
    modulob(vector,diml);

    writeln('Modulo C:');
    moduloc(vector,diml,1);

    writeln('Modulo D:',modulod());

    writeln('Modulo E:');
    moduloe(pri);

    writeln('Modulo F:');
    modulof(pri);

    writeln('Modulo G:');
    modulog(pri);
end.


