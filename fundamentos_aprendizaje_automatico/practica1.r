# 1. Instala el paquete car y posteriormente cárgalo utilizando library(car).
install.packages("car")
library(car)


# a) Utiliza la función help(package="car") para obtener la correspondiente ayuda sobre este paquete.
help(package="car")
# La función help muestra la documentación general del paquete "car". Ejecuta el siguiente comando:


# b) ¿Qué tipo de ayuda se obtiene al utilizar el siguiente código?
data(package="car")
# data(package="car") muestra los datasets que están disponibles en el paquete "car".


# c) Recupera el nombre de las variables en cars y haz un listado de los primeros 5 valores.
names(cars)  # Muestra el nombre de las variables
head(cars, 5)  # Muestra los primeros 5 valores del conjunto de datos "cars"


# d) Realiza un gráfico similar al siguiente. ¿Qué tipo de relación existe entre la velocidad del coche y la distancia recorrida hasta parar?
# El conjunto de datos "cars" contiene dos variables: velocidad y distancia.
# cars$speed consigue la varianle $ del dataframe cars
plot(cars$speed, cars$dist, 
     main="Relación entre velocidad y distancia para detenerse", 
     xlab="Velocidad (millas/hora)", 
     ylab="Distancia (pies)", 
     col="blue", 
     pch=19)
# La relación parece ser una tendencia positiva, donde a mayor velocidad, mayor distancia para detenerse.


# 2. Ejecuta el siguiente código
x <- matrix(1:20, nrow=4, ncol=5, byrow=TRUE)  # Crea una matriz con valores del 1 al 20, con 4 filas y 5 columnas:


# a) ¿Qué tipo de estructura es x?
# x es una matriz, ya que es creada con la función matrix(). Tiene 4 filas y 5 columnas.


# b) ¿Para qué sirve el argumento byrow? Compara x con x2 <- matrix(1:20, nrow=4, ncol=5, byrow=F)
# El argumento byrow indica si los valores deben ser rellenados por filas o por columnas. Si byrow=TRUE, los valores se colocan en las filas, mientras que si byrow=FALSE (por defecto), se rellenan por columnas.
x2 <- matrix(1:20, nrow=4, ncol=5, byrow=FALSE)
x  # Los datos se insertan por la fila
x2  # Los datos se insertan por la columna


# c) ¿Qué sucede al sumarle una constante a una matriz?
x + 2  # Al sumar una constante a una matriz, cada uno de sus elementos se incrementa en ese valor.


# d) ¿Y si se suma un vector de longitud 3?
x + c(5, 6, 7)  # Si sumamos un vector de longitud 3, R lo recicla (lo repite) para ajustar su longitud al tamaño de la matriz.

# e) Compara el resultado de x - x[,2] con el de x - x[2,]
x - x[,2]
x - x[2,]
# x[,2] extrae la segunda columna de la matriz x, mientras que x[2,] extrae la segunda fila.
# La diferencia en los resultados es que al restar una columna (x[,2]), estamos restando un vector a cada fila, 
# mientras que al restar una fila (x[2,]), estamos restando una fila de la matriz a cada una de las filas de la matriz.


# 3. Considera la matriz y creada con y <- matrix(rpois(6, 20), nrow=2, ncol=3) # Poisson parámetro 20
y <- matrix(rpois(6, 20), nrow=2, ncol=3)


# a) ¿Qué tipo de ordenación se consigue con los tres comandos siguientes?
sort(y) # Ordena todos los elementos de la matriz
apply(y, 2, sort) # Ordena por columnas
apply(y, 1, sort) # Ordena por filas


# b) El comando diag(y) genera un vector cuyos elementos son la diagonal principal de y. ¿Qué ocurre cuando se aplica diag a una matriz que no es cuadrada?
diag(y)  # Si se aplica diag a una matriz no cuadrada, devuelve un vector con los elementos de la diagonal principal.


# c) Compara los resultados obtenidos con las dos siguientes expresiones: t(y)*diag(y) y t(y) %*% diag(y)
t(y) * diag(y) # Multiplicación elemento a elemento
t(y) %*% diag(y) # Multiplicación matricial


# 4. Crea en R:
# a) un vector x1 con las siguientes componentes (1, 1, 2, 2, 3, 3).
x1 <- c(1, 1, 2, 2, 3, 3)


# b) un vector x2 con 10 componentes equiespaciadas entre 12 y 21.
x2 <- seq(12, 21, length.out=10)


# c) un vector x3 con los números pares entre 6 y 46.
x3 <- seq(6, 46, by=2)


# d) un vector x4 formado por la concatenización de los 3 anteriores.
x4 <- c(x1, x2, x3)


# 5. a) Crea el vector d con las componentes (1, −1, 1, 0, 1, −6, 0, 0, 1)
d <- c(1, -1, 1, 0, 1, -6, 0, 0, 1)


# b) A partir del vector d construye utilizando la función matrix() la matriz D con componentes
D <- matrix(d, nrow=3, ncol=3, byrow=TRUE)


# c) Obtén los vectores formados por la primera columna y segunda fila de D.
primera_columa = D[,1]
primera_columa
segunda_fila = D[2,]
segunda_fila


# d) Calcula la suma de los elementos de D por filas y por columnas utilizando la función apply(). Haz lo mismo utilizando las funciones colSums() y rowSums().
suma_filas_apply <- apply(D, 1, sum)  # Suma por filas
suma_columnas_apply <- apply(D, 2, sum)  # Suma por columnas
suma_filas_apply
suma_columnas_apply

suma_columnas_colSums <- colSums(D)  # Suma por columnas
suma_filas_rowSums <- rowSums(D)  # Suma por filas
suma_columnas_colSums
suma_filas_rowSums


# e) Calcula la transpuesta de D
t(D)


# f) Calcula la inversa de D utilizando la función solve() y guarda el resultado en D2.
D2 <- solve(D)
D2


# g) Calcula el producto de D y D2, y comprueba que el resultado es la matriz identidad.
D %*% D2  # Multiplicación matricial


# 6. R incluye demostraciones de algunas de sus capacidades.
# a) Teclea demo() para ver un listado de dichas demostraciones
demo()


# b) Ejecuta demo(graphics) para ver ejemplos de gráficos con R.
demo(graphics)


# 7. Carga los datos obtenidos con data(iris) y guárdalos en un data.frame llamado datos.
data(iris)
datos = iris
head(datos, 5)


# a) Este conjunto contiene la medida en cm. de las variables longitud y anchura de sépalo y del pétalo para un total de 150 flores de tres especies diferentes de iris (iris setosa, versicolor y virginica). Utiliza las funciones de ayuda de R para obtener la información anterior (en inglés) y el nombre de las variables.

