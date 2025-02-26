# ASIER, IAGO, ...
# 2º GRIA - CCPD

# EJ4 
"""
4. [2 puntos] Uso basico de mecanismos de sincronizacion
Desarrolla un programa en Python que simule una carrera de coches. El programa debe cumplir las
siguientes especificaciones:
(a) El programa recibira como argumentos el numero de coches que participan en la carrera y la longitud
en metros de la misma.
(b) El programa principal creara tantos hilos como coches a participar en la carrera y esperara a la
finalizacion de todos, indicando entonces por pantalla que la carrera se ha terminado.
(c) Todos los hilos representando a los coches ejecutaran una misma funcion que realizara las siguientes
tareas:
    • El coche se dirigira a la linea de salida, lo que le llevara un tiempo aleatorio de entre 1 y 10
    segundos.
    • Una vez en la linea de salida, el coche esperara a que todos los demas esten listos, momento en
    el cual dara comienzo la carrera.
    • El desarrollo de la carrera se simulara con un bucle en el que cada coche ira recorriendo fracciones
    de la distancia total, de una longitud aleatoria de entre 1 y 10 metros. Cada una de estas
    fracciones sera recorrida en 0.1 segundos.
    • Cada coche imprimira por pantalla la hora en el momento de cruzar la linea de meta y esperara
    a que todos los coches lleguen a meta.
    • Una vez que todos los coches crucen la meta, cada coche imprimira la posicion en la que ha
    terminado. Para saber cuantos coches han terminado en un momento dado, utiliza una variable
    global posicion cuyas modificaciones esten controladas con un mecanismo de sincronizacion.
"""

import threading
import time
from random import randint

posicion = dict()
def carrera_coches(num_coches, longitud):
    global posicion

    # Creamos las distancias para cada coche
    distancias_restantes = dict()
    for i in range(num_coches):
        distancias_restantes[f"coche{i+1}"] = longitud

    
        
    