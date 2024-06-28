program Guaymas;
type
    registroLectura = record
        nombre: string;
        dni: integer;
        tiempo: real;
    end;
    lista = ^nodoLista;
    nodoLista = record
        dato: registroLectura;
        sig: lista;
    end;
    arbol = ^nodoArbol;
    nodoArbol = record
        dato: registroLectura;
        hi: arbol;
        hd: arbol;
    end;
procedure leerAlumno(var r: registroLectura);
begin
    r.dni:= Random(15);
    if(r.dni<>0) then
        begin
            writeln('Ingrese un nombre');
            readln(r.nombre);
            r.tiempo:= (Random(10)+1) *  (Random(20)+1);
        end;
end;
procedure agregarArbol(var a: arbol; r: registroLectura);
begin
    if(a = nil) then
        begin
            new(a);
            a^.hi:= nil;
            a^.hd:= nil;
            a^.dato:= r;
        end
    else
        if(r.tiempo <= a^.dato.tiempo) then
            agregarArbol(a^.hi, r)
        else
            agregarArbol(a^.hd, r);
end;
procedure cargarArbol(var a: arbol);
var
    reg: registroLectura;
begin
    leerAlumno(reg);
    while(reg.dni <> 0) do
        begin
            agregarArbol(a, reg);
            leerAlumno(reg);
        end;
end;
procedure agregarAdelante(var l: lista; r: registroLectura);
var
    aux: lista;
begin
    new(aux);
    aux^.sig:= l;
    l:= aux;
    aux^.dato:= r;
end;
procedure entreDosTiempos(a: arbol; t1, t2: real; var l: lista);
begin
    if(a<>nil) then
        begin
            if(a^.dato.tiempo >= t1) and (a^.dato.tiempo <= t2) then    
                begin
                    entreDosTiempos(a^.hd, t1, t2, l);
                    agregarAdelante(l, a^.dato);
                    entreDosTiempos(a^.hi, t1, t2, l);
                end
            else
                if(a^.dato.tiempo > t1) then
                    entreDosTiempos(a^.hi, t1, t2, l)
                else
                    entreDosTiempos(a^.hd, t1, t2, l);
        end;
end;
procedure aluMin(a: arbol; var nombre: string; var dni: integer);
begin
    if(a<>nil) then
        begin
            if(a^.hi = nil) then
                begin
                    nombre:= a^.dato.nombre;
                    dni:= a^.dato.dni;
                end
            else
                aluMin(a^.hi, nombre, dni);
        end;
end;
procedure imprimirNodo(r: registroLectura);
begin
    writeln('Tiempo=', r.tiempo:0:2, ' DNI=', r.dni, ' Nombre=', r.nombre);
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
procedure imprimirLista(l: lista);
begin
    while(l<>nil) do
        begin
            writeln('Tiempo=', l^.dato.tiempo:0:2, ' DNI=', l^.dato.dni, ' Nombre=', l^.dato.nombre);
            l:= l^.sig;
        end;
end;
procedure verificar(var t1, t2: real);
var
    aux: real;
begin
    if(t1 > t2) then
        begin
            aux:= t1;
            t1:= t2;
            t2:= aux;
        end;
end;
var
    a: arbol;
    l: lista;
    t1, t2: real;
    dni: integer;
    nombre: string;
begin
    Randomize;
    a:= nil;
    l:= nil;
    cargarArbol(a);
    imprimirArbol(a);
    writeln('Ingrese un primer tiempo');
    readln(t1);
    writeln('Ingrese un segundo tiempo');
    readln(t2);
    verificar(t1, t2);
    entreDosTiempos(a, t1, t2, l);
    writeln('Lista de alumnos con tiempo entre ', t1:0:2, ' y ', t2:0:2);
    imprimirLista(l);
    dni:= 0;
    nombre:= '';
    aluMin(a, nombre, dni);
    writeln('El alumno con menos tiempo fue ', nombre, ' con el DNI ', dni);
end.