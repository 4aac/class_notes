# ASIER, IAGO, ...
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

