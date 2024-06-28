program final1;
type
	registroLectura = record
		numero: integer;
		entrega: string;
		pedido: integer;
		monto: real;
	end;
	registroArbol = record
		numero: integer;
		cant: integer;
		monto: real;
	end;
	arbol = ^nodoArbol;
	nodoArbol = record
		dato: registroArbol;
		hi: arbol;
		hd: arbol;
	end;
procedure leerPedido(var r: registroLectura);
begin
	writeln('Ingrese una direccion de entrega');
	readln(r.entrega);
	if(r.entrega <> 'ZZZ') then
		begin
			r.numero:= Random(10)+1;
			r.pedido:= Random(15)+1;
			r.monto:= (Random(30)+1) * (Random(10)+1);
		end;
end;
procedure agregarArbol(var a: arbol; numero: integer; monto: real);
begin
	if(a=nil) or (a^.dato.numero = numero) then
		begin
			if(a=nil) then
				begin
					new(a);
					a^.hi:= nil;
					a^.hd:= nil;
					a^.dato.numero:= numero;
					a^.dato.cant:= 0;
					a^.dato.monto:= 0;
				end;
			a^.dato.cant:= a^.dato.cant + 1;
			a^.dato.monto:= a^.dato.monto + monto;
		end
	else
		if(numero < a^.dato.numero) then
			agregarArbol(a^.hi, numero, monto)
		else
			agregarArbol(a^.hd, numero, monto);
end;
procedure cargarArbol(var a: arbol);
var
	reg: registroLectura;
begin
	leerPedido(reg);
	while(reg.entrega <> 'ZZZ') do
		begin
			agregarArbol(a, reg.numero, reg.monto);
			leerPedido(reg);
		end;
end;
procedure entreDosMontos(a: arbol; monto1, monto2: real; var cant: integer);
begin
	if(a<>nil) then
		begin
			if(a^.dato.monto >= monto1) and (a^.dato.monto <= monto2) then
				cant:= cant+1;
			entreDosMontos(a^.hi, monto1, monto2, cant);
			entreDosMontos(a^.hd, monto1, monto2, cant);
		end;
end;
procedure imprimirRepartidor(r: registroArbol);
begin
	writeln('Numero=', r.numero, ' CantTotal=', r.cant, ' MontoTotal=', r.monto:0:2);
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
procedure entreDosNumeros(a: arbol; num1, num2: integer);
begin
	if(a<>nil) then
		begin
			if(a^.dato.numero >= num1) and (a^.dato.numero <= num2) then
				begin
					imprimirRepartidor(a^.dato);
					entreDosNumeros(a^.hi, num1, num2);
					entreDosNumeros(a^.hd, num1, num2);
				end
			else
				if(a^.dato.numero > num1) then
					entreDosNumeros(a^.hi, num1, num2)
				else
					entreDosNumeros(a^.hd, num1, num2);
		end;
end;
procedure verificarReales(var num1, num2: real);
var
	aux: real;
begin
	if(num1 > num2) then
		begin
			aux:= num1;
			num1:= num2;
			num2:= aux;
		end;
end;
procedure verificarEnteros(var num1, num2: integer);
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
	a:arbol;
	monto1, monto2: real;
	cant, num1, num2: integer;
begin
	Randomize;
	a:= nil;
	cargarArbol(a);
	imprimirArbol(a);
	writeln('Ingrese un primer monto');
	readln(monto1);
	writeln('Ingrese un segundo monto');
	readln(monto2);
	verificarReales(monto1,monto2);
	cant:= 0;
	entreDosMontos(a,monto1,monto2, cant);
	writeln('La cantidad de repartidores que recaudaron un monto total que oscila entre ', monto1:0:2, ' y ', monto2:0:2, ' es: ', cant);
	writeln('Ingrese un primer numero');
	readln(num1);
	writeln('Ingrese un segundo numero');
	readln(num2);
	verificarEnteros(num1, num2);
	writeln('Informacion de los repartidores cuyo numero de repartidor oscila entre ', num1, ' y ', num2, ':');
	entreDosNumeros(a, num1, num2);
end.