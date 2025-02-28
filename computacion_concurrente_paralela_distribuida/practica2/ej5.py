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
import time
import random
from queue import Queue

total_datos = 20
tamaño_cola = 5

temperatura_cola = Queue(maxsize=tamaño_cola)
humedad_cola = Queue(maxsize=tamaño_cola)

evento_final = threading.Event()

def productor():
    for i in range(1, total_datos+1):
        hora = time.strftime("%H:%M:%S")

        # Cada segundo añadir un dato de temperatura
        temperatura = round(random.uniform(-10,40), 2)
        if temperatura_cola.full():
            print(f"PRODUCTOR: Cola de temperatura llena, no se puede agregar")
        else:
            temperatura_cola.put((temperatura,hora))
            print(f"PRODUCTOR: Temperatura generada y añadida: {temperatura} ºC a las {hora}")

        # Cada 5 segundos añadir un dato de humedad
        if i%5 == 0:
            humedad=round(random.uniform(0,100), 2)
            if humedad_cola.full():
                print("PRODUCTOR: Cola de humedad llena, no se puede agregar")
            else:
                humedad_cola.put((humedad,hora))
                print(f"PRODUCTOR: Humedad generada y añadida: {humedad} % a las {hora}")
    
        time.sleep(1) #Captura cada segundo

    evento_final.set() 
    temperatura_cola.put((None, ""))
    humedad_cola.put((None, ""))

def consumidor_temperatura():
    cola_vacia = False
    while cola_vacia:
        temperatura, hora = temperatura_cola.get()
        if temperatura == None:
            cola_vacia = True
        print(f"CONSUMIDOR TEMPERATURA: Temperatura consumida: {temperatura} ºC a las {hora}")
    print("CONSUMIDOR TEMPERATURA: Finalizado")

def consumidor_humedad():
    cola_vacia = False
    while cola_vacia:
        humedad, hora = humedad_cola.get()
        if humedad == None:
            cola_vacia = True
        print(f"CONSUMIDOR HUMEDAD:Humedad consumida:{humedad} % a las {hora}")
    print("CONSUMIDOR HUMEDAD: Finalizado")  

hilo_productor = threading.Thread(target=productor)
hilo_consumidor_temp = threading.Thread(target=consumidor_temperatura)
hilo_consumidor_hum = threading.Thread(target=consumidor_humedad)

hilo_productor.start()
hilo_consumidor_temp.start()
hilo_consumidor_hum.start()

hilo_productor.join()
hilo_consumidor_temp.join()
hilo_consumidor_hum.join()


print("Programa finalizado")