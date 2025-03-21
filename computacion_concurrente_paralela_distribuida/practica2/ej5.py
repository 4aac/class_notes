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
from datetime import datetime

# Colas con tamaño máximo de 5 elementos
cola_temperatura = Queue(maxsize=5)
cola_humedad = Queue(maxsize=5)

# Elemento especial para indicar finalización
FIN = "FIN"

def productor(num_datos):
    """
    Hilo productor que genera datos de temperatura (cada 1s) y humedad (cada 5s)
    """
    datos_producidos = 0
    
    while datos_producidos < num_datos:
        # Generar temperatura cada segundo
        temperatura = random.randint(-10, 40)  # Corregido a enteros como en el original
        timestamp = datetime.now().strftime("%H:%M:%S")
        dato_temp = (temperatura, timestamp)
        
        if not cola_temperatura.full():
            cola_temperatura.put(dato_temp)
            print(f"Producido temperatura: {temperatura:.1f}°C a las {timestamp}")
            datos_producidos += 1
        else:
            print("Cola de temperatura llena, no se pudo producir dato")
        
        time.sleep(1)  # Espera de 1 segundo entre temperaturas
        
        # Generar humedad cada 5
        if datos_producidos % 5 == 0:
            humedad = random.randint(0, 100)  # Corregido a enteros como en el original
            timestamp = datetime.now().strftime("%H:%M:%S")
            dato_hum = (humedad, timestamp)
            
            if not cola_humedad.full():
                cola_humedad.put(dato_hum)
                print(f"Producido humedad: {humedad:.1f}% a las {timestamp}")
            else:
                print("Cola de humedad llena, no se pudo producir dato")
        
    print("Productor ha terminado de generar datos")

def consumidor_temperatura():
    """
    Hilo consumidor que procesa datos de temperatura
    """
    continuar = True
    while continuar:
        dato = cola_temperatura.get()
        if dato == FIN:
            cola_temperatura.task_done()
            continuar = False
        else:  # Solo desempaquetar si no es FIN
            temperatura, timestamp = dato
            print(f"Consumido temperatura: {temperatura:.1f}°C generado a las {timestamp}")
            cola_temperatura.task_done()

def consumidor_humedad():
    """
    Hilo consumidor que procesa datos de humedad
    """
    continuar = True
    while continuar:
        dato = cola_humedad.get()
        if dato == FIN:
            cola_humedad.task_done()
            continuar = False
        else:  # Solo desempaquetar si no es FIN
            humedad, timestamp = dato
            print(f"Consumido humedad: {humedad:.1f}% generado a las {timestamp}")
            cola_humedad.task_done()

def main():
    num_datos = 10
    
    # Crear hilos
    hilo_productor = threading.Thread(target=productor, args=(num_datos,))
    hilo_cons_temp = threading.Thread(target=consumidor_temperatura)
    hilo_cons_hum = threading.Thread(target=consumidor_humedad)
    
    # Iniciar hilos
    hilo_productor.start()
    hilo_cons_temp.start()
    hilo_cons_hum.start()
    
    # Esperar a que el productor termine
    hilo_productor.join()
    print("El hilo productor ha finalizado")
    
    # Esperar a que las colas se vacíen
    cola_temperatura.join()
    cola_humedad.join()
    
    # Insertar elemento especial de finalización
    cola_temperatura.put(FIN)
    cola_humedad.put(FIN)
    
    # Esperar a que los consumidores terminen
    hilo_cons_temp.join()
    hilo_cons_hum.join()
    
    print("Programa finalizado")

if __name__ == "__main__":
    main()