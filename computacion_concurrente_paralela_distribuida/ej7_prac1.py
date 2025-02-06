import time

def cuadrados_normal(N):
    lista_cuadrados = list()
    for num in range(N):
        if num % 2 == 0:
            lista_cuadrados.append(num**2)
    return lista_cuadrados

def cuadrados_comprension(N):
    return [i**2 for i in range(N) if i%2==0]

cantidad = 1000000
tiempo_incio1 = time.time()
cuadrados_normal(cantidad)
tiempo_final1 = time.time()
print(f"Tiempo ejercicio normal = {tiempo_final1-tiempo_incio1}")

tiempo_incio2 = time.time()
cuadrados_comprension(cantidad)
tiempo_final2 = time.time()
print(f"Tiempo ejercicio por compresion = {tiempo_final2-tiempo_incio2}")

print(f"La diferencia es de {(tiempo_final1-tiempo_incio1) - (tiempo_final2-tiempo_incio2)}")