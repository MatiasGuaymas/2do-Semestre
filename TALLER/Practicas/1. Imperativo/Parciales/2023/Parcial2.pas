program parcial2;
type
    subMes = 1..12;
    registroLectura = record
        codigo: integer;
        mes: subMes;
        monto: real;
    end;
    vecMonto = array[subMes] of real;
    registroArbol = record
        codigo: integer;
        vec: vecMonto;
    end;
    arbol = ^nodo;
    nodo = record
        dato: registroArbol;
        hi: arbol;
        hd: arbol;
    end;
procedure leerCompra(var r: registroLectura);
begin
    r.codigo:= Random(10);
    if(r.codigo <> 0) then
        begin
            r.mes:= Random(12)+1;
            r.monto:= r.codigo * 30;
        end;
end;
procedure inicializarVector(var v: vecMonto);
var
    i: subMes;
begin
    for i:= 1 to 12 do v[i]:= 0;
end;
procedure agregarArbol(var a, h: arbol; codigo: integer);
begin
    if(a=nil) or (a^.dato.codigo = codigo) then
        begin
            if(a=nil) then
                begin
                    new(a);
                    a^.hi:= nil;
                    a^.hd:= nil;
                    a^.dato.codigo:= codigo;
                    inicializarVector(a^.dato.vec);
                end;
            h:= a;
        end
    else
        if(codigo < a^.dato.codigo) then
            agregarArbol(a^.hi, h, codigo)
        else
            agregarArbol(a^.hd, h, codigo);
end;
procedure agregarMonto(var v: vecMonto; monto: real; mes: integer);
begin
    v[mes]:= v[mes] + monto;
end;
procedure imprimirCompra(r: registroLectura);
begin
    writeln('CODIGO=', r.codigo, ' MES=', r.mes, ' MONTO=', r.monto:0:2);
end;
procedure cargarArbol(var a: arbol);
var
    reg: registroLectura;
    hoja: arbol;
begin
    leerCompra(reg);
    //imprimirCompra(reg);
    while(reg.codigo <> 0 ) do
        begin
            agregarArbol(a, hoja, reg.codigo);
            agregarMonto(hoja^.dato.vec, reg.monto, reg.mes);
            leerCompra(reg);
            //imprimirCompra(reg);
        end;
end;
procedure evaluarMax(v: vecMonto; var mesMax: subMes);
var
    max: real;
    i: subMes;
begin
    max:= -1;
    for i:= 1 to 12 do
        begin
            if(v[i] > max) then
                begin
                    max:= v[i];
                    mesMax:= i;
            end;
        end;
end;
procedure mayorMesCliente(a: arbol; codigo: integer; var mesMax: subMes);
begin
    if(a<>nil) then
        begin
            if(a^.dato.codigo = codigo) then
                evaluarMax(a^.dato.vec, mesMax)
            else
                if(codigo < a^.dato.codigo) then
                    mayorMesCliente(a^.hi, codigo, mesMax)
                else
                    mayorMesCliente(a^.hd, codigo, mesMax);
        end;
end;
procedure ningunGastoMes(a: arbol; mes: subMes; var cantCero: integer);
begin
    if(a<>nil) then
        begin
            if(a^.dato.vec[mes] = 0) then
                cantCero:= cantCero + 1;
            ningunGastoMes(a^.hi, mes, cantCero);
            ningunGastoMes(a^.hd, mes, cantCero);
        end;
end;
procedure imprimirVector(v: vecMonto);
var
    i: subMes;
begin
    for i:= 1 to 12 do write(i, '. ', v[i]:0:2, ' - ');
end;
procedure imprimirNodo(r: registroArbol);
begin
    write('CODIGO=' , r.codigo, ' MONTOS=');
    imprimirVector(r.vec);
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
    codigo, cantCero: integer;
    mesMax, mes: subMes;
begin
    Randomize;
    a:= nil;
    cargarArbol(a);
    imprimirArbol(a);
    writeln('Ingrese un codigo de cliente');
    readln(codigo);
    mayorMesCliente(a, codigo, mesMax);
    writeln('El mes con mayor gasto del cliente con codigo ', codigo, ' fue el numero: ', mesMax);
    writeln('Ingrese un numero de mes');
    readln(mes);
    cantCero:= 0;
    ningunGastoMes(a, mes, cantCero);
    writeln('La cantidad de clientes que no gastaron nada en dicho mes es: ', cantCero);
end.