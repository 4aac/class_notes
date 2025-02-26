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
forma concurrente de la siguiente manera: uno de los hilos sumara N veces en el contador1 y el otro
restara sobre el mismo contador, de manera que si la operacion se realizase correctamente el contador1
deberia valer 0 al final.
(c) Al ejecutar el programa debe poder observarse que el acceso no controlado a la variable compartida
produce resultados incorrectos.
(d) Implementa una version alternativa de este mismo programa que utilice alguno de los mecanismos
de sincronizacion entre hilos vistos en clase para solucionar la condicion de carrera.
"""

import threading
import time

contador1 = 0

def sin_sinc_aumentar(n):
    global contador1
    for _ in range(n):
        contador1 += int(1)  # Actúa como función para forzar error

def sin_sinc_disminuir(n):
    global contador1
    for _ in range(n):
        contador1 -= int(1) 

def sin_sincronizacion():
    ops_hilo = 10000000 
    
    hilo1 = threading.Thread(target=sin_sinc_aumentar, args=(ops_hilo,))
    hilo2 = threading.Thread(target=sin_sinc_disminuir, args=(ops_hilo,))
    
    hilo1.start()
    hilo2.start()
    
    hilo1.join()
    hilo2.join()
    
    print(f"Valor final del contador1 (sin sincronizacion): {contador1}")

if __name__ == "__main__":
    start = time.time()
    sin_sincronizacion()
    end = time.time()
    print(f'Tiempo de ejecucion {end-start} segundos')


# --------------------------------------x--------------------------------------


contador2 = 0
lock = threading.Lock()

def con_sinc_aumentar(n):
    global contador2
    for _ in range(n):
        with lock:
            contador2 += int(1)  # Actúa como función para forzar error

def con_sinc_disminuir(n):
    global contador2
    for _ in range(n):
        with lock:
            contador2 -= int(1)

def con_sincronizacion():
    ops_hilo = 10000000 
    
    hilo1 = threading.Thread(target=con_sinc_aumentar, args=(ops_hilo))
    hilo2 = threading.Thread(target=con_sinc_disminuir, args=(ops_hilo))
    
    hilo1.start()
    hilo2.start()
    
    hilo1.join()
    hilo2.join()
    
    print(f"Valor final del contador (con sincronizacion): {contador2}")

if __name__ == "__main__":
    start = time.time()
    con_sincronizacion()
    end = time.time()
    print(f'Tiempo de ejecucion {end-start} segundos')