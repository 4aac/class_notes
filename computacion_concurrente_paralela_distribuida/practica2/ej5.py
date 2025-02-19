# ASIER, IAGO, ...
# 2º GRIA - CCPD

# EJ5
"""
5. [3 puntos] Resolucion del problema del productor-consumidor mediante hilos.
Desarrolla un programa en Python que utilice hilos para simular el funcionamiento de una estacion meteorologica. El programa debe cumplir las siguientes especificaciones:
(a) El programa principal creara un hilo productor y dos hilos consumidores.
(b) El hilo productor simulara la captura realista de datos de temperatura y humedad. El numero de
datos a generar sera un parametro del programa. Mientras no se alcance el numero total de datos a
generar, se producira un dato de temperatura cada segundo y un dato de humedad cada 5 segundos.
(c) Se utilizaran dos colas para almacenar los datos de temperatura y humedad, junto con la hora de
obtencion del mismo. El tamano maximo de cada cola sera de 5 elementos. Los hilos productores
y consumidores deben incluir mecanismos para indicar cuando no han podido producir/consumir un
elemento de la cola.
(d) Los hilos consumidores intentaran procesar datos de las respectivas colas de manera indefinida hasta
que reciban un dato especial indicando la finalizacion. Cada vez que consuman un dato, lo mostraran
por pantalla junto con la hora de generacion de dicho dato.
(e) El programa principal esperara a que el hilo productor termine y lo mostrara por pantalla. A
continuacion esperara a que cada una de las colas termine, momento en el cual introducira el elemento
especial para indicar a los hilos consumidores que finalicen su ejecucion. Finalmente esperara a la
finalizacion de ambos consumidores e indicara la finalizacion del programa.
"""

import threading
import queue

def productor_consumidor(num_datos):
    ...