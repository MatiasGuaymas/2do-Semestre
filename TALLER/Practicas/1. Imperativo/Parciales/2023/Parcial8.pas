program parcial8;
type
	subMes = 1..12;
	registroLectura = record
		dni: integer;
		patente: integer;
		mes: subMes;
		anio: integer;
	end;
	registroLista = record
		dni: integer;
		mes: subMes;
		anio: integer;
	end;
	lista = ^nodoLista;
	nodoLista = record	
		dato: registroLista;
		sig: lista;
	end;
	registroArbol = record
		patente: integer;
		l: lista;
	end;
	arbol = ^nodoArbol;
	nodoArbol = record
		dato: registroArbol;
		hi: arbol;
		hd: arbol;
	end;
procedure leerAlquiler(var reg: registroLectura);
begin
	reg.patente:= Random(15);
	if(reg.patente <> 0) then
		begin
			reg.dni:= Random(50)+1;
			reg.mes:= Random(12)+1;
			reg.anio:= Random(24) + 2000;
		end;
end;
procedure buscarHoja(var a, h: arbol; patente: integer);
begin
	if(a = nil) or (a^.dato.patente = patente) then
		begin
			if(a=nil) then
				begin
					new(a);
					a^.hi:= nil;
					a^.hd:= nil;
					a^.dato.l:= nil;
					a^.dato.patente := patente;
				end;
			h:= a;
		end
	else
		if(patente < a^.dato.patente) then
			buscarHoja(a^.hi, h, patente)
		else
			buscarHoja(a^.hd, h, patente);
end;
procedure convertirRegistro(reg: registroLectura; var regL: registroLista);
begin
	regL.dni:= reg.dni;
	regL.anio:= reg.anio;
	regL.mes:= reg.mes;
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
	leerAlquiler(reg);
	while(reg.patente <> 0) do
		begin
			buscarHoja(a, hoja, reg.patente);
			convertirRegistro(reg, regL);
			agregarAdelante(hoja^.dato.l, regL);
			leerAlquiler(reg);
		end;
end;
procedure contarCantDNI(l: lista; dni: integer; var cant: integer);
begin
	while(l<>nil) do
		begin
			if(l^.dato.dni = dni) then
				cant:= cant+1;
			l:= l^.sig;
		end;
end;
procedure cantAlquileresDNI(a: arbol; dni: integer; var cant: integer);
begin
	if(a<>nil) then
		begin
			contarCantDNI(a^.dato.l, dni, cant);
			cantAlquileresDNI(a^.hi, dni, cant);
			cantAlquileresDNI(a^.hd, dni, cant);
		end;
end;
procedure contarCantAnio(l: lista; anio: integer; var cant: integer);
begin
	while(l<>nil) do
		begin
			if(l^.dato.anio = anio) then
				cant:= cant+1;
			l:= l^.sig;
		end;
end;
procedure entreDosValores(a: arbol; anio, pat1, pat2: integer; var cant: integer);
begin
	if(a<>nil) then
		begin
			if(a^.dato.patente >= pat1) and (a^.dato.patente <= pat2) then
				begin
					contarCantAnio(a^.dato.l, anio, cant);
					entreDosValores(a^.hi, anio, pat1, pat2, cant);
					entreDosValores(a^.hd, anio, pat1, pat2, cant)
				end
			else
				if(a^.dato.patente > pat1) then
					entreDosValores(a^.hi, anio, pat1, pat2, cant)
				else
					entreDosValores(a^.hd, anio, pat1, pat2, cant);
		end;
end;
procedure imprimirLista(l: lista);
begin
	while(l<>nil) do
		begin
			write('DNI=', l^.dato.dni, ' Mes=', l^.dato.mes, ' Anio=', l^.dato.anio, ' - ');
			l:= l^.sig;
		end;
end;
procedure imprimirNodo(reg: registroArbol);
begin
	write('Patente=', reg.patente, ' Lista:');
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
	dni, cant, pat1, pat2, anio: integer;
begin
	Randomize;
	a:= nil;
	cargarArbol(a);
	imprimirArbol(a);
	writeln('Ingrese un numero de DNI');
	readln(dni);
	cant:= 0;
	cantAlquileresDNI(a, dni, cant);
	writeln('La cantidad de alquileres realizados por el dni ', dni, ' es: ', cant);
	writeln('Ingrese un anio X');
	readln(anio);
	writeln('Ingrese una primer patente');
	readln(pat1);
	writeln('Ingrese una segunda patente');
	readln(pat2);
	cant:= 0;
	verificar(pat1, pat2);
	entreDosValores(a, anio, pat1, pat2, cant);
	writeln('La cantidad de alquileres realizados para las patentes entre ', pat1, ' y ', pat2, ' en el anio ', anio, ' es: ', cant);
end.
