/* HECHOS */ 

hombre(pablo).
hombre(daniel).
hombre(victor).
mujer(laura).

trabaja(pablo, investigador).
trabaja(laura, investigador).
trabaja(daniel, investigador).
trabaja(victor, profesor).

amigos(laura, pablo).
amigos(pablo, laura).
amigos(laura, daniel).

gusta(daniel, chocolate).
gusta(pablo, chocolate).
gusta(laura, niños).


/* REGLAS */ 

% Se traballa como profesor, entón gústanlle os nenos
gusta(X, niños) :- trabaja(X, profesor).

% Se traballa como investigador, gústalle o café.
gusta(X, cafe) :- trabaja(X, investigador).

% Se traballa como investigador e gústalle o chocolate, é lacazán.
es(X, lacazan) :- trabaja(X, investigador), gusta(X, chocolate).

% Se lles gusta o chocolate, son amigos entre si.
amigos(X, Y) :- gusta(X, chocolate), gusta(Y, chocolate), X \= Y.

% Se un investigador é amigo dunha muller, é listo.
es(X, listo) :- trabaja(X, investigador), amigos(X, Y), mujer(Y).