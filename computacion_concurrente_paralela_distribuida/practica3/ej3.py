# ASIER, IAGO, ALEJANDRO
# 2º GRIA - CCPD - GRUPO 6

# EJ3
"""
3. [1.5 puntos] Paralelizacion de algoritmo de ordenacion.
Implementa el algoritmo de ordenamiento mergesort (https://es.wikipedia.org/wiki/Ordenamiento_
por_mezcla) para ordenar una lista de numeros enteros en una version secuencial y otra multiproceso.
    • El programa tomara como argumentos de entrada el tamaño de la lista y el numero de procesadores
    a utilizar. Se generara una lista de enteros aleatoria del tamaño indicado.
    • La funcion de ordenacion debe recibir una lista de numeros enteros y devolver la lista ordenada.
    • El programa principal comprobara que las listas devueltas por la version secuencial y paralela son iguales.
    • Haz un estudio del rendimiento, en terminos de tiempo de ejecucion, de la version paralela del algoritmo respecto a la 
    secuencial para distintos tamaños de lista y numero de procesadores. Representa graficamente los resultados obtenidos de 
    manera que se pueda observar, al menos:
        – Una comparativa entre el tiempo necesario para las versiones secuencial y paralela variando el
        numero de procesadores a utilizar.
        – El tamaño de lista a partir del cual la version paralelizada es mas rapida que la secuencial,
        utilizando el maximo numero de procesadores disponibles.
"""

