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

posicion = 1
posicion_lock = threading.Lock()

def carrera(id_coche, longitud_carrera):
    global posicion
        
    # Tiempo aleatorio para llegar a la línea de salida
    tiempo_llegada = randint(1, 10)
    time.sleep(tiempo_llegada)
    print(f"El coche {id_coche} ha llegado a la línea de salida en {tiempo_llegada} segundos")
    
    # Esperar a que todos los coches lleguen a la línea de salida
    inicio_carrera.wait()
    
    # Cada coche recorre una distancia aleatoria hasta cruzar la meta
    start = time.time()
    distancia_recorrida = 0
    while distancia_recorrida < longitud_carrera:
        distancia_recorrida += randint(1,10)
        time.sleep(0.1)
    end = time.time()

    print(f"El coche {id_coche} ha cruzado la meta en {end-start:.4f} segundos")
    
    # Asignar posición de llegada con sincronización
    with posicion_lock:
        posicion_local = posicion
        posicion += 1

    fin_carrera.wait()
    

def main():
    num_coches = int(input("Ingrese el número de coches en la carrera: "))
    longitud_carrera = int(input("Ingrese la longitud de la carrera: "))
    
    global inicio_carrera
    inicio_carrera = threading.Barrier(num_coches)
    
    hilos = list
    for coche in range(1, num_coches+1):
        hilo = threading.Thread(target=carrera, args=(coche, longitud_carrera))
        hilos.append(hilo)
        hilo.start()

    global fin_carrera
    fin_carrera = threading.Barrier(num_coches)
    
    for hilo in hilos:
        hilo.join()
    
    print("\nLa carrera ha finalizado")

if __name__ == "__main__":
    main()