from memory_profiler import profile
import time

@profile
def cuadrados(N):
    tiempo1=time.time()
    paresCuadrados = []
    for i in range(1, N*2+1):
        if i % 2 == 0:
            paresCuadrados.append(i**2)
    fin_tiempo1= time.time()
    tiempo= fin_tiempo1-tiempo1
    print('Tiempo bucle:', tiempo)
    return paresCuadrados

@profile
def cuadradosC(N):
    inicio_tiempo2=time.time()
    paresCuadrados=[i**2 for i in range(1, N*2+1) if i%2==0]
    fin_tiempo2=time.time()
    tiempo2= fin_tiempo2-inicio_tiempo2
    print('Tiempo compresión: ', tiempo2)
    return paresCuadrados




if __name__ == "__main__":
    cuadrados(50000)
    cuadradosC(50000)
