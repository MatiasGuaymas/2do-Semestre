program final;
type
    pedido = record
        numero: integer;
        dirRetiro: string;
        dirEntrega: string;
        monto: real;
    end;
    repartidor = record
        numero: integer;
        cantPedidos: integer;
        montoTotal: real;
    end;
    arbol = ^nodo;
    nodo = record
        dato: repartidor;
        hi: arbol;
        hd: arbol;
    end;
procedure leerPedido(var p: pedido);
begin
    writeln('Ingrese un numero de repartidor');
    readln(p.numero);
    writeln('Ingrese una direccion de retiro');
    readln(p.dirRetiro);
    writeln('Ingrese una direccion de entrega');
    readln(p.dirEntrega);
    if(p.dirEntrega <> 'ZZZ') then
        begin
            writeln('Ingrese el monto a cobrar por el servicio');
            readln(p.monto);
        end;
end;

{procedure productoRandom(var p: pedido);
begin
    p.numero:= Random(5)+1;
    p.dirRetiro:= 'aaa';
    p.dirEntrega:= 'bbb';
    p.monto:= ((Random(30)+1)*(p.numero));
end;
}
procedure imprimirPedido(p: pedido);
begin
    writeln('NumRepartidor=', p.numero, ' DirRetiro=', p.dirRetiro, ' DirEntrega=', p.dirEntrega, ' Monto=', p.monto:0:2);
end;

procedure imprimirRepartidor(r: repartidor);
begin
    writeln('NumRepartidor=', r.numero, ' CantPedidos=', r.cantPedidos, ' MontoTotal=', r.montoTotal:0:2);
end;

procedure agregarArbol(var a: arbol; p: pedido);
var
    r: repartidor;
begin
    if(a=nil) then
        begin
            new(a);
            a^.hi:= nil;
            a^.hd:= nil;
            r.numero:= p.numero;
            r.cantPedidos:= 1;
            r.montoTotal:= p.monto;
            a^.dato:= r;
        end
    else
        if(a^.dato.numero = p.numero) then
            begin
                a^.dato.cantPedidos:= a^.dato.cantPedidos + 1;
                a^.dato.montoTotal:= a^.dato.montoTotal + p.monto;
            end
        else
            if(p.numero < a^.dato.numero) then
                agregarArbol(a^.hi, p)
            else
                agregarArbol(a^.hd, p);
end;

procedure cargarArbol(var a: arbol);
var
    p: pedido;
    i: integer;
begin
    leerPedido(p);
    while(p.dirEntrega <> 'ZZZ') do
        begin
            imprimirPedido(p);
            agregarArbol(a, p);
            leerPedido(p);
        end;
    {for i:= 1 to Random(6)+5 do
        begin
            productoRandom(p);
            imprimirPedido(p);
            agregarArbol(a, p);
        end;}
end;

procedure imprimirArbol(a: arbol);
begin
    if(a<>nil) then
        begin
            imprimirArbol(a^.hi);
            imprimirRepartidor(a^.dato);
            imprimirArbol(a^.hd);
        end;
end;

function cantMonto(a : arbol; num1, num2 : real) : integer;
begin
	if(a <> nil) then
		begin
			if(a^.dato.montoTotal > num1 ) and (a^.dato.montoTotal < num2) then
				cantMonto := cantMonto(a^.hi, num1, num2) + cantMonto(a^.hd, num1,num2) + 1
			else
				cantMonto := cantMonto(a^.hi, num1, num2) + cantMonto(a^.hd, num1,num2);
		end
	else
		cantMonto := 0;
end;

procedure entreDosValores(a : arbol; num1, num2: integer);
begin
    if(a<>nil) then
        begin
            if (a^.dato.numero > num1 ) and (a^.dato.numero < num2) then
                begin
                    write('- ');
                    imprimirRepartidor(a^.dato);
                    entreDosValores(a^.hi, num1, num2);
                    entreDosValores(a^.hd, num1, num2);
                end
            else
                if(a^.dato.numero < num1) then
                    entreDosValores(a^.hd, num1, num2)
                else
                    if(a^.dato.numero > num2) then
                        entreDosValores(a^.hi, num1, num2);
        end;
end;

var
    a: arbol;
    num1, num2: real;
    num3, num4: integer;
begin
    Randomize;
    a:= nil;
    cargarArbol(a);
    imprimirArbol(a);

    writeln('Ingrese un primer valor');
    readln(num1);
    writeln('Ingrese un segundo valor');
    readln(num2);
    writeln('La cantidad de repartidores que recaudaron un monto total que oscila entre ', num1:0:2, ' y ', num2:0:2, ' es: ', cantMonto(a,num1,num2));

    writeln('Ingrese un tercer valor');
    readln(num3);
    writeln('Ingrese un cuarto valor');
    readln(num4);
    entreDosValores(a, num3, num4);
end.