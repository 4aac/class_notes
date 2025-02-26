(deftemplate FichaPaciente
    (field Nome)
    (field Idade)
    (field Casado)
    (field Sexo)
    (field Peso)
)

(deftemplate DatosExploracion
    (field Nome)
    (multifield Sintomas)
    (field GravidadeAfeccion)
)

(deftemplate Diagnostico
    (field Nombre)
    (field Resultado)
    (field ProximaRevision)
)

(defrule DiagnosticoEccema1
    (DatosExploracion
        (Nome ?N)
        (Sintomas $? picor $? vesiculas $?))
    (FichaPaciente
        (Nome ?N))
 =>
 (printout t "Posible diagnóstico para el paciente " ?N ": Eccema " crlf)
) 

(defrule DiagnosticoEccema2
    (DatosExploracion
        (Nome ?N)
        (Sintomas $? picor $? vesiculas $?))
    (FichaPaciente
        (Nome ?N))
 =>
    (printout t "Posible diagnóstico para el paciente " ?N ": Eccema " crlf)
    (Diagnostico
        (Nome ?N)
        (Resultado ?picor ?vesiculas)
        (ProximaRevision $?)
    )
)

(defrule bebe
    (FichaPaciente
        (Idade < 3)
        (Peso < 5)
    ))
    