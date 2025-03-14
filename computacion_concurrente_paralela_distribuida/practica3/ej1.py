# ASIER, IAGO, ALEJANDRO
# 2º GRIA - CCPD - GRUPO 6

# EJ1
"""
1. [2 puntos] Analisis de las diferencias en el uso de memoria entre hilos y procesos.
Escribe pequeños script Python que permitan comprobar lo siguiente:
    (a) Los hilos de un mismo grupo comparten espacio de memoria.
    (b) Los procesos de un mismo grupo no comparten su espacio de memoria.
    (c) Una version multiproceso de un codigo consume mas memoria que el equivalente multihilo.
    (d) Existe una diferencia entre el tiempo de creacion de un hilo y un proceso.
"""

import threading
import multiprocessing
from memory_profiler import memory_usage
import time


# APARTADO A
def hilo(letra):
    lista1.append(letra)


# APARTADO B
def proceso(letra):
    try:
        lista2.append(letra)
    except:
        print(f"No se ha podido añadir la letra {letra}")


# APARTADO C
def hilo_memoria():
    a = [0] * 10**6

def proceso_memoria():
    b = [0] * 10**6

def medir_hilos(num):
    hilos = [threading.Thread(target=hilo_memoria) for _ in range(num)]
    for h in hilos: h.start()
    for h in hilos: h.join()

def medir_procesos(num):
    procesos = [multiprocessing.Process(target=proceso_memoria) for _ in range(num)]
    for p in procesos: p.start()
    for p in procesos: p.join()


# APARTADO D
def tarea_prueba():
    pass


if __name__ == "__main__":

    # APARTADO A
    print("")
    print("APARTADO A")

    lista1 = list()

    hilo1 = threading.Thread(target=hilo, args=("a",))
    hilo2 = threading.Thread(target=hilo, args=("b",))

    hilo1.start()
    hilo2.start()

    hilo1.join()
    hilo2.join()

    print("Lista compartida:", lista1)
    print("")


    # APARTADO B
    print("APARTADO B")

    lista2 = list()

    proceso1 = multiprocessing.Process(target=proceso, args=("a",))
    proceso2 = multiprocessing.Process(target=proceso, args=("b",))

    proceso1.start()
    proceso2.start()

    proceso1.join()
    proceso2.join()

    print("Lista compartida entre procesos:", list(lista2))
    print("")


    # APARTADO C
    print("APARTADO C")

    memoria_hilo = memory_usage(medir_hilos(8))
    memoria_proceso = memory_usage(medir_procesos(8))

    print(f"Uso máximo de memoria con hilos: {max(memoria_hilo):.2f} MB")
    print(f"Uso máximo de memoria con procesos: {max(memoria_proceso):.2f} MB")
    print("")


    # APARTADO D
    print("APARTADO D")
    
    # Medir tiempo de creación de un hilo
    start_time = time.time()
    thread = threading.Thread(target=tarea_prueba)
    thread.start()
    thread.join()
    tiempo_hilo = time.time() - start_time

    # Medir tiempo de creación de un proceso
    start_time = time.time()
    process = multiprocessing.Process(target=tarea_prueba)
    process.start()
    process.join()
    tiempo_proceso = time.time() - start_time

    print(f"Tiempo de creación de un hilo: {tiempo_hilo:.6f} s")
    print(f"Tiempo de creación de un proceso: {tiempo_proceso:.6f} s")
    print(f"Diferencia: {tiempo_proceso - tiempo_hilo:.6f} s")
    print("")
