; Regra 1: Definición do tipo de cidadán
(defrule regra-tipo-cidadan
        =>
        (printout t "Que tipo de cidadán é (condutor/peón)? ")
        (assert (tipo-cidadan (read)))
)

; Regra 2: Cor do semáforo para condutores
(defrule regra-semaforo-condutor
        (tipo-cidadan condutor)
        =>
        (printout t "Cal é a cor do semáforo para os condutores (verde/ámbar/vermello/intermitente)? ")
        (assert (semaforo condutor (read)))
)

;  Regra 3: Cor do semáforo para peóns
(defrule regra-semaforo-peon
        (tipo-cidadan peon)
        =>
        (printout t "Cal é a cor do semáforo para os peóns (verde/vermello/intermitente)? ")
        (assert (semaforo peon (read)))
)

; Regra 4: O cidadán pode pasar
(defrule regra-pode-pasar
        (tipo-cidadan ?tipo)
        (semaforo ?tipo verde)
        =>
        (printout t "O cidadán " ?tipo " pode pasar" crlf)
)

; Regra 5: O cidadán debe esperar
(defrule regra-debe-esperar
        (tipo-cidadan ?tipo)
        (semaforo ?tipo vermello)
        =>
        (printout t "O cidadán " ?tipo " debe esperar" crlf)
)

; Regra 6: O cidadán pasa con coidado
(defrule regra-con-coidado
        (tipo-cidadan ?tipo)
        (or (semaforo ?tipo ámbar) 
            (semaforo ?tipo intermitente))
        =>
        (printout t "O cidadán " ?tipo " pode pasar con coidado" crlf)
)