program parcial4;
type
    registroLectura = record
        codigo: integer;
        factura: integer;
        cant: integer;
        monto: real;
    end;
    registroLista = record
        factura: integer;
        cant: integer;
        monto: real;
    end;
    lista = ^nodoLista;
    nodoLista = record
        dato: registroLista;
        sig: lista;
    end;
    registroArbol = record
        codigo: integer;
        l: lista;
    end;
    arbol = ^nodoArbol;
    nodoArbol = record
        dato: registroArbol;
        hi: arbol;
        hd: arbol;
    end;
procedure leerCompra(var r: registroLectura);
begin
    r.codigo:= Random(20);
    if(r.codigo <> 0) then
        begin
            r.factura:= Random(50)+1;
            r.cant:= Random(10)+5;
            r.monto:= r.cant * 25;
        end;
end;
procedure buscarHoja(var a, h: arbol; codigo: integer);
begin
    if(a=nil) or (a^.dato.codigo = codigo) then
        begin
            if(a=nil) then
                begin
                    new(a);
                    a^.hi:= nil;
                    a^.hd:= nil;
                    a^.dato.codigo:= codigo;
                    a^.dato.l:= nil;
                end;
            h:= a;
        end
    else
        if(codigo < a^.dato.codigo) then
            buscarHoja(a^.hi, h, codigo)
        else
            buscarHoja(a^.hd, h, codigo);
end;
procedure convertirRegistro(reg: registroLectura; var regL: registroLista);
begin
    regL.factura:= reg.factura;
    regL.monto:= reg.monto;
    regL.cant:= reg.cant;
end;
procedure agregarAdelante(var l: lista; reg: registroLista);
var
    aux: lista;
begin
    new(aux);
    aux^.sig:= l;
    l:= aux;
    aux^.dato:= reg;
end;
procedure cargarArbol(var a: arbol);
var
    reg: registroLectura;
    regL: registroLista;
    hoja: arbol;
begin
    leerCompra(reg);
    while(reg.codigo <> 0 ) do
        begin
            buscarHoja(a, hoja, reg.codigo);
            convertirRegistro(reg, regL);
            agregarAdelante(hoja^.dato.l, regL);
            leerCompra(reg);
        end;
end;
procedure clienteLista(l: lista; var cantTotal: integer; var montoTotal: real);
begin
    while(l<>nil) do
        begin
            cantTotal:= cantTotal + l^.dato.cant;
            montoTotal:= montoTotal + l^.dato.monto;
            l:= l^.sig;
        end;
end;
procedure clienteCompras(a: arbol; codigo: integer; var cantTotal: integer; var montoTotal: real);
begin
    if(a<>nil) then
        begin
            if(a^.dato.codigo = codigo) then
                clienteLista(a^.dato.l, cantTotal, montoTotal)
            else
                if(codigo < a^.dato.codigo) then
                    clienteCompras(a^.hi, codigo, cantTotal, montoTotal)
                else
                    clienteCompras(a^.hd, codigo, cantTotal, montoTotal);
        end;
end;
procedure evaluarLista(l: lista; factura1, factura2: integer; var lisVentas: lista);
begin
    while(l<>nil) do
        begin
            if(l^.dato.factura >= factura1) and (l^.dato.factura <= factura2) then
                agregarAdelante(lisVentas, l^.dato);
            l:= l^.sig;
        end;
end;
procedure entreDosFacturas(a: arbol; factura1, factura2: integer; var lisVentas: lista);
begin
    if(a<>nil) then
        begin
            evaluarLista(a^.dato.l, factura1, factura2, lisVentas);
            entreDosFacturas(a^.hi, factura1, factura2, lisVentas);
            entreDosFacturas(a^.hd, factura1, factura2, lisVentas);
        end;
end;
procedure imprimirLista(l: lista);
begin
    while(l<>nil) do
        begin
            write('FACTURA=', l^.dato.factura, ' CANT=', l^.dato.cant, ' MONTO=', l^.dato.monto:0:2, ' - ');
            l:= l^.sig;
        end;
end;
procedure imprimirNodo(r: registroArbol);
begin
    write('CODIGO=', r.codigo, ' Lista:');
    imprimirLista(r.l);
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
procedure verificar(var num1, num2: integer);
var
    aux: integer;
begin
    if(num1 > num2) then
        begin
            aux:= num1;
            num1:= num2;
            num2:= aux;
        end;
end;
var
    a: arbol;
    l: lista;
    cantTotal, f1, f2, codigo: integer;
    montoTotal: real;
begin
    Randomize;
    a:= nil;
    cargarArbol(a);
    imprimirArbol(a);
    writeln('Ingrese un codigo de cliente');
    readln(codigo);
    cantTotal:= 0;
    montoTotal:= 0;
    clienteCompras(a, codigo, cantTotal, montoTotal);
    writeln('El cliente con codigo ', codigo, ' gasto un total de ', montoTotal:0:2, ' en ', cantTotal, ' compras durante el 2023');
    l:= nil;
    writeln('Ingrese un primer numero de factura');
    readln(f1);
    writeln('Ingrese un segundo numero de factura');
    readln(f2);
    verificar(f1, f2);
    entreDosFacturas(a, f1, f2, l);
    writeln('Lista de las ventas entre las facturas con numero ', f1, ' y ', f2, ':');
    imprimirLista(l);
end.