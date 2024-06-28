program parcial3;
type
    registroLectura = record
        vuelo: integer;
        cliente: integer;
        destino: integer;
        monto: real;
    end;
    registroLista = record
        vuelo: integer;
        cliente: integer;
        monto: real;
    end;
    lista = ^nodoLista;
    nodoLista = record
        dato: registroLista;
        sig: lista;
    end;
    regArbol = record
        l: lista;
        destino: integer;
    end;
    arbol = ^nodoArbol;
    nodoArbol = record
        dato: regArbol;
        hi: arbol;
        hd: arbol;
    end;
procedure leerPasaje(var reg: registroLectura);
begin
    reg.monto:= Random(20);
    if(reg.monto <> 0) then
        begin
            reg.vuelo:= Random(50) + 1;
            reg.destino:= Random(10) + 1;
            reg.cliente:= Random(5000) + 1;
        end;
end;
procedure buscarHoja(var a, h: arbol; destino: integer);
begin
    if(a = nil) or (a^.dato.destino = destino) then
        begin
            if(a = nil) then
                begin
                    new(a);
                    a^.hi:= nil;
                    a^.hd:= nil;
                    a^.dato.l:= nil;
                    a^.dato.destino := destino;
                end;
            h:= a;
        end
    else
        if(destino < a^.dato.destino) then
            buscarHoja(a^.hi, h, destino)
        else
            buscarHoja(a^.hd, h, destino);
end;
procedure reasignarRegistro(reg: registroLectura; var regL: registroLista);
begin
    regL.monto:= reg.monto;
    regL.vuelo:= reg.vuelo;
    regL.cliente:= reg.cliente;
end;
procedure agregarAdelante(var l: lista; reg: registroLista);
var
    aux: lista;
begin
    new(aux); aux^.sig:= nil; aux^.dato:= reg;
    if(l=nil) then l:= aux
    else
        begin
            aux^.sig:= l;
            l:= aux;
        end;
end;
procedure cargarArbol(var a: arbol);
var
    reg: registroLectura;
    regL: registroLista;
    hoja: arbol;
begin
    leerPasaje(reg);
    while(reg.monto <> 0) do
        begin
            buscarHoja(a, hoja, reg.destino);
            reasignarRegistro(reg, regL);
            agregarAdelante(hoja^.dato.l, regL);
            leerPasaje(reg);
        end;
end;
procedure listaPasajes(a: arbol; destino: integer; var l: lista);
begin
    if(a<>nil) then
        begin
            if(a^.dato.destino = destino) then
                l:= a^.dato.l
            else
                if(destino < a^.dato.destino) then
                    listaPasajes(a^.hi, destino, l)
                else
                    listaPasajes(a^.hd, destino, l);
        end;
end;
function calcularPasajes(l: lista): integer;
begin
    if(l <> nil) then
        calcularPasajes:= calcularPasajes(l^.sig) + 1
    else
        calcularPasajes:= 0;
end;
procedure cantMaxPasajes(a: arbol; var codMax: integer; var cantMax: integer);
var
    cant: integer;
begin
    if(a<>nil) then
        begin
            cant:= calcularPasajes(a^.dato.l);
            if(cant > cantMax) then
                begin
                    cantMax:= cant;
                    codMax:= a^.dato.destino;
                end;
            cantMaxPasajes(a^.hi, codMax, cantMax);
            cantMaxPasajes(a^.hd, codMax, cantMax);
        end;
end;
procedure imprimirLista(l: lista);
begin
    while(l<>nil) do
        begin
            write('Vuelo=', l^.dato.vuelo, ' Cliente=', l^.dato.cliente, ' Monto=', l^.dato.monto:0:2, ' - ');
            l:= l^.sig;
        end;
end;
procedure imprimirNodo(dato: regArbol);
begin
    write('Destino=', dato.destino, ':');
    imprimirLista(dato.l);
    writeln();
end;
procedure imprimirArbol(a: arbol);
begin
    if(a<>nil) then
        begin
            imprimirArbol(a^.hi);
            imprimirNodo(a^.dato);
            imprimirArbol(a^.hd);
        end;
end;
var
    a: arbol;
    l: lista;
    code, codeMax, cantMax: integer;
begin
    Randomize;
    a:= nil;
    l:= nil;
    cargarArbol(a);
    imprimirArbol(a);
    writeln('Ingrese un codigo de ciudad de destino');
    readln(code);
    listaPasajes(a, code, l);
    writeln('Lista de pasajes de la ciudad de destino con codigo ', code, ':');
    imprimirLista(l);
    writeln();
    cantMax:= -1;
    cantMaxPasajes(a, codeMax, cantMax);
    writeln('El codigo de ciudad de destino con mayor cantidad de pasajes vendidos es: ', codeMax);
end.