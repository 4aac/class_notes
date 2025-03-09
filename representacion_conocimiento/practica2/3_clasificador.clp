; R1: Si tiene pelo, es mamífero
(defrule R1
        (Animal ?nombre tiene-pelo)
        =>
        (assert (Especie ?nombre mamifero))
)       

; R2: Si produce leche, es mamífero
(defrule R2
        (Animal ?nombre produce-leche)
        =>
        (assert (Especie ?nombre mamifero))
)       

; R3: Si tiene plumas, es ave
(defrule R3
        (Animal ?nombre tiene-plumas)
        =>
        (assert (Especie ?nombre ave))
)       

; R4: Si vuela y pone huevos, es ave
(defrule R4
        (Animal ?nombre vuela)
        (Animal ?nombre pone-ovos)
        =>
        (assert (Especie ?nombre ave))
)

; R5: Si come carne, es carnívoro
(defrule R5
        (Animal ?nombre come-carne)
        =>
        (assert (Especie ?nombre carnivoro))
)       

; R6: Si tiene dientes puntiagudos, garras y ojos al frente, es carnívoro
(defrule R6
        (Animal ?nombre tiene-dientes-puntiagudos)
        (Animal ?nombre tiene-garras)
        (Animal ?nombre ojos-al-frente)
        =>
        (assert (Especie ?nombre carnivoro))
)

; R7: Si es mamífero y tiene pezuños, es ungulado
(defrule R7
        (Especie ?nombre mamifero)
        (Animal ?nombre tiene-pezunos)
        =>
        (assert (Especie ?nombre ungulado))
)

; R8: Si es mamífero y rumia, es ungulado
(defrule R8
        (Especie ?nombre mamifero)
        (Animal ?nombre rumia)
        =>
        (assert (Especie ?nombre ungulado))
)

; R9: Si es mamífero, carnívoro y tiene manchas, es leopardo
(defrule R9
        (Especie ?nombre mamifero)
        (Especie ?nombre carnivoro)
        (Animal ?nombre tiene-manchas-escuras)
        (Animal ?nombre cor-leonada)
        =>
        (assert (Especie ?nombre leopardo))
)

; R10: Si es mamífero, carnívoro y tiene rayas, es tigre
(defrule R10
        (Especie ?nombre mamifero)
        (Especie ?nombre carnivoro)
        (Animal ?nombre tiene-raias-negras)
        (Animal ?nombre cor-leonada)
        =>
        (assert (Especie ?nombre tigre))
)

; R11: Si es ungulado, tiene pescozo y patas largas y manchas, es jirafa
(defrule R11
        (Especie ?nombre ungulado)
        (Animal ?nombre pescozo-largo)
        (Animal ?nombre patas-largas)
        (Animal ?nombre tiene-manchas-escuras)
        =>
        (assert (Especie ?nombre jirafa))
)

; R12: Si es ungulado y tiene rayas negras, es cebra
(defrule R12
        (Especie ?nombre ungulado)
        (Animal ?nombre tiene-raias-negras)
        =>
        (assert (Especie ?nombre cebra))
)

; R13: Si es ave, no vuela y tiene pescozo y patas largas, es avestruz
(defrule R13
        (Especie ?nombre ave)
        (Animal ?nombre no-vuela)
        (Animal ?nombre pescozo-largo)
        (Animal ?nombre patas-largas)
        =>
        (assert (Especie ?nombre avestruz))
)

; R14: Si es ave, no vuela, nada y es blanco y negro, es pingüín
(defrule R14
        (Especie ?nombre ave)
        (Animal ?nombre no-vuela)
        (Animal ?nombre nada)
        (Animal ?nombre cor-blanca-e-negra)
        =>
        (assert (Especie ?nombre pinguin))
)

; R15: Si es ave y vuela bien, es curuxa
(defrule R15
        (Especie ?nombre ave)
        (Animal ?nombre vuela-bien)
        =>
        (assert (Especie ?nombre curuxa))
)

; R16: Si un animal es de una especie y es padre de otro, el hijo es de la misma especie
(defrule R16
        (Especie ?padre ?especie)
        (Pai ?padre Fillo ?hijo)
        =>
        (assert (Especie ?hijo ?especie))
)

; R17: Si un animal es de una especie y es hijo de otro, el padre es de la misma especie
(defrule R17
        (Especie ?hijo ?especie)
        (Pai ?padre Fillo ?hijo)
        =>
        (assert (Especie ?padre ?especie))
)