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
import time

contador2 = 0
lock = threading.Lock()

# Función que incrementa el contador con sincronización añadiéndole el lock
def con_incrementar(n,):
    global contador2
    for _ in range(n):
        with lock:
            contador2 += int(1)

# Función que decrementa el contador con sincronización con el lock incluido
def con_decrementar(n,):
    global contador2
    for _ in range(n):
        with lock:
            contador2 -= int(1)

def con_sincronizar():
    n = 10000000  # Número de operaciones por hilo
    
    hilo1 = threading.Thread(target=con_incrementar, args=(n,))
    hilo2 = threading.Thread(target=con_decrementar, args=(n,))
    
    hilo1.start()
    hilo2.start()
    
    hilo1.join()
    hilo2.join()
    
    print(f"Valor final del contador (con sincronización): {contador2}")


# ------------------------ # 


contador2 = 0
lock = threading.Lock()

# Función que incrementa el contador con sincronización añadiéndole el lock
def con_incrementar(n,):
    global contador2
    for _ in range(n):
        with lock:
            contador2 += 1

# Función que decrementa el contador con sincronización con el lock incluido
def con_decrementar(n,):
    global contador2
    for _ in range(n):
        with lock:
            contador2 -= 1

def con_sincronizar():
    n = 10000000  # Número de operaciones por hilo
    
    hilo1 = threading.Thread(target=con_incrementar, args=(n,))
    hilo2 = threading.Thread(target=con_decrementar, args=(n,))
    
    hilo1.start()
    hilo2.start()
    
    hilo1.join()
    hilo2.join()
    
    print(f"Valor final del contador (con sincronización): {contador2}")

if __name__ == "__main__":
    start = time.time()
    con_sincronizar()
    end = time.time()
    print(f'Tiempo de ejecución {end-start} s.')


    start = time.time()
    con_sincronizar()
    end = time.time()
    print(f'Tiempo de ejecución {end-start} s.')

