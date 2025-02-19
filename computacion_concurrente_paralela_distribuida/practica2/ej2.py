# ASIER, IAGO, ...
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
import time

def generador(lineas_archivo, num_hilos):
    ...

def conteo():
    ...