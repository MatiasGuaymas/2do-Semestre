program parcial9;
type
	subDia = 1..31;
	subMes = 1..12;
	fec = record	
		dia: subDia;
		mes: subMes;
		anio: integer;
	end;
	registroLectura = record
		dni: integer;
		nombre: string;
		fecha: fec;
		monto: real;
	end;
	registroLista = record
		fecha: fec;
		monto: real;
	end;
	lista = ^nodoLista;
	nodoLista = record
		dato: registroLista;
		sig: lista;
	end;
	registroArbol = record
		dni: integer;
		nombre: string;
		l: lista;
	end;
	arbol = ^nodoArbol;
	nodoArbol = record
		dato: registroArbol;
		hi: arbol;
		hd: arbol;
	end;
procedure leerPedido(var r: registroLectura);
begin
	r.monto:= Random(15);
	if(r.monto <> 0) then
		begin
			writeln('Ingrese un dni');
			readln(r.dni);
			writeln('Ingrese un nombre');
			readln(r.nombre);
			r.fecha.dia:= Random(31)+1;
			r.fecha.mes:= Random(12)+1;
			r.fecha.anio:= Random(24)+2000;
		end;
end;
procedure buscarHoja(var a, h: arbol; dni: integer; nombre: string);
begin
	if(a=nil) or (a^.dato.dni = dni) then
		begin
			if(a = nil) then
				begin
					new(a);
					a^.hi:= nil;
					a^.hd:= nil;
					a^.dato.l:= nil;
					a^.dato.dni:= dni;
					a^.dato.nombre:= nombre;
				end;
			h:= a;
		end
	else
		if(dni < a^.dato.dni) then
			buscarHoja(a^.hi, h, dni, nombre)
		else
			buscarHoja(a^.hd, h, dni, nombre);
end;
procedure convertirRegistro(reg: registroLectura; var regL: registroLista);
begin
	regL.fecha:= reg.fecha;
	regL.monto:= reg.monto;
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
	while(reg.monto <> 0) do
		begin
			buscarHoja(a, hoja, reg.dni, reg.nombre);
			convertirRegistro(reg, regL);
			agregarAdelante(hoja^.dato.l, regL);
			leerPedido(reg);
		end;
end;
procedure leerFecha(var f: fec);
begin
	writeln('Ingrese un dia');
	readln(f.dia);
	writeln('Ingrese un mes');
	readln(f.mes);
	writeln('Ingrese un anio');
	readln(f.anio);
end;
procedure verificarListaFecha(l: lista; f: fec; var cant: integer);
begin
	while(l<>nil) do
		begin
			if(l^.dato.fecha.dia = f.dia) and (l^.dato.fecha.mes = f.mes) and (l^.dato.fecha.anio = f.anio) then
				cant:= cant+1;
			l:= l^.sig;
		end;
end;
procedure cantClientesFecha(a: arbol; f: fec; var cant: integer);
begin
	if (a<>nil) then
		begin
			verificarListaFecha(a^.dato.l, f, cant);
			cantClientesFecha(a^.hi, f, cant);
			cantClientesFecha(a^.hd, f, cant);
		end;
end;
procedure informacionDNI(l: lista; var montoTotal: real; var cantTotal: integer);
begin
	while(l<>nil) do
		begin
			cantTotal:= cantTotal + 1;
			montoTotal:= montoTotal + l^.dato.monto;
			l:= l^.sig;
		end;
end;
procedure infoDNI(a: arbol; dni: integer; var montoTotal: real; var cantTotal: integer);
begin
	if(a<>nil) then
		begin
			if(a^.dato.dni = dni) then
				informacionDNI(a^.dato.l, montoTotal, cantTotal)
			else
				if(dni < a^.dato.dni) then
					infoDNI(a^.hi, dni, montoTotal, cantTotal)
				else
					infoDNI(a^.hd, dni, montoTotal, cantTotal);
		end;
end;
procedure imprimirLista(l: lista);
begin
	while(l<>nil) do
		begin
			write(' -- Dia=', l^.dato.fecha.dia, ' Mes=', l^.dato.fecha.mes, ' Anio=', l^.dato.fecha.anio, ' Monto=', l^.dato.monto:0:2);
			l:= l^.sig;
		end;
end;
procedure imprimirNodo(reg: registroArbol);
begin
	write('DNI=', reg.dni, ' Nombre=', reg.nombre, ' Lista: ');
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
	f: fec;
	cant, dni: integer;
	montoTotal: real;
begin
	Randomize;
	a:= nil;
	cargarArbol(a);
	imprimirArbol(a);
	leerFecha(f);
	cant:= 0;
	cantClientesFecha(a,f,cant);
	writeln('En el dia ', f.dia, ', mes ', f.mes, ', anio ', f.anio, ' se realizaron ', cant, ' pedidos');
	writeln('Ingrese un numero de DNI');
	readln(dni);
	montoTotal:= 0;
	cant:= 0;
	infoDNI(a,dni,montoTotal,cant);
	writeln('El cliente con DNI ', dni, ' realizo en total ', cant, ' pedidos y gasto un total de: ', montoTotal:0:2);
end.
