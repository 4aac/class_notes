import threading
import requests
import time


def descargar_imagen(id, numero_imagen):
    url = f"https://picsum.photos/id/{id}/1600/900"
    response = requests.get(url)
    i = numero_imagen
    while i > 0:
        if response.ok:
            with open(f"imagen_{numero_imagen}.jpg", "wb") as file:
                file.write(response.content)
            print(f"Imagen {numero_imagen} descargada correctamente.")
            i -= 1
        else:
            print(f"Error al descargar la imagen {numero_imagen}.")

def descarga_concurrente(num_imagenes):
    threads = []
    for i in range(num_imagenes):
        thread = threading.Thread(target=descargar_imagen, args=(100+i, i))
        threads.append(thread)
        thread.start()
    
    for thread in threads:
        thread.join()

def descarga_secuencial(num_imagenes):
    for i in range(num_imagenes):
        descargar_imagen(100+i, i)

def main(num_imagenes):
    # Descarga concurrente
    inicio_concurrente = time.time()
    descarga_concurrente(num_imagenes)
    fin_concurrente = time.time()
    tiempo_concurrente = fin_concurrente - inicio_concurrente

    # Descarga secuencial
    inicio_secuencial = time.time()
    descarga_secuencial(num_imagenes)
    fin_secuencial = time.time()
    tiempo_secuencial = fin_secuencial - inicio_secuencial

    # Mostrar tiempos y speedup
    print(f"Tiempo de descarga concurrente: {tiempo_concurrente:.2f} segundos")
    print(f"Tiempo de descarga secuencial: {tiempo_secuencial:.2f} segundos")
    speedup = tiempo_secuencial / tiempo_concurrente
    print(f"Speedup obtenido: {speedup:.2f}")

if __name__ == "__main__":
    num_imagenes = int(input("Ingrese el número de imágenes a descargar: "))
    main(num_imagenes)

