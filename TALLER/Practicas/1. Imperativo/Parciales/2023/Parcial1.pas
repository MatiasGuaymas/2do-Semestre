program parcial1;
type
    subMes = 0..12;
    subCode = 1..15;
    registroLectura = record
        dni: integer;
        mes: subMes;
        codigo: subCode;
    end;
    registroPaciente = record
        dni: integer;
        cant: integer;
    end;
    arbol = ^nodo;
    nodo = record
        dato: registroPaciente;
        hi: arbol;
        hd: arbol;
    end;
    vecDiagnostico = array [subCode] of integer;
procedure leerAtencion(var r: registroLectura);
begin
    r.mes:= Random(13);
    if(r.mes<>0) then
        begin
            r.dni:= Random(10)+1;
            r.codigo:= Random(15)+1;
        end;
end;
procedure agregarArbol(var a: arbol; dni: integer);
begin
    if(a=nil) or (a^.dato.dni = dni) then
        begin
            if(a=nil) then
                begin
                    new(a);
                    a^.hi:= nil;
                    a^.hd:= nil;
                    a^.dato.dni:= dni;
                    a^.dato.cant:= 0;
                end;
            a^.dato.cant:= a^.dato.cant + 1;
        end
    else
        if(dni < a^.dato.dni) then
            agregarArbol(a^.hi, dni)
        else
            agregarArbol(a^.hd, dni);
end;
procedure cargarEstructuras(var a: arbol; var v: vecDiagnostico);
var
    reg: registroLectura;
begin
    leerAtencion(reg);
    while(reg.mes <> 0) do
        begin
            v[reg.mes] := v[reg.mes] + 1;
            agregarArbol(a, reg.dni);
            leerAtencion(reg);
        end;
end;
procedure entreDosValores(a: arbol; dni1, dni2, x: integer; var cantPacientes: integer);
begin
    if(a<>nil) then
        begin
            if(a^.dato.dni > dni1) and (a^.dato.dni < dni2) then
                begin
                    if(a^.dato.cant > x) then
                        cantPacientes:= cantPacientes + 1;
                    entreDosValores(a^.hi, dni1, dni2, x, cantPacientes);
                    entreDosValores(a^.hd, dni1, dni2, x, cantPacientes);
                end
            else
                if(a^.dato.dni > dni1) then
                    entreDosValores(a^.hi, dni1, dni2, x, cantPacientes)
                else
                    entreDosValores(a^.hd, dni1, dni2, x, cantPacientes);
        end;
end;
function diagnosticoCero(v: vecDiagnostico; dim: integer): integer;
begin
    if(dim > 0) then
        begin
            if(v[dim] = 0) then
                diagnosticoCero:= diagnosticoCero(v, dim-1) + 1
            else
                diagnosticoCero:= diagnosticoCero(v, dim-1);
        end
    else
        diagnosticoCero:= 0;
end;
procedure imprimirNodo(r: registroPaciente);
begin
    writeln('DNI=', r.dni, ' CANT=', r.cant);
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
procedure inicializarVector(var v: vecDiagnostico);
var
    i: subCode;
begin
    for i:= 1 to 15 do v[i] := 0;
end;
procedure imprimirVector(v: vecDiagnostico);
var
    i: subCode;
begin
    for i:= 1 to 15 do writeln(i, '. ', 'CANT=', v[i]);
end;
var
    a: arbol;
    v: vecDiagnostico;
    dni1, dni2, cant, x: integer;
begin
    Randomize;
    a:= nil;
    inicializarVector(v);
    cargarEstructuras(a, v);
    imprimirArbol(a);
    writeln();
    imprimirVector(v);
    writeln('Ingrese un primer numero de dni');
    readln(dni1);
    writeln('Ingrese un segundo numero de dni');
    readln(dni2);
    cant:= 0;
    writeln('Ingrese una cantidad');
    readln(x);
    entreDosValores(a, dni1, dni2, x, cant);
    writeln('Entre el dni ', dni1, ' y el dni ', dni2, ' la cantidad de pacientes con mas de ', x, ' atenciones fue: ', cant);
    writeln('La cantidad de diagnosticos para los cuales la cantidad de atenciones fue cero es: ', diagnosticoCero(v, 15));
end.