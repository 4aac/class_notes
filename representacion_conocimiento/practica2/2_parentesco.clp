; Regla para hermano/hermana
(defrule regla-hermano
        (padre ?padre ?hijo1)
        (padre ?padre ?hijo2)
        (test (neq ?hijo1 ?hijo2)) ; No son la misma persona
        =>
        (assert (hermano ?hijo1 ?hijo2))
        (printout t ?hijo1 " es hermano/a de " ?hijo2 crlf)
)

; Regla para tío/tía
(defrule regla-tio
        (padre ?padre ?hijo)
        (hermano ?padre ?tio)
        =>
        (assert (tio ?tio ?hijo))
        (printout t ?tio " es tío/tía de " ?hijo crlf)
)

; Regla para sobrino/sobrina
(defrule regla-sobrino
        (tio ?tio ?sobrino)
        =>
        (assert (sobrino ?sobrino ?tio))
        (printout t ?sobrino " es sobrino/a de " ?tio crlf)
)

; Regla para primo/prima
(defrule regla-primo
        (padre ?padre1 ?hijo1)
        (padre ?padre2 ?hijo2)
        (hermano ?padre1 ?padre2)
        (test (neq ?hijo1 ?hijo2))
        =>
        (assert (primo ?hijo1 ?hijo2))
        (printout t ?hijo1 " es primo/a de " ?hijo2 crlf)
)

; Regla para abuelo/abuela
(defrule regla-abuelo
        (padre ?padre ?hijo)
        (padre ?abuelo ?padre)
        =>
        (assert (abuelo ?abuelo ?hijo))
        (printout t ?abuelo " es abuelo/a de " ?hijo crlf)
)