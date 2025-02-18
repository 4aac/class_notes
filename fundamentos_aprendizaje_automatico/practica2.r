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


# 13. Desarrolla una función en R llamada triangulo_rectangulo que tome como entrada un número entero largo positivo y construya un triángulo rectángulo con los dígitos del mismo. Por ejemplo, si se proporciona el número 123456789, la función deberá imprimir lo siguiente:

triangulo_rectangulo <- function(n) {
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
