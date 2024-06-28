program parcial5;
type
	registroLectura = record
		numero: integer;
		isbn: integer;
		socio: integer;
	end;
	registroLista = record
		numero: integer;
		socio: integer;
	end;
	lista = ^nodoLista;
	nodoLista = record
		dato: registroLista;
		sig: lista;
	end;
	registroArbol = record
		l: lista;
		isbn: integer;
	end;
	arbol = ^nodoArbol;
	nodoArbol = record
		dato: registroArbol;
		hi: arbol;
		hd: arbol;
	end;
	registroSocio = record
		socio: integer;
		cant: integer;
	end;
	listaSocio = ^nodoSocio;
	nodoSocio = record
		dato: registroSocio;
		sig: listaSocio;
	end;
procedure leerPrestamo(var r: registroLectura);
begin
	writeln('Ingrese un numero de socio');
	readln(r.socio);
	r.isbn:= Random(10)+1;
	r.numero:= Random(30)+1;
end;
procedure buscarHoja(var a, h: arbol; isbn: integer);
begin
	if(a=nil) or (a^.dato.isbn = isbn) then
		begin
			if(a=nil) then
				begin
					new(a);
					a^.hi:= nil;
					a^.hd:= nil;
					a^.dato.l:= nil;
					a^.dato.isbn := isbn;
				end;
			h:= a;
		end
	else
		if(isbn < a^.dato.isbn) then
			buscarHoja(a^.hi, h, isbn)
		else
			buscarHoja(a^.hd, h, isbn);
end;
procedure construirRegistro(reg: registroLectura; var regL: registroLista);
begin
	regL.numero:= reg.numero;
	regL.socio:= reg.socio;
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
procedure agregarAdelante2(var l: listaSocio; socio, cant: integer);
var
	aux: listaSocio;
begin
	new(aux);
	aux^.sig:= l;
	l:= aux;
	aux^.dato.socio:= socio;
	aux^.dato.cant:= cant;
end;
procedure cargarEstructuras(var a: arbol; var l: listaSocio);
var
	reg: registroLectura;
	regL: registroLista;
	hoja: arbol;
	cant: integer;
	socioActual: integer;
begin
	leerPrestamo(reg);
	while(reg.socio <> 0) do
		begin
			socioActual:= reg.socio;
			cant:= 0;
			while(reg.socio<>0) and (socioActual = reg.socio) do
				begin
					cant:= cant + 1;
					buscarHoja(a, hoja, reg.isbn);
					construirRegistro(reg, regL);
					agregarAdelante(hoja^.dato.l, regL);
					leerPrestamo(reg);
				end;
			agregarAdelante2(l, socioActual, cant);
		end;
end;
procedure cantPrestamos(l: lista; var cantTotal: integer);
begin
	while(l<>nil) do
		begin
			cantTotal:= cantTotal + 1;
			l:= l^.sig;
		end;
end;
procedure cantPrestamosISBN(a: arbol; isbn: integer; var cantTotal: integer);
begin
	if(a<>nil) then
		begin
			if(a^.dato.isbn = isbn) then
				cantPrestamos(a^.dato.l, cantTotal)
			else
				if(isbn < a^.dato.isbn) then
					cantPrestamosISBN(a^.hi, isbn, cantTotal)
				else
					cantPrestamosISBN(a^.hd, isbn, cantTotal);
		end;
end;
function cantSociosMasX(l: listaSocio; x: integer): integer;
begin
	if(l<>nil) then
		begin
			cantSociosMasX:= cantSociosMasX(l^.sig, x);
			if(l^.dato.cant > x) then
				cantSociosMasX:= cantSociosMasX(l^.sig, x) + 1;
		end
	else
		cantSociosMasX:= 0;
end;
procedure imprimirLista(l: lista);
begin
	while(l<>nil) do
		begin
			write('Numero=', l^.dato.numero, ' Socio=', l^.dato.socio, ' - ');
			l:= l^.sig;
		end;
end;
procedure imprimirNodo(r: registroArbol);
begin
	write('ISBN=', r.isbn, ' Lista: ');
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
procedure imprimirLista2(l: listaSocio);
begin
	while(l<>nil) do
		begin
			writeln('Socio=', l^.dato.socio, ' Cant=', l^.dato.cant);
			l:= l^.sig;
		end;
end;
var
	a: arbol;
	l: listaSocio;
	isbn, x, cantTotal: integer;
begin
	Randomize;
	a:= nil;
	l:= nil;
	cargarEstructuras(a, l);
	imprimirArbol(a);
	imprimirLista2(l);
	writeln('Ingrese un ISBN');
	readln(isbn);
	cantTotal:= 0;
	cantPrestamosISBN(a, isbn, cantTotal);
	writeln('La cantidad de prestamos realiazdos al ISBN', isbn, ' es: ', cantTotal);
	writeln('Ingrese un valor x');
	readln(x);
	writeln('La cantidad de socios con cantidad de prestamos superior al valor ', x, ' es: ', cantSociosMasX(l, x));
end.