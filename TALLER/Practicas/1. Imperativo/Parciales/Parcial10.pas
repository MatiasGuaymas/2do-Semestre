program parcial10;
type
	subDia = 1..31;
	registroLectura = record
		cliente: integer;
		dia: subDia;
		cant: integer;
		monto: real;
	end;
	registroLista = record
		dia: subDia;
		cant: integer;
		monto: real;
	end;
	lista = ^nodoLista;
	nodoLista = record	
		dato: registroLista;
		sig: lista;
	end;
	registroArbol = record
		cliente: integer;
		l: lista;
	end;
	arbol = ^nodoArbol;
	nodoArbol = record	
		dato: registroArbol;
		hi: arbol;
		hd: arbol;
	end;
procedure leerPedido(var reg: registroLectura);
begin
	reg.cliente:= Random(15);
	reg.dia:= Random(31)+1;
	reg.cant:= Random(6)+3;
	reg.monto:= reg.cant * (Random(10)+1);
end;
procedure buscarHoja(var a, h: arbol; cliente: integer);
begin
	if(a=nil) or (a^.dato.cliente = cliente) then
		begin
			if(a=nil) then
				begin
					new(a);
					a^.hi:= nil;
					a^.hd:= nil;
					a^.dato.l:= nil;
					a^.dato.cliente:= cliente;
				end;
			h:= a
		end
	else
		if(cliente < a^.dato.cliente) then
			buscarHoja(a^.hi, h, cliente)
		else
			buscarHoja(a^.hd, h, cliente);
end;
procedure convertirRegistro(reg: registroLectura; var regL: registroLista);
begin
	regL.dia:= reg.dia;
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
	leerPedido(reg);
	while(reg.cliente <> 0) do
		begin
			buscarHoja(a, hoja, reg.cliente);
			convertirRegistro(reg, regL);
			agregarAdelante(hoja^.dato.l, regL);
			leerPedido(reg);
		end;
end;
procedure listaCliente(a: arbol; cliente: integer; var l: lista);
begin
	if(a<>nil) then
		begin
			if(cliente = a^.dato.cliente) then
				l:= a^.dato.l
			else
				if(cliente < a^.dato.cliente) then
					listaCliente(a^.hi, cliente, l)
				else
					listaCliente(a^.hd, cliente, l);
		end;
end;
function montoTotal(l: lista): real;
begin
	if(l<>nil) then
		begin
			montoTotal:= montoTotal(l^.sig) + l^.dato.monto;
		end
	else
		montoTotal:= 0;
end;
procedure imprimirLista(l: lista);
begin
	while(l<>nil) do
		begin
			write('Dia=', l^.dato.dia,' Cant=', l^.dato.cant, ' Monto=',l^.dato.monto:0:2, ' - ');
			l:= l^.sig;
		end;
end;
procedure imprimirNodo(r: registroArbol);
begin
	write('Cliente=', r.cliente, ' Lista: ');
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
var
	l: lista;
	a: arbol;
	cliente: integer;
begin
	Randomize;
	a:= nil;
	l:= nil;
	cargarArbol(a);
	imprimirArbol(a);
	writeln('Ingrese un codigo de cliente');
	readln(cliente);
	listaCliente(a, cliente, l);
	write('Lista de pedidos del cliente con codigo ', cliente, ': ');
	imprimirLista(l);
	writeln();
	writeln('El monto total abonado por el cliente con codigo ', cliente, ' es: ', montoTotal(l):0:2);
end.