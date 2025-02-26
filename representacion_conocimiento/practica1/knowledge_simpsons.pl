/* Hechos */
hombre(homer).
hombre(bart).
mujer(lisa).
mujer(maggie).
padre(homer, bart).
padre(homer, lisa).
padre(homer, maggie).

/* Reglas */
hijo(X, Y) :- padre(Y, X), hombre(X).
hermanos(X, Y) :- padre(Z, X), padre(Z, Y), X \== Y.
