program final;
type
    fec = record
        dia: integer;
        mes: integer;
        anio: integer;
    end;
    recital = record
        nombre: integer;
        fecha: fec;
        cant: integer;
        monto: real;
    end;
    arbol = ^nodoArb;
    nodoArb = record
        dato: recital;
        hi: arbol;
        hd: arbol;
    end;
    lista = ^nodoLista;
    nodoLista = record
        dato: recital;
        sig: lista;
    end;
procedure leerRecital(var r:recital);
begin
	r.nombre:= Random(100);
	r.fecha.dia:= Random(31) + 1;
	r.fecha.mes:= Random(12) + 1;
	r.fecha.anio:= Random(24) + 2000;
	r.cant:= Random(20) + 10;
	r.monto:= ((Random(2000) + 7000) * 0.07);
end;
procedure agregarArbol(var a: arbol; r: recital);
begin
    if(a = nil) then
        begin
            new(a);
            a^.hi:= nil;
            a^.hd:= nil;
            a^.dato:= r;
        end
    else
        if(r.monto <= a^.dato.monto) then
            agregarArbol(a^.hi, r)
        else
            agregarArbol(a^.hd, r);
end;
procedure cargarArbol(var a: arbol);
var
    i: integer;
    r: recital;
begin
    for i:= 1 to Random(10)+5 do
        begin
            leerRecital(r);
            agregarArbol(a, r);
        end;
end;
procedure imprimirRecital(r: recital);
begin
    writeln('Monto=', r.monto:0:2,' Nombre=', r.nombre, ' Cant=', r.cant);
end;
procedure imprimirArbol(a: arbol);
begin
    if(a<>nil) then
        begin
            imprimirArbol(a^.hi);
            imprimirRecital(a^.dato);
            imprimirArbol(a^.hd);
        end;
end;
procedure verificar(var n1, n2: real);
var
    aux: real;
begin
    if(n1 > n2) then
        begin
            aux:= n1;
            n1:= n2;
            n2:= aux;
        end;
end;
procedure insertarOrdenado(var l: lista; r: recital);
var
    aux, ant, act: lista;
begin
    new(aux); aux^.sig:= nil; aux^.dato:= r;
    if(l = nil) then l:= aux
    else
        begin
            act:= l;
            while(act<>nil) and (act^.dato.monto > aux^.dato.monto) do
                begin
                    ant:= act;
                    act:= act^.sig;
                end;
            if(l = act) then
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
procedure entreDosValores(a: arbol; num1, num2: real; var l: lista);
begin
    if(a <> nil) then
        begin
            if(a^.dato.monto >= num1) and (a^.dato.monto <= num2) then
                begin
                    insertarOrdenado(l, a^.dato);
                    entreDosValores(a^.hi, num1, num2, l);
                    entreDosValores(a^.hd, num1, num2, l);
                end
            else
                if(a^.dato.monto > num1) then
                    entreDosValores(a^.hi, num1, num2, l)
                else
                    entreDosValores(a^.hd, num1, num2, l);
        end;
end;
procedure imprimirLista(l: lista);
begin
    while(l<>nil) do
        begin
            imprimirRecital(l^.dato);
            l:= l^.sig;
        end;
end;
function masDeDoceCanciones(l: lista): integer;
begin
    if(l<>nil) then
        begin
            if(l^.dato.cant < 12) then 
                masDeDoceCanciones:= masDeDoceCanciones(l^.sig)
            else 
                masDeDoceCanciones:= 1 + masDeDoceCanciones(l^.sig);
        end
    else
        masDeDoceCanciones:= 0;
end; 
var
    a: arbol;
    l: lista;
    num1, num2: real;
begin
    Randomize;
    a:= nil;
    cargarArbol(a);
    imprimirArbol(a);
    l:= nil;
    writeln('Ingrese un primer valor');
    readln(num1);
    writeln('Ingrese un segundo valor');
    readln(num2);
    verificar(num1, num2);
    entreDosValores(a, num1, num2, l);
    writeln('Lista con los recitales entre los montos: ', num1:0:2, ' y ', num2:0:2);
    imprimirLista(l);
    writeln('A partir de la lista anterior, la cantidad de recitales que tocaron mas de 12 canciones es: ', masDeDoceCanciones(l));
end.