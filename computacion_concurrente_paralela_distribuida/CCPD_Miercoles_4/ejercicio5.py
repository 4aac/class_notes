import multiprocessing
import time

def tarea(num, tiempos):
    # Simulaci´on de una tarea que toma 'num' segundos
    inicio = time.time()
    print(f"Proceso {num} iniciado")
    time.sleep(num)
    fin = time.time()
    tiempos[num] = fin - inicio
    print(f"Proceso {num} terminado. Tiempo transcurrido: {tiempos[num]} segundos")

if __name__ == "__main__":
    # N´umero de procesos a ejecutar
    num_procesos = 4

    # Crear una lista de procesos
    procesos = []

    # Diccionario compartido para almacenar los tiempos de cada proceso
    tiempos = multiprocessing.Manager().dict()

    # Medir el tiempo total de cómputo en paralelo
    inicio_paralelo = time.time()
    

    for i in range(num_procesos):
        proceso = multiprocessing.Process(target=tarea, args=(i+1, tiempos))
        procesos.append(proceso)
        proceso.start()

    # Esperar a que todos los procesos terminen
    for proceso in procesos:
        proceso.join()
    
    fin_paralelo = time.time()
    tiempo_total_paralelo = fin_paralelo - inicio_paralelo

    #Tiempo de cómputo total de todas las tareas paralelas
    suma_tiempos_paralelos = sum(tiempos.values())


    print(f"\nTiempo total en paralelo: {tiempo_total_paralelo:.4f} segundos")
    print(f"Suma de tiempos de tareas en paralelo: {suma_tiempos_paralelos:.4f} segundos")

    # Repetir el c´alculo con un solo proceso
    tiempos_secuenciales = {}
    inicio_secuencial = time.time()
    for i in range(num_procesos):
        tarea(i+1, tiempos)
    fin_secuencial = time.time()
    tiempo_total_secuencial = fin_secuencial - inicio_secuencial
    
    print(f"\nTiempo total en secuencial: {tiempo_total_secuencial:.4f} segundos")

    #Calcular speedup y eficiencia

    speedup = tiempo_total_secuencial / tiempo_total_paralelo
    eficiencia = speedup / num_procesos
    
    print(f"Speedup: {speedup:.4f}. La ejecución paralela es {speedup:.4f} veces más rápida que la secuencial ")
    print(f"Eficiencia: {eficiencia:.4f}. La eficiencia es baja debido a que aunque la primera tarea tarde un segundo, debido al join como van a acabar todas a la vez hay tiempo que no se va a estar utilizando, no se aprovechan los procesos.")

