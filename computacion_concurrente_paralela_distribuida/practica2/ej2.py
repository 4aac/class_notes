# ASIER, IAGO, ALEJANDRO
# 2º GRIA - CCPD

# EJ2 
"""
2. [2.5 puntos] Procesamiento concurrente de informacion contenida en un archivo.
Desarrolla un programa en Python que utilice hilos para realizar de manera concurrente el conteo de
apariciones de numeros en un archivo. El programa debe cumplir las siguientes especificaciones:
(a) El programa principal creara un primer hilo llamado generador que se encargue de generar un archivo
con numeros. Este archivo tendra tantas lineas como indique el usuario a traves de un argumento y
cada linea contendra un numero generado aleatoriamente en un rango igual al numero de hilos que
se cree para hacer el conteo concurrente, por ejemplo, si se indican 4 threads los numeros a generar
podran ser [1,2,3,4] Este numero se indicara a traves de un segundo argumento.
(b) El programa principal esperara a que el hilo generador termine e indicara el tiempo que se ha utilizado
para crear dicho archivo.
(c) A continuacion, el programa principal creara un grupo de hilos contadores que se encargaran de
hacer el conteo concurrente de la siguiente manera: Cada hilo abrira el archivo, lo leera linea a linea
y almacenara en una variable privada el numero de veces que aparece el numero igual a su numero
de hilo. Una vez hecho esto, cada hilo imprimira el numero de veces que aparece dicho numero.
Por ultimo, se utilizara un candado para llevar una cuenta de que numero es el mas frecuente y su
numero de apariciones. Para esto ultimo, utilizar variables globales.
(d) El programa principal esperara a que todos los hilos terminen de hacer su tarea e imprimira el tiempo
necesario para realizar el conteo concurrente. Ademas, imprimira el valor y numero de apariciones
del numero que se repite mas veces.
"""

import threading
import random
import time

num_max_freq = None
max_count = 0
lock = threading.Lock()

def generar_archivo(nombre_archivo, num_lineas, num_threads):
    with open(nombre_archivo, "w") as archivo:
        for _ in range(num_lineas):
            archivo.write(f"{random.randint(1, num_threads)}\n")  # Escribimos un número entre 1 y el número de hilos

def contar_num(nombre_archivo, numero_a_contar):
    global num_max_freq, max_count
    contador_local = 0
    
    with open(nombre_archivo, "r") as archivo:
        for line in archivo:
            if int(line) == numero_a_contar:  # Si el número es el que buscamos aumentamos el contador
                contador_local += 1
    
    print(f"\nNúmero {numero_a_contar}: {contador_local} apariciones")

    # Si el contador local es mayor que el global, actualizamos
    with lock:  # Nos aseguramos que solo un hilo a la vez acceda
        if contador_local > max_count:
            max_count = contador_local
            num_max_freq = numero_a_contar

def main(num_lineas, num_threads):
    nombre_archivo = "numeros.txt"

    # Generamos el archivo
    hilo_generador = threading.Thread(target=generar_archivo, args=(nombre_archivo, num_lineas, num_threads))
    start_time = time.time()
    hilo_generador.start()
    hilo_generador.join()
    end_time = time.time()
    print(f"\nTiempo de generación del archivo: {end_time - start_time:.8f} segundos.")

    # Contamos el número de apariciones
    hilo_contador = []
    start_time = time.time()
    for i in range(1, num_threads + 1):
        thread = threading.Thread(target=contar_num, args=(nombre_archivo, i))
        hilo_contador.append(thread)
        thread.start()
    
    for thread in hilo_contador:
        thread.join()
    end_time = time.time()
    
    print(f"\nTiempo total del conteo: {end_time - start_time:.4f} segundos")
    print(f"\nNúmero más frecuente: {num_max_freq} con {max_count} apariciones")

if __name__ == "__main__":
    num_lineas = int(input("\nCantidad de líneas a generar: "))
    num_threads = int(input("Cantidad de hilos contadores: "))
    main(num_lineas, num_threads)