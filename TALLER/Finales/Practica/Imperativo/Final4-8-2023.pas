program final;
type
    dir = record
        calle: integer;
        altura: integer;
    end;
    subCat = 1..6;
    subMes = 1..12;
    subDia = 1..31;
    subHora = 1..24;
    denuncia = record
        categoria: subCat;
        dni: integer;
        direccion: dir;
        mes: subMes;
        dia: subDia;
        hora: subHora;
    end;
    denunciaLista = record
        dni: integer;
        direccion: dir;
        mes: subMes;
        dia: subDia;
        hora: subHora;
    end;
    lista = ^nodo;
    nodo = record
        dato: denunciaLista;
        sig: lista;
    end;
    vecDenuncias = array[subCat] of lista;
    regCalle = record
        numCalle: integer;
        cantTotal: integer;
    end;
    listaCalles = ^nodoCalles;
    nodoCalles = record
        dato: regCalle;
        cant: integer;
        sig: listaCalles;
    end;
procedure leerDenuncia(var d: denuncia);
begin
    d.dni:= Random(30);
    if(d.dni <> 0) then
        begin
            d.categoria:= Random(6)+1;
            d.direccion.calle:= Random(30)+1;
            d.direccion.altura:= Random(100)+1;
            d.mes:= Random(12)+1;
            d.dia:= Random(31)+1;
            d.hora:= Random(24)+1;
        end;
end;
procedure agregarDenuncia(var l: lista; d: denunciaLista);
var
    aux, ant, act: lista;
begin
    new(aux); aux^.sig:= nil; aux^.dato:= d;
    if(l = nil) then l:= aux
    else
        begin
            act:= l;
            while(act<>nil) and (act^.dato.direccion.calle < aux^.dato.direccion.calle) do
                begin
                    ant:= act;
                    act:= act^.sig;
                end;
            if(act = l) then
                begin
                    aux^.sig:= l;
                    l:= aux;
                end
            else
                begin
                    ant^.sig:= aux;
                    aux^.sig:= act;
                end;
        end;
end;
procedure construirRegistro(denLeer: denuncia; var denLista: denunciaLista);
begin
    denLista.dni:= 3.dni;
    denLista.direccion:= denLeer.direccion;
    denLista.mes:= denLeer.mes;
    denLista.hora:= denLeer.hora;
    denLista.dia:= denLeer.dia;
end;
procedure cargarVector(var v: vecDenuncias);
var
    denLeer: denuncia;
    denLista: denunciaLista;
begin
    leerDenuncia(denLeer);
    while(denLeer.dni<>0) do
        begin
            construirRegistro(denLeer, denLista);
            agregarDenuncia(v[denLeer.categoria], denLista);
            leerDenuncia(denLeer);
        end;
end;
procedure inicializarVector(var v: vecDenuncias);
var
    i: subCat;
begin
    for i:= 1 to 6 do v[i]:= nil;
end;
procedure imprimirDenuncias(l: lista);
begin
    while(l <> nil) do
        begin
            write('Calle=', l^.dato.direccion.calle, ' Dni=', l^.dato.dni, ' Dia=', l^.dato.dia, ' Mes=', l^.dato.mes, ' Hora=', l^.dato.hora, ' | ');
            l:= l^.sig;
        end;
end;
procedure imprimirVector(v: vecDenuncias);
var
    i: subCat;
begin
    for i:= 1 to 6 do
        begin
            if(v[i] <> nil) then
                begin
                    write(i, '. ');
                    imprimirDenuncias(v[i]);
                    writeln();
                end;
        end;
end;
procedure nuevoInsertar(calle: integer; var lis: listaCalles);
var
    aux, ant, act: listaCalles;
begin
    act:= lis;
    while(act <> nil) and (act^.dato.numCalle < calle) do
        begin
            ant:= act;
            act:= act^.sig;
        end;
    if(act <> nil) and (act^.dato.numCalle = calle) then
        act^.dato.cantTotal:= act^.dato.cantTotal + 1
    else
        begin
            new(aux);
            aux^.dato.numCalle:= calle;
            aux^.dato.cantTotal:= 1;
            aux^.sig:= act;
            if(lis = act) then
                lis:= aux
            else
                ant^.sig:= aux;
        end;
end;
procedure generarNuevaLista(l: lista; var lis: listaCalles; var denJulio: integer);
begin
    while(l<>nil) do
        begin
            nuevoInsertar(l^.dato.direccion.calle, lis);
            if(l^.dato.mes = 7) then
                denJulio:= denJulio + 1;
            l:= l^.sig;
        end;
end;
procedure cantTotalCalles(v: vecDenuncias; var l: listaCalles);
var
    denJulio: integer;
    i: subCat;
begin
    denJulio:= 0;
    for i:= 1 to 6 do
        begin
            generarNuevaLista(v[i], l, denJulio);
        end;
    l^.cant:= denJulio;
end;
procedure imprimirLista(l: listaCalles);
begin
    while(l<>nil) do
        begin
            writeln('Calle=', l^.dato.numCalle, ' CantTotal=', l^.dato.cantTotal);
            l:= l^.sig;
        end;
end;
procedure calcularCalleMax(l: listaCalles; var max, calleMax: integer);
begin
    if(l<>nil) then
        begin
            if(l^.dato.cantTotal > max) then
                begin
                    max:= l^.dato.cantTotal;
                    calleMax:= l^.dato.numCalle;
                end;
            calcularCalleMax(l^.sig, max, calleMax);
        end;
end;
var
    v: vecDenuncias;
    l: listaCalles;
    max, calleMax: integer;
begin
    Randomize;
    inicializarVector(v);
    cargarVector(v);
    imprimirVector(v);
    l:= nil;
    cantTotalCalles(v, l);
    writeln('Cantidad total de denunciadas hechas en el mes de Julio: ', l^.cant);
    imprimirLista(l);
    max:= -1;
    calcularCalleMax(l, max, calleMax);
    writeln('El numero de calle con mayor cantidad de denuncias totales es:', calleMax);
end.