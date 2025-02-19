# ASIER, IAGO, ...
# 2º GRIA - CCPD

# EJ3
"""
3. [1 punto] Condiciones de carrera.
Desarrolla un programa en Python que utilice hilos para mostrar el efecto de una condicion de carrera
sobre una variable compartida.
(a) El programa creara y gestionara 2 hilos que se ejecutaran de manera concurrente y utilizaran una
misma variable compartida.
(b) La variable compartida debe ser un contador numerico sobre el que los hilos realicen operaciones de
forma concurrente de la siguiente manera: uno de los hilos sumara N veces en el contador y el otro
restara sobre el mismo contador, de manera que si la operacion se realizase correctamente el contador
deberia valer 0 al final.
(c) Al ejecutar el programa debe poder observarse que el acceso no controlado a la variable compartida
produce resultados incorrectos.
(d) Implementa una version alternativa de este mismo programa que utilice alguno de los mecanismos
de sincronizacion entre hilos vistos en clase para solucionar la condicion de carrera.
"""

import threading

def condicion_carrera_incorrecto():
    ...

def condicion_carrera_correcto():
    ...
