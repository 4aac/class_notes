% ASIER ACUÑA CASAL
% 2º GrIA - REPRESENTACIÓN DEL CONOCIMIENTO


/* HECHOS */

% EJERCICIO 1

hombre(bart).
hombre(homer).
hombre(kang).
hombre(milhouse).
hombre(kirk).
hombre(kearny).
hombre(jimbo).
hombre(dolph).

mujer(lisa).
mujer(marge).
mujer(maggie).

bebe(maggie).

abuson(kearny).
abuson(jimbo).
abuson(dolph).

estudia(lisa, springfield).
estudia(bart, springfield).
estudia(milhouse, springfield).
estudia(kearny, springfield).
estudia(jimbo, springfield).
estudia(dolph, springfield).

gusta(bart, skate).
gusta(bart, pintadas).
gusta(lisa, jazz).
gusta(homer, cerveza).
gusta(kirk, cerveza).
gusta(homer, rosquillas).

trabaja(homer, central_nuclear).

% padre(nombre_hijo, nombre_padre)
padre(bart, homer).
padre(lisa, homer).
padre(milhouse, kirk).

% madre(nombre_hijo, nombre_madre)
madre(lisa, marge).
madre(maggie, marge).
madre(bart, marge).

% hijo(nombre_hijo, nombre_padre/madre)
hijo(X, Y) :- padre(X, Y).
hijo(X, Y) :- madre(X, Y).

tiene(homer, cerveza).
tiene(homer, television).
capacidad_jarras(2).

% considera_amigo(X,Y) ; X considera amigo a Y
considera_amigo(milhouse, bart).

/* REGLAS */

% EJERCICIO 2

% a. Se estuda no colexio, entón é menor. Tamén é menor se é un bebé. 
es_menor(X) :- estudia(X, _); bebe(X).

% b. Se é pai de alguén, entón é adulto e é home. Igualmente, se é nai de alguén, entón é adulto e é muller.
adulto(X) :- padre(_, X); madre(_, X).
hombre(X) :- padre(_, X).
mujer(X) :- madre(_, X).

% c. Se dous personaxes distintos son fillos do mesmo pai e da mesma nai, entón son irmáns.
hermanos(X, Y) :- padre(X, A), padre(Y, A), madre(X, B), madre(Y, B), X \= Y.

% d. Se dous personaxes distintos comparten pai ou nai, pero non ambos, entón son medio irmáns.
medio_hermanos(X, Y) :- ((padre(X, A), padre(Y, A), madre(X, B1), madre(Y, B2)); (madre(X, A), madre(Y, A), padre(X, B1), padre(Y, B2))), B1\=B2, X\=Y.

% e. Se é abusón, gústanlle as pintadas.
gusta(X, pintadas) :- abuson(X).

% f. Se teñen un gusto en común, entón son amigos entre si.
amigos(X, Y) :- gusta(X, A), gusta(Y, A), X\=Y.

% EJERCICIO 3

% a- Calquera que non sexa vexetariano come no Krusty Burger.
come(X, krusty_burger) :- not(gusta(X, carne)).

% b- Todos os homes maiores de 30 anos e menores de 60 que traballan na central acuden ao bar de Moe.
come(X, bar_moe) :- hombre(X), edad(X, N), N > 30, N < 60, trabaja(X, central_nuclear).

% c- As grande xerras de cervexa do bar de Moe teñen unha capacidade de 2 litros. Calcular a cantidade de litros que bebe Homer se bebe N xerras, sendo N un parámetro de entrada, que debe ser sempre un número enteiro maior ou igual a 0 
litros_bebidos(Num_jarras, L) :- capacidad_jarras(C), L is Num_jarras * Cap.

% d- Sen tele e sen cervexa, Homer perde a cabeza.
pierde_cabeza(homer) :- not(tiene(homer, cerveza)), not(tiene(homer, television)).

/* CONSULTAS */

% EJERCICIO 5

% a- Quen estuda no colexio de primaria de Springfield?
% estudia(X, springfield).

% b- Hai algún menor ao que lle guste o jazz?
% es_menor(X), gusta(X, jazz).

% c- Cantos menores hai aos que lles guste facer pintadas? E cantos adultos co mesmo gusto?
% findall(X, (es_menor(X), gusta(X, pintadas)), Menores), length(Menores, CantidadMenores).
% findall(Y, (adulto(Y), gusta(Y, pintadas)), Adultos), length(Adultos, CantidadAdultos).

% d- Cantas parellas de amigos son recíprocas?
% findall((X, Y), (amigos(X, Y), amigos(Y, X), X @< Y), Parejas), length(Parejas, Cantidad).  % X @< Y es un operador que devuelve true sólo si el primer elemento está antes que el segundo, de esta forma evitamos contar el doble de parejas (X,Y),(Y,X) 

% e- Quen son as nais dos personaxes que teñen relación de medio irmán con algún outro personaxe?
% findall(M, (medio_hermanos(X, _), madre(X, M)), Madres)
