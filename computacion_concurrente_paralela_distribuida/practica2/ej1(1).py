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
    global id_imagen
    threads = []
    for i in range(num_imagenes):
        thread = threading.Thread(target=descargar_imagen, args=(106+i, i))
        threads.append(thread)
        thread.start()
    
    for thread in threads:
        thread.join()

def descarga_secuencial(num_imagenes):
    global id_imagen
    for i in range(num_imagenes):
        descargar_imagen(106+num_imagenes+i, num_imagenes + i)

def main(num_imagenes):
    global id_imagen
    # Concurrente
    inicio_concurrente = time.time()
    descarga_concurrente(num_imagenes)
    fin_concurrente = time.time()
    tiempo_concurrente = fin_concurrente - inicio_concurrente

    # Secuencial (continuando la numeración)
    inicio_secuencial = time.time()
    descarga_secuencial(num_imagenes)
    fin_secuencial = time.time()
    tiempo_secuencial = fin_secuencial - inicio_secuencial

    # Tiempos y speedup
    print(f"Tiempo de descarga concurrente: {tiempo_concurrente:.2f} segundos")
    print(f"Tiempo de descarga secuencial: {tiempo_secuencial:.2f} segundos")
    speedup = tiempo_secuencial / tiempo_concurrente
    print(f"Speedup obtenido: {speedup:.2f}")

if __name__ == "__main__":
    num_imagenes = int(input("Ingrese el número de imágenes a descargar: "))
    main(num_imagenes)
