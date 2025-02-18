# 1. Desarrolla una función en R que, recibiendo como parámetros dos vectores numéricos, determine el número de productos estrictamente positivos obtenidos al multiplicar cada elemento del primer vector por cada elemento del segundo vector. La función deberá devolver este recuento como resultado.
positivos = function(v1, v2) {
    v_result = v1 * v2
    contador = sum(v_result > 0)
    return(contador)
}

v1 = c(1,2,3,4,5,6,7,8)
v2 = c(-1,-2,4,-6,1,-1,4,-7)
positivos(v1, v2)


# 2. Desarrolla una función en R que, recibiendo como parámetros un vector numérico x y un número natural M, realice la suma de los elementos del vector x de manera incremental hasta alcanzar o superar el valor de M. Una vez alcanzado este punto, la función debe devolver lo siguiente: a) La suma obtenida. b) Un vector que contenga los elementos de x utilizados para llegar a dicha suma.
incremental = function(numero, vector) {
    suma = 0
    posicion = 1
    while (suma <= numero) {
        suma = suma + vector[posicion]
        posicion = posicion + 1
    }
    return (list(suma=suma, vector=vector[1:posicion]))
}

numero = 68
vector = c(1, 11, 14, 23, 56, 76)
incremental(numero, vector)


# 3. Desarrolla una función en R que, recibiendo como parámetro un número, determine si es un número natural o no y además: a) en caso de ser un número natural, la función deberá devolver un vector con todos sus divisores. b) Si el número no es natural, deberá mostrar un mensaje de error.
obtener_divisores = function(numero) {
    divisores = c()
    if (numero != as.integer(numero) | numero <= 0) {  # numero != as.integer(numero) 19.1 != as.integer(19.1) -> 19.1 != 19 -> no es entero
        print("Error")                                 #                              19 != as.integer(19) -> 19 == 19 -> es entero
    } else {
        for (i in 1:numero) {
            if (numero %% i == 0) {
                divisores = c(divisores, i)
            }
        }
        print(divisores)
    }
}

numero = 28
obtener_divisores(numero)

numero = 19.1
obtener_divisores(numero)


# 4. Desarrolla un programa en R que determine si un año dado es bisiesto o no. Un año es considerado bisiesto si es divisible por 4, excepto si también es divisible por 100 pero no por 400. Por ejemplo, el año 2000 fue bisiesto, pero 1900 no lo fue. El programa deberá: a) Solicitar al usuario que ingrese un año. b) Verificar si el año ingresado cumple con las condiciones para ser bisiesto. c) Informar al usuario si el año ingresado es bisiesto o no
bisiesto = function () {
    año = readline(prompt = "Escribe un año: ")
    año = as.integer(año)
    if (año %% 4 == 0 && (año %% 100 != 0 || año %% 400 == 0)) {
        print("Es bisiesto")
    } else {
        print("No es bisiesto")
    }
}

bisiesto()


# 5. Desarrolla un programa en R que simule el funcionamiento de un sistema de cobro en un estacionamiento. El programa solicitará al usuario la hora de entrada (hora, minutos y segundos), calculará el tiempo transcurrido hasta el momento actual y calculará la cantidad a pagar utilizando una tarifa de 0,000277778 euros por segundo, con un límite máximo de 24 euros al día. Una vez calculada la cantidad a pagar, el programa solicitará al usuario que ingrese la cantidad en euros. Luego, calculará el cambio a devolver, minimizando la cantidad de billetes de 10e y 5e, así como las monedas necesarias
cobro = function () {
    horas = readline(prompt = "Introduce las horas en el parking: ")
    horas = as.integer(horas)
    minutos = readline(prompt = "Introduce los minutos en el parking: ")
    minutos = as.integer(minutos)
    segundos = readline(prompt = "Introduce los segundos en el parking: ")
    segundos = as.integer(segundos)

    if (minutos >= 60 || segundos >= 60) {
        return (0)
    } else {
        # Calculamos la cantidad a pagar
        segundos = segundos + horas*3600 + minutos*60
        cantidad_a_pagar = segundos * 0.000277778

        if (cantidad_a_pagar > 24) {  # Máximo de 24€
            cantidad_a_pagar = 24
        }

        cat("Cantidad a pagar:", cantidad_a_pagar, "\n")

        pago_cliente = readline(prompt = "Introduzca la cantidad a pagar: ")
        pago_cliente = as.numeric(pago_cliente) 
        while (pago_cliente < cantidad_a_pagar) { 
            print("El pago debe ser mayor o igual al precio indicado")
            pago_cliente = readline(prompt = "Introduzca la cantidad a pagar: ")
            pago_cliente = as.numeric(pago_cliente) 
        }
        
        vuelta = pago_cliente - cantidad_a_pagar
        devolucion = data.frame(
            Billete10 = 0, 
            Billete5 = 0, 
            Moneda2 = 0, 
            Moneda1 = 0, 
            Moneda050 = 0, 
            Moneda020 = 0, 
            Moneda010 = 0, 
            Moneda005 = 0, 
            Monedas002 = 0,
            Moneda001 = 0
        )
        
        if (vuelta > 0) {
            devolucion$Billete10 = floor(vuelta / 10)
            vuelta = vuelta - devolucion$Billete10 * 10
            devolucion$Billete5 = floor(vuelta / 5)
            vuelta = vuelta - devolucion$Billete5 * 5
            devolucion$Moneda2 = floor(vuelta / 2)
            vuelta = vuelta - devolucion$Moneda2 * 2
            devolucion$Moneda1 = floor(vuelta / 1)
            vuelta = vuelta - devolucion$Moneda1 * 1
            devolucion$Moneda050 = floor(vuelta / 0.50)
            vuelta = vuelta - devolucion$Moneda050 * 0.50
            devolucion$Moneda020 = floor(vuelta / 0.20)
            vuelta = vuelta - devolucion$Moneda020 * 0.20
            devolucion$Moneda010 = floor(vuelta / 0.10)
            vuelta = vuelta - devolucion$Moneda010 * 0.10
            devolucion$Moneda005 = floor(vuelta / 0.05)
            vuelta = vuelta - devolucion$Moneda005 * 0.05
            devolucion$Monedas002 = floor(vuelta / 0.02)
            vuelta = vuelta - devolucion$Monedas002 * 0.02
            devolucion$Moneda001 = round(vuelta / 0.01)
        }
        
        print(devolucion)
        return(devolucion)
    }
}

cobro()


# 6. Desarrolla una función en R, llamada “cinco”, que solicite al usuario ingresar 5 números por teclado. La función deberá verificar si alguno de los números ingresados es mayor o igual que 100. Si alguno de los números es mayor o igual que 100, el programa deberá devolver un mensaje de advertencia. En caso contrario, la función calculará la suma de los números ingresados que sean menores que 10 y la devolverá como resultado
cinco = function() {
    numeros = numeric(5)
    for (i in 1:5) {
        numeros[i] = as.numeric(readline(prompt = "Ingresa un número: "))
    }

    if (any(numeros >= 100)) {
        print("Advertencia: hay números mayores o iguales a 100")
        return(NULL)
    } else {
        suma_menores_10 = sum(numeros[numeros < 10])
        return(suma_menores_10)
    }
}

cinco()


# 7. Desarrolla un programa en R que encuentre todos los números enteros positivos menores que 1000 que cumplan la siguiente condición: la suma de las cifras de su cubo debe ser un cuadrado perfecto. Un cuadrado perfecto es un número cuya raíz cuadrada es un número natural. El programa deberá: a) Iterar sobre los números enteros positivos menores que 1000. b) Para cada número, calcular su cubo y luego la suma de las cifras de su cubo. c) Verificar si la suma de las cifras del cubo es un cuadrado perfecto. d) Si lo es, agregar el número a una lista de números que cumplen la condición. e) Finalmente, imprimir la lista de números encontrados que cumplen con la condición.
menores1000 = function() {
    lista_num = c()
    for (i in 1:999) {
        cubo = i**3
        centenas = cubo %/% 100 
        decenas = (cubo %% 100) %/% 10 
        unidades = cubo %% 10  # El resto de mod 10 son las unidades

        cuadrado_perfecto = centenas + decenas + unidades
        if (sqrt(cuadrado_perfecto) == as.integer(sqrt(cuadrado_perfecto))) {
            lista_num = c(lista_num, i)
        }
    }
    return (lista_num)
}

print(menores1000())


# 8. Desarrolla una función en R llamada suma_par_impar que calcule la suma de todos los números pares y todos los números impares comprendidos entre 1 y 200. La función deberá devolver ambas sumas como resultado. El programa deberá: a) Utilizar bucles o funciones de secuencia para generar los números pares e impares. b) Calcular la suma de los números pares y la suma de los números impares. c) Devolver ambas sumas como resultado. Luego de definir la función, deberás llamarla e imprimir las sumas de los números pares y los números impares
suma_par_impar = function() {
    suma_par = 0
    suma_impar = 0
    for (i in 1:200) {
        if (i%%2 == 0) {
            suma_par = suma_par + i
        } else {
            suma_impar = suma_impar + i
        }
    }
    return (list(suma_par = suma_par, suma_impar = suma_impar))
}
suma_par_impar()


# 9. Desarrolla un programa en R que permita analizar un número entero dado por el usuario. El programa deberá: a) Calcular el número de cifras que tiene el número entero. b) Determinar cuál es la menor y la mayor cifra presente en el número. c) Identificar la posición que ocupan la menor y la mayor cifra en el número. d) Finalmente, mostrar al usuario el número de cifras, el valor de la menor y la mayor cifra, y la posición que ocupan cada una de ellas. El programa deberá definir una función llamada analizar_numeros que tome como entrada el número entero a analizar y devuelva los resultados mencionados anteriormente.
analizar_numeros = function() {
    input = as.integer(readline(prompt = "Introduce un número entero: "))
    cifras = c()
    mayor = -Inf
    menor = Inf
    pos_mayor = 0
    pos_menor = 0
    posicion = 1
    
    a = input
    while (a > 0) {
        cifra = a %% 10  # Módulo para conseguir la última cifra del número (4567 -> 7)
        cifras = c(cifras, cifra)
        if (cifra > mayor) {
            mayor = cifra
            pos_mayor = posicion
        } else if (cifra < menor) {
            menor = cifra
            pos_menor = posicion
        }
        a = a %/% 10  # División entera para reducir las decenas (4567 -> 456)
        posicion = posicion + 1
    }
    return(list(input = input, 
                num_cifras = length(cifras), 
                mayor = mayor, 
                pos_mayor = pos_mayor, 
                menor = menor, 
                pos_menor = pos_menor))
}

analizar_numeros()


# 10. Escribe una función par.impar en R que realice la suma de todos los números pares y también de todos los número impares comprendidos entre 1 y 200. La salida se muestra a continuación: > par.impar() La suma de los pares es: 10100 La suma de los impares es: 10000
par.impar = function() {
    suma_par = 0
    suma_impar = 0
    for (i in 1:200) {
        if (i%%2 == 0) {
            suma_par = suma_par + i
        } else {
            suma_impar = suma_impar + i
        }
    }
    cat("La suma de los pares es", suma_par, "\n")
    cat("La suma de los impares es", suma_impar)
}
par.impar()


# 11. Desarrolla una función en R llamada suma_producto que solicite al usuario que introduzca cinco números por teclado. Además, el programa deberá ofrecer al usuario la posibilidad de elegir entre sumar los números o multiplicarlos. Si se elige la opción de suma, la función devolverá un mensaje con el resultado de la suma de los cinco números. Si se elige la opción de producto, la función devolverá un mensaje con el resultado del producto de los cinco números. Para realizar los cálculos, puedes utilizar las funciones sum y prod. El programa deberá definir una función llamada suma_producto que tome como entrada los cinco números ingresados por el usuario y la opción elegida (suma o producto) y devuelva el resultado correspondiente.




# 13. Desarrolla una función en R llamada triangulo_rectangulo que tome como entrada un número entero largo positivo y construya un triángulo rectángulo con los dígitos del mismo. Por ejemplo, si se proporciona el número 123456789, la función deberá imprimir lo siguiente:
triangulo_rectangulo = function(n) {
  n <- as.character(n)
  matriz <- matrix(ncol=1,nrow=nchar(n))
  i = 1
  while (i < nchar(n)+1) {
    matriz[i][1] = substr(n,1,i)
    i = i+1
  }
  print(matriz)
}

triangulo_rectangulo(7384938)
