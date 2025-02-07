x = c(4.1, 5, 6.35)
x

# En un vector todso los elementos deben ser del mismo tipo
# En otro caso, si se combinan tipos, acaban siendo siempre character
y = c(4, 6,3, "character")
class(y)


seq(1, 5, 0.5)
seq(from=1, to=20, length=9)
rep(1,5)
sequence(4:5)
gl(3,5)

# R es un lenguaje de tipo matricial por lo que al sumar un vector con un entero, convierte los enteros a vectores
x = c(1,2,3)
x+5

# NA: valores perdidos en algunso campos de la muestra
# NaN: resultado de una indeterminaci´no (0/0, inf...)
# Inf: R puede representar valores infinitos correctamente

is.na(x) # Valores vacíos
!is.na(x) # Devuelve los valores no vacíos
x[is.nan(x)]<-0 # Cambia los valores vacíos por 0
which(is.nan(c)) # Devuelve las posiciones de c que toman los valores nanm

range(x)
min(x)
max(x)
?which()


# FACTORES
# Los factores incluyen valos de las varibales y posibles niveles de esta (por ejemplo 0-hombre 1-mujer) 
# con variables categóricas (toman un número finito de valores)
sexo = c(0,1,0,1)
sexo2 = factor(sexo)
sexo3 = factor( sexo, labels=c("Hombre,", "Mujer") )  # Cambia los valores del factor por sus niveles
levels(sexo3)  # Devuelve los niveles del factor

# MATRICES
x=matrix(1:6, nr=2, nc=3)
x
matrix(1:6, 2, 3)  # Por columnas
matrix(1:6, 2, 3, byrow=TRUE)  # Por filas
dim(x)

# Otra forma de crear matrices
y = 1:15
dim(y) = c(5,3)
y

M = matrix(c(1,2,3,11,12,13), 
    nrow=2, ncol=3, byrow=TRUE, 
    dimnames=list(c("A","B"), c("C","D","E"))) # Nombre a las filas y columnas
M

M[1,1]
M[,1]
M[1,]
M[1,-c(1:2)]  # Devuelve la fila 1 y todas las columnas menos la 1 y la 2


# ARRAY
M = array(1:24, dim=c(4,3,2))  # 2 de 4x3
M

# si realizamos un cbind y un rbind y las dimensiones no son correctas, devuelve error

A = matrix(1:4, nr=2, nc=2)
solve(A)  # Inversa de la matriz
diag(A)  # Devuelve una diagonal o crea una matriz diagonal

B = matrix(1:6, nr=2, nc=3)
diag(B)

# eigen() devuelve los autovalores y autovectoes de una matriz

M = matrix(1:9, nr=3, nc=3)
M_inv = solve(M)
M %*% M_inv

# Producto exterior
# outer(A, B, func) realiza la función que se indique entre A y B
outer(A, B, "*")

# Función apply
# Columnas = 2   ;   Filas = 1
M = matrix(1:9, nrow=3)
col.sums = apply(M, 2, sum)
row.sums = apply(M, 1, sum)
apply(M, 1, is.vector)  # Nos indica si las filas son vectores

# Función tapply
# tapply es para factores (hace un groupby como es SQL)
provincia = c(1,2,3,4,2,1,3,2,2,4,2,1,4,4,2,3)
provincia = factor(provincia, labels = c("Coruña", "Lugo", "Ourense", "Pontevedra"))
hijos = c(4,5,3,4,2,5,3,6,2,4,2,5,4,4,5,6)
tapply(hijos, provincia, mean)  # group by provincia
# media del vector hijos agrupado por provincias


# LISTAS
x = c(1,2,3,4)
y = c("Hombre", "Mujer")
z = matrix(1:12, ncol=2)
L1 = list(x,y,z)

L1[2]
L1[[2]][2]
# [[X]] accede al vecto X y contecatenado con [Y] accedemos al elemento Y del vector
