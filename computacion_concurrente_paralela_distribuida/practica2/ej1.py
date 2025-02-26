# ASIER, IAGO, ALEJANDRO
# 2º GRIA - CCPD

# EJ1
"""
1. [1.5 puntos] Decarga concurrente de archivos.
Escribe un programa en Python que permita la descarga concurrente de imagenes de internet siguiendo
las siguientes especificaciones:
(a) El programa debe aceptar un unico parametro correspondiente al numero de imagenes que se desea
descargar.
(b) Implementa una funcion descargar imagen que use la libreria request para descargar una imagen de
la URL https://picsum.photos/id/100/1600/900. Esta URL permite descargar gratuitamente
imagenes aleatorias sin derechos de autor. Cada imagen debe guardarse en disco con un nombre
distinto para evitar sobreescrituras, por ejemplo, imagen [N] siendo N el numero de imagen dentro
del grupo descargado. Esta URL descargara la imagen 100 de la coleccion en resolucion 1600x900.
Cada uno de los N hilos debe descargar una imagen diferente modificando la URL segun sea necesario.
(c) El programa principal debe crear tantos hilos como imagenes se van a descargar y esperar a que
todos los hilos finalicen. La tarea de cada hilo sera descargar una unica imagen.
(d) Despues de terminar la descarga concurrente, el programa principal debe repetir la descarga de las
mismas N imagenes, esta vez de manera secuencial.
(e) Se mostrara el tiempo de ejecucion de las dos alternativas y el speedup obtenido en la version concurrente.
"""

import threading
import requests
import time

id_imagen = 0  # Contador global para nombrar las imágenes
def descargar_imagen(id, numero_imagen):
    global id_imagen
    while True:
        try:
            url = f"https://picsum.photos/id/{id}/1600/900"
            response = requests.get(url)
            with open(f"imagen_{id_imagen+1}.jpg", "wb") as file:
                file.write(response.content)
            print(f"Imagen {id_imagen+1} descargada correctamente.")
            id_imagen += 1
            break  # Salir del bucle si la descarga es exitosa
        except Exception as e:
            print(f"Error al descargar la imagen {numero_imagen+1}. Intentando con otro ID...")
            id += 1  # Intentar con el siguiente ID

def descarga_concurrente(num_imagenes):
    threads = []
    for i in range(num_imagenes):
        thread = threading.Thread(target=descargar_imagen, args=(106+i, i))
        threads.append(thread)
        thread.start()
    
    for thread in threads:
        thread.join()

def descarga_secuencial(num_imagenes):
    for i in range(num_imagenes):
        descargar_imagen(106+i, num_imagenes + i)

def main(num_imagenes):
    global id_imagen

    # Concurrente
    inicio_concurrente = time.time()
    descarga_concurrente(num_imagenes)
    fin_concurrente = time.time()
    tiempo_concurrente = fin_concurrente - inicio_concurrente

    # Secuencial
    inicio_secuencial = time.time()
    descarga_secuencial(num_imagenes)
    fin_secuencial = time.time()
    tiempo_secuencial = fin_secuencial - inicio_secuencial

    # Tiempos y speedup
    print(f"Tiempo de descarga concurrente: {tiempo_concurrente:.5f} segundos")
    print(f"Tiempo de descarga secuencial: {tiempo_secuencial:.5f} segundos")
    speedup = tiempo_secuencial / tiempo_concurrente
    print(f"Speedup obtenido: {speedup:.5f}")

if __name__ == "__main__":
    num_imagenes = int(input("Ingrese el número de imágenes a descargar: "))
    main(num_imagenes)