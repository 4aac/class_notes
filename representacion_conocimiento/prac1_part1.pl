/*HECHOS*/

% EJERCICIO 1

mujer(Lisa).
hombre(Bart).
hombre(Homer).
mujer(Marge).
mujer(Maggie).
hombre(Kang).
hombre(Milhouse).
hombre(Kirk).
hombre(Kearny).
hombre(Jimbo).
hombre(Dolph).

bebe(Maggie).

abuson(Kearny).
abuson(Jimbo).
abuson(Dolph).

estudia(Lisa, Springfield).
estudia(Bart, Springfield).
estudia(Milhouse, Springfield).
estudia(Kearny, Springfield).
estudia(Jimbo, Springfield).
estudia(Dolph, Sprinfield).

gusta(Bart, skate).
gusta(Bart, pintadas).
gusta(Lisa, jazz).
gusta(Homer, cerveza).
gusta(Kirk, cerveza).
gusta(Homer, rosquillas).

trabaja(Homer, central_nuclear).

% padre(nombre_hijo, nombre_padre)
padre(Bart, Homer).
padre(Lisa, Homer).
padre(Maggie, _).
padre(Milhouse, Kirk).

% madre(nombre_hijo, nombre_madre)
madre(Lisa, Marge).
madre(Maggie, Marge).
madre(Bart, Marge).

% hijo(nombre_hijo, nombre padre/madre)
hijo(Bart, Homer).
hijo(Bart, Marge).
hijo(Lisa, Homer).
hijo(Lisa, Marge).
hijo(Maggie, Marge).
hijo(Maggie, _).
hijo(Milhouse, Kirk).

tiene(Homer, cerveza).
tiene(Homer, television).
capacidad_jarras(2).

% considera_amigo(X,Y) -> X considera amigo a Y
considera_amigo(Milhouse, Bart).


/*REGLAS*/

% EJERCICIO 2

% a. Se estuda no colexio, entón é menor. Tamén é menor se é un bebé.
es_menor(X) :- estudia(X, _).
es_menor(X) :- bebe(X).

% b. Se é pai de alguén, entón é adulto e é home. Igualmente, se é nai de alguén, entón é adulto e é muller.
adulto(X) :- padre(_, X).
adulto(X) :- madre(_, X).
hombre(X) :- padre(_, X).
mujer(X) :- madre(_, X).

% c. Se dous personaxes distintos son fillos do mesmo pai e da mesma nai, entón son irmáns.
hermanos(X, Y) :- hijo(X, A), hijo(Y, A), hijo(X, B), hijo(Y, B), X\=Y.
hermanos(Y, X) :- hijo(X, A), hijo(Y, A), hijo(X, B), hijo(Y, B), X\=Y.

% d. Se dous personaxes distintos comparten pai ou nai, pero non ambos, entón son medio irmáns
medio_hermanos(X, Y) :- padre(X, A), padre(Y, B), X\=Y, madre(X, B1), madre(X, B2), B1 \= B2.
medio_hermanos(Y, X) :- padre(X, A), padre(Y, B), X\=Y, madre(X, B1), madre(X, B2), B1 \= B2.

% e. Se é abusón, gústanlle as pintadas.
gusta(X, pintadas) :- abuson(X).

% f. Se teñen un gusto en común, entón son amigos entre si.
amigos(X, Y) :- gusta(X, A), gusta(Y, A).
amigos(Y, X) :- gusta(X, A), gusta(Y, A).

% EJERCICIO 3

% a- Calquera que non sexa vexetariano come no Krusty Burger.
come(X, Krusty_Burger) :- not(es(X, vegetariano)).

% b- Todos os homes maiores de 30 anos e menores de 60 que traballan na central acuden ao bar de Moe.
come(X, bar_Moe) :- hombre(X), edad(X) >= 30, edad(X) <= 60, trabaja(X, central_nuclear).

% c- As grande xerras de cervexa do bar de Moe teñen unha capacidade de 2 litros. Calcular a cantidade de litros que bebe Homer se bebe N Práctica 1: Modelado de coñecemento nun sistema baseado en regras 3 xerras, sendo N un parámetro de entrada, que debe ser sempre un número enteiro maior ou igual a 0.
litros(litros, jarras) :- jarras * capacidad_jarras(

% d- Sen tele e sen cervexa, Homer perde a cabeza.
pierde_cabeza(Homer) :- not(tiene(Homer, cerveza)), not(tiene(Homer, television)).


/* CONSULTAS

% EJERCICIO 5

a- Quen estuda no colexio de primaria de Springfield?
estudia(X, Springfield)

b- Hai algún menor ao que lle guste o jazz?
menor(X), gusta(X, jazz)

c- Cantos menores hai aos que lles guste facer pintadas? E cantos adultos co mesmo gusto?
menor(X), gusta(X, pintadas)
adulto(Y), gusta(Y, pintadas)

d- Cantas parellas de amigos son recíprocas?
amigo(X, Y), amigo(Y, x), X\=Y

e- Quen son as nais dos personaxes que teñen relación de medio irmán con
algún outro personaxe?
madre(X, B1), madre(X, B2), B1\=B2.

*/

