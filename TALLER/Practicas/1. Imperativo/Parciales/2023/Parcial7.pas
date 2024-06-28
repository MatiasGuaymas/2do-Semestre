program parcial7;
type
	subDia = 1..31;
	subMes = 1..12;
	registroLectura = record
		codVideojuego: integer;
		codCliente: integer;
		dia: subDia;
		mes: subMes;
	end;
	registroLista = record
		codVideojuego: integer;
		dia: subDia;
		mes: subMes;
	end;
	lista = ^nodoLista;
	nodoLista = record
		dato: registroLista;
		sig: lista;
	end;
	registroArbol = record
		l: lista;
		codCliente: integer;
	end;
	arbol = ^nodoArbol;
	nodoArbol = record
		dato: registroArbol;
		hi: arbol;
		hd: arbol;
	end;
	vecMes = array [subMes] of integer;
procedure leerCompra(var reg: registroLectura);
begin
	reg.codCliente:= Random(20);
	if(reg.codCliente <> 0) then
		begin
			reg.codVideojuego:= Random(50)+1;
			reg.dia:= Random(31)+1;
			reg.mes:= Random(12)+1;
		end;
end;
procedure buscarHoja(var a, h: arbol; codCliente: integer);
begin
	if(a=nil) or (a^.dato.codCliente = codCliente) then
		begin
			if(a=nil) then
				begin
					new(a);
					a^.hi:= nil;
					a^.hd:= nil;
					a^.dato.l:= nil;
					a^.dato.codCliente:= codCliente;
				end;
			h:= a;
		end
	else
		if(codCliente < a^.dato.codCliente) then
			buscarHoja(a^.hi, h, codCliente)
		else
			buscarHoja(a^.hd, h, codCliente);
end;
procedure convertirRegistro(reg: registroLectura; var regL: registroLista);
begin
	regL.codVideojuego:= reg.codVideojuego;
	regL.mes:= reg.mes;
	regL.dia:= reg.dia;
end;
procedure agregarAdelante(var l: lista; regL: registroLista);
var
	aux: lista;
begin
	new(aux);
	aux^.sig:= l;
	l:= aux;
	aux^.dato:= regL;
end;
procedure cargarEstructuras(var a: arbol; var v: vecMes);
var
	reg: registroLectura;
	regL: registroLista;
	hoja: arbol;
begin
	leerCompra(reg);
	while(reg.codCliente <> 0) do
		begin
			v[reg.mes]:= v[reg.mes] + 1;
			buscarHoja(a, hoja, reg.codCliente);
			convertirRegistro(reg, regL);
			agregarAdelante(hoja^.dato.l, regL);
			leerCompra(reg);
		end;
end;
procedure listaCliente(a: arbol; codCliente: integer; var l: lista);
begin
	if(a<>nil) then
		begin
			if(a^.dato.codCliente = codCliente) then
				l:= a^.dato.l
			else
				if(codCliente < a^.dato.codCliente) then
					listaCliente(a^.hi, codCliente, l)
				else
					listaCliente(a^.hd, codCliente, l);
		end;
end;
procedure ordenarVector(var v: vecMes);
var
	i, j, pos, item: integer;
begin
	for i:= 1 to 11 do
		begin
			pos:= i;
			for j:= i+1 to 12 do
				if (v[j] > v[pos]) then pos:= j;
			item:= v[pos];
			v[pos]:= v[i];
			v[i] := item;
		end;
end;
procedure inicializarVector(var v: vecMes);
var
	i: subMes;
begin
	for i:= 1 to 12 do v[i]:= 0;
end;
procedure imprimirLista(l: lista);
begin
	while(l<>nil) do
		begin
			write('CodVideojuego=', l^.dato.codVideojuego, ' Dia=', l^.dato.dia, ' Mes=', l^.dato.mes, ' - ');
			l:= l^.sig;
		end;
end;
procedure imprimirNodo(reg: registroArbol);
begin
	write('Code=', reg.codCliente, ' Lista: ');
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
procedure imprimirVector(v: vecMes);
var
	i: subMes;
begin
	for i:= 1 to 12 do writeln(i, '. ', v[i]);
end;
var
	a: arbol;
	l: lista;
	v: vecMes;
	codigo: integer;
begin
	Randomize;
	a:= nil;
	l:= nil;
	inicializarVector(v);
	cargarEstructuras(a, v);
	imprimirArbol(a);
	writeln();
	imprimirVector(v);
	writeln('Ingrese un codigo de cliente');
	readln(codigo);
	listaCliente(a, codigo, l);
	imprimirLista(l);
	writeln();
	ordenarVector(v);
	imprimirVector(v);
end.