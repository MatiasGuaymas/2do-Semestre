program parcial6;
type
	subDia = 1..31;
	registroLectura = record
		codigo: integer;
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
	r.cant := Random(15);
	if(r.cant <> 0) then
		begin
			r.codigo:= Random(20)+1;
			r.dia:= Random(31)+1;
			r.monto:= r.codigo * Random(10);
		end;
end;
procedure buscarHoja(var a, h: arbol; codigo: integer);
begin
	if(a = nil) or (a^.dato.codigo = codigo) then
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
	regL.monto:= reg.monto;
	regL.cant:= reg.cant;
	regL.dia:= reg.dia;
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
	while(reg.cant <> 0) do
		begin
			buscarHoja(a, hoja, reg.codigo);
			convertirRegistro(reg, regL);
			agregarAdelante(hoja^.dato.l, regL);
			leerCompra(reg);
		end;
end;
procedure listaCodigo(a: arbol; codigo: integer; var l: lista);
begin
	if(a<>nil) then
		begin
			if(a^.dato.codigo = codigo) then
				l:= a^.dato.l
			else
				if(codigo < a^.dato.codigo) then
					listaCodigo(a^.hi, codigo, l)
				else
					listaCodigo(a^.hd, codigo, l);
		end;
end;
procedure mayorMontoCliente(l: lista; var cantMax: integer; var montoMax: real);
begin
	if(l<>nil) then
		begin
			if(l^.dato.cant > cantMax) then
				begin
					cantMax:= l^.dato.cant;
					montoMax:= l^.dato.monto;
				end;
			mayorMontoCliente(l^.sig, cantMax, montoMax);
		end;
end;
procedure imprimirLista(l: lista);
begin
	while(l<>nil) do
		begin
			write('Cant=', l^.dato.cant, ' Monto=', l^.dato.monto:0:2, ' Dia=', l^.dato.dia, ' - ');
			l:= l^.sig;
		end;
end;
procedure imprimirNodo(reg: registroArbol);
begin
	write('Codigo=', reg.codigo, ' Lista: ');
	imprimirLista(reg.l);
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
	codigo, cantMax: integer;
	montoMax: real;
begin
	Randomize;
	a:= nil;
	l:= nil;
	cargarArbol(a);
	imprimirArbol(a);
	writeln('Ingrese un codigo de cliente');
	readln(codigo);
	listaCodigo(a, codigo, l);
	writeln('Compras del cliente con codigo ', codigo, ': ');
	imprimirLista(l);
	cantMax:= -1;
	montoMax:= 0;
	mayorMontoCliente(l, cantMax, montoMax);
	writeln();
	writeln('El monto de la compra con mayor cantidad de productos del cliente con codigo ', codigo, ' fue de: ', montoMax:0:2);
end.
