program recuperatorioImperativo;
type
    subCode = 1..24;
    partida = record
        mes: integer;
        anio: integer;
        codigo: subCode;
        monto: real;
    end;
    part = record
        mes: integer;
        codigo: subCode;
        monto: real;
    end;
    lista = ^nodoLista;
    nodoLista = record
        dato: part;
        sig: lista;
    end;
    aux = record
        l: lista;
        anio: integer;
    end;
    arbol = ^nodo;
    nodo = record
        dato: aux;
        hi: arbol;
        hd: arbol;
    end;
    prov = record
        monto: real;
        cant: integer;
    end;
    vecProvincias = array [subCode] of prov;
procedure leerPartida(var p: partida);
begin
    p.mes:= Random(12)+1;
    p.anio:= Random(6)+2017;
    p.codigo:= Random(24)+1;
    p.monto:= p.mes * 30;
end;
procedure insertar(var l: lista; p: part);
var
    aux, ant, act: lista;
begin
    new(aux); aux^.dato:= p; act:= l;
    while(act <> nil) and (act^.dato.mes < p.mes) do
        begin
            ant:= act;
            act:= act^.sig;
        end;
    if(act = l) then
        l:= aux
    else
        ant^.sig:= aux;
    aux^.sig:= act;
end;
procedure agregarArbol(var a: arbol; p: partida);
var
    par: part;
begin
    if(a = nil) then
        begin
            new(a);
            a^.hi:= nil;
            a^.hd:= nil;
            a^.dato.l:= nil;
            a^.dato.anio:= p.anio;
            par.mes:= p.mes;
            par.monto:= p.monto;
            par.codigo:= p.codigo;
            insertar(a^.dato.l, par);
        end
    else
        if(a^.dato.anio = p.anio) then
            begin
                par.mes:= p.mes;
                par.monto:= p.monto;
                par.codigo:= p.codigo;
                insertar(a^.dato.l, par);
            end
        else
            if(p.anio < a^.dato.anio) then
                agregarArbol(a^.hi, p)
            else
                agregarArbol(a^.hd, p);
end;
procedure cargarArbol(var a: arbol);
var
    p: partida;
begin
    leerPartida(p);
    while (p.mes <> 12) or (p.anio <> 2022) or (p.codigo <> 24) do
        begin
            agregarArbol(a, p);
            leerPartida(p);
        end;
end;
procedure inicializarVector(var v: vecProvincias);
var
    i: subCode;
begin
    for i:= 1 to 24 do
        begin
            v[i].monto:= 0;
            v[i].cant:= 0;
        end;
end;
procedure contarCantMonto(l: lista; var v: vecProvincias);
begin
    while(l <> nil) do
        begin
            v[l^.dato.codigo].cant:= v[l^.dato.codigo].cant + 1;
            v[l^.dato.codigo].monto:= v[l^.dato.codigo].monto + l^.dato.monto;
            l:= l^.sig;
        end;
end;
procedure cargarVector(a: arbol; var v: vecProvincias);
begin
    if(a <> nil) then
        begin
            contarCantMonto(a^.dato.l, v);
            cargarVector(a^.hi, v);
            cargarVector(a^.hd, v);
        end;
end;
function mayorProv(v: vecProvincias; provMax: subCode; diml, max: integer): subCode;
begin
    if(diml = 0) then
        mayorProv:= provMax
    else
        begin
            if(v[diml].cant > max) then
            begin
                max:= v[diml].cant;
                provMax:= diml;
            end;
            mayorProv:= mayorProv(v, provMax, diml-1, max);
        end;
end;
procedure contarCant(l: lista; mes: integer; var cant: integer);
begin
    while(l<>nil) and (l^.dato.mes < mes) do
        l:= l^.sig;
    while(l<>nil) and (l^.dato.mes = mes) do
        begin
            cant:= cant+1;
            l:= l^.sig;
        end;
end;
procedure cantPartidas(a: arbol; anio1, anio2, mes: integer; var cant: integer);
begin
    if(a<>nil) then
        begin
            if(a^.dato.anio >= anio1) and (a^.dato.anio <= anio2) then
                begin
                    contarCant(a^.dato.l, mes, cant);
                    cantPartidas(a^.hi, anio1, anio2, mes, cant);
                    cantPartidas(a^.hd, anio1, anio2, mes, cant);
                end
            else
                if(a^.dato.anio > anio1) then
                    cantPartidas(a^.hi, anio1, anio2, mes, cant)
                else
                    cantPartidas(a^.hd, anio1, anio2, mes, cant);
        end;
end;
procedure imprimirLista(l: lista);
begin
    while(l<>nil) do
        begin
            write(' | MES=', l^.dato.mes, ' CODIGO=', l^.dato.codigo, ' MONTO=', l^.dato.monto:0:2);
            l:= l^.sig;
        end;
end;
procedure imprimirNodo(a: aux);
begin
    write('Anio=', a.anio);
    imprimirLista(a.l);
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
procedure imprimirVector(v: vecProvincias);
var
    i: subCode;
begin
    for i:= 1 to 24 do
        begin
            writeln(i, '. CANT=', v[i].cant, ' MONTO=', v[i].monto:0:2);
        end;
end;
var
    a: arbol;
    v: vecProvincias;
    provMax: subCode;
    max, anio1, anio2, mes, cant: integer;
begin
    Randomize;
    a:= nil;
    cargarArbol(a);
    imprimirArbol(a);
    writeln('-------------------------');

    inicializarVector(v);
    cargarVector(a, v);
    imprimirVector(v);
    writeln('-------------------------');

    max:= -1;
    writeln('El codigo de la provincia con mayor cantidad de partidas recibidas es: ', mayorProv(v, provMax, 24, max));

    writeln('-------------------------');
    writeln('Ingrese un primer anio');
    readln(anio1);
    writeln('Ingrese un segundo anio');
    readln(anio2);
    writeln('Ingrese un mes');
    readln(mes);
    cant:= 0;
    cantPartidas(a, anio1, anio2, mes, cant);
    writeln('La cantidad total de partidas enviadas a las distintas provincias en el mes ', mes, ' entre el anio ', anio1, ' y ', anio2, ' es: ', cant);
end.