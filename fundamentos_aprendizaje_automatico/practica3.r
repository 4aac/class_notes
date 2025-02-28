# SI SE HACE EN RSTUDIO:
# Para usar esto hay que ir a la barra de arriba, Session, SetWorkingDIrectory, choosedirectory y elegimos la carpeta de class notes

# Trabajaremos a lo largo de este laboratorio con el siguiente ejemplo. Se ha examinado a 25 alumnos, aspirantes a ingresar en el Máster Interuniversitario en Inteligencia Artificial, de 5 materias diferentes: Programación (cuyo resultado se almacena en la variable prog), Ingeniería de Computadores (ingcom), Ingeniería del Software (ingsof), Sistemas de la Información (sist) y Estadística (estad). Las puntuaciones obtenidas se encuentran en el fichero aspirantes.txt y se muestran a continuación.

dat = read.table("aspirantes.txt", header=TRUE)
head(dat)
summary(dat)

# El objetivo de este estudio es obtener un ranking global de alumnos para la entrada en el máster, a través de una puntuación global, extraída como cierta combinación lineal de las calificaciones en las cinco materias examinadas.
# Vamos a realizar entonces un Análisis de Componentes Principales con R. El comando básico de R que ejecuta el análisis de componentes principales es princomp. También se pueden obtener resultados similares con el comando prcomp. La diferencia principal entre uno y otro es que princomp diagonaliza la matriz S, mientras que prcomp diagonaliza la matriz Sc. Esto modifica los autovalores en la proporción n/(n − 1), pero no supone ningún cambio en los autovectores. Hemos optado por el comando princomp. A continuación se muestran las instrucciones que permiten realizar un análisis de componentes principales para el ejemplo, utilizando R. En primer lugar, como salida del objeto se muestran las desviaciones típicas de las componentes, que son las raíces cuadradas de los autovalores de S.

# Analizamos las componentes principales
test.pca = princomp(dat)
test.pca

# Si hacemos un summary del objeto, obtenemos además la proporción de varianza explicada y sus valores acumulados.
summary(test.pca)

# Además de esta información, el objeto test.pca almacena otra información relevante.
names(test.pca)

# S_c = (zt*z) / (n-1) siendo z las matrices de covarianza estandarizadas
# S = (xt*x) / (n-1)

# Como hemos visto, podemos obtener las desviaciones típicas de las componentes. De este modo podemos obtener las varianzas de las componentes, que son los autovalores.
test.pca$sdev  # Desviaciones estandar de cada uno de los componentes que tenmos arriba

test.pca$sdev^2


# ----------------------------# 

# Para calcular las componentes principales, realizamos los siguientes pasos:
# 1. Calculamos la matriz de cuasivarianza
n = dim(dat)[1]  # o nrow(dat)
s = cov(dat)*(n-1)/n
s

# 2. Calculamos los autovalores:
s_autovalores = eigen(s)[1]  # Si no usasemos el 1, dos daría autavalores y autovectores
s_autovalores

# 3. Hacemos la raiz cuadrada de los autovalores:
s_pca = lapply(s_autovalores, sqrt)
s_pca

# 4. Comparamos con la medida real:
test.pca[1]


#####

# También se puede calcular manualmente

datos_centrados= scale(dat, scale=FALSE)  # Quitar el scale para que no se estandaricen los datos
?scale

s2 = 1/n*t(datos_centrados)%*%datos_centrados
s2

s2_autovalores = eigen(s2)[1]  # Si no usasemos el 1, dos daría autavalores y autovectores
s2_autovalores

# 3. Hacemos la raiz cuadrada de los autovalores:
s2_pca = lapply(s2_autovalores, sqrt)
s2_pca

###

summary(test.pca)
names(test.pca)
test.pca$sdev
test.pca$sdev^2  # Autovalores de la s (proceso contrario al de antes)

###

# De esta forma calculamos la proporcion de la varianza del autovalor 1

auto <- eigen(s2)
lambda <- auto$values
lambda

sol = lambda[1] / sum(lambda)
sol

# Para la cumulativa sumamos varios componentes
sol2 = (lambda[1] + lambda[2]) / sum(lambda)
sol2

# ----------------------------# 

# 1er criterio: ver los componentes que más representan (aquellas que explican el 90-95%)
# 2do criterio: representarlos gráficamente
# 3er criterio: quedarme solo con las dos primeras componentes


screeplot(test.pca)  # Representación de los autovalores
screeplot(test.pca, type = "lines") # El mismo gráfico con líneas

# autovectores asociados (columnas de test.pcs$loadings)
test.pca$loadings

# La primera componentes es de tamaño y la segunda de forma (unos a un lado y otros a otro, por tener signos distintos)
# La variable con mayor peso es la que tiene el coeficiente más grande. 
# En este caso todas son importantes porque ninguna es cero.
# **Examen interpretar resultados**

# Representamos los coeficientes de las componentes principales
barplot(loadings(test.pca), beside = TRUE)
# El tamaño de la barra indica el peso de la variable en el componente

# Número de observaciones (con cuantos datos se han calculado nuestros componentes)
test.pca$n.obs  

# Vector de medias (centro de gravedad)
test.pca$center

# Escalados aplicados a cada variable
test.pca$scale

# Scores (resultado de XP siendo P la matriz que tiene como columnas los autovectoes de S)
test.pca$scores
# Cuanto contribuye cada variable a cada componente


########


# Análisis de componentes principales a través de la descomposición espectral de la matriz de covarianzas

n <- nrow(dat)  # Número de filas

# 1. Calculamos el vector de medias
apply(dat, 2, mean)

# 2. calculamos la matriz de covarianzas muestral
S <- cov(dat) * (n - 1)/n

# 3. Sus autovalores
auto <- eigen(S)
lambda <- auto$values
lambda

# 4, Sus autovectores
v <- auto$vectors
v

# 5. Calculamos la proporción de varianza explicada 
lambda/sum(lambda)

# 6. Y sus valores acumulados
cumsum(lambda/sum(lambda))


########


# El biplot


# El biplot es una representación gráfica simultánea de los individuos (mediante puntos) y las variables (mediante flechas).
# Construido en base a las dos primeras componentes principales. Permite interpretar el significado de las componentes 
# (la primera en el eje horizontal y la segunda en el eje vertical) en base a las direcciones de las flechas


biplot(test.pca)
plot(test.pca$scores[,1], test.pca$scores[,2])  # Representación manual
# -> Se valoran como parecidos los individuos cuyos puntos están próximos en el biplot
# -> Tendrán correlación positiva las variables con flechas semejantes
# -> Los individuos que se encuentran en la dirección de cierta flecha tendrán observaciones altas en la variable representada por la flecha.

# En este gráfico lo podemos interpretar como que cuanto más a la derecha mejor nota y más a la izquierda peor (debajo de la media)


########

pc2 = princomp(na.omit(comarg), cor = TRUE)  # usamos la matriz de correlaciones (cor), en vez de las covarianza si las esccalas de los datos son muy difentes




##########################################################
# Ej 4

# A)

datos = read.table("decatlon.txt", header=TRUE)
head(datos)
summary(datos)


pc2 = princomp(datos, cor = TRUE)
pc2
# Usamos las matriz de correlaciones porque tienen escalas muy distintas (media de 1 vs media de 400)



# B)

summary(pc2)
# Las dos primeras componentes explican el 60% (cum proportion)

summary(pc3)
# En este caso (el caso que está mal), vemos como la primera variable se lleva la mayoría del peso


# C)

biplot(pc2)
# Las líneas de jabalina, disco... están juntas porque normalmente a las personas que se les da bien los lanzamientos
# se les dan mejor los lanzamientos que los que corren. Al igual pasa con los que corren.
# Analizando los datos podemos ver que no hay gente muy mala, sino muchos sobre la media pero después hay
# unos outliers que lo han muy bien.


# USO NO CORRECTO (ver explicacion)
pc3 = princomp(datos)
biplot(pc3)
# En este caso al no usar la matriz de correlaciones, hay una variable con una escala muy grande
# llevándose la mayor parte del peso


#############################################

library(ggplot2)
library(factoextra)
screeplot(pc2)
fviz_screeplot(pc2, addLabels=TRUE, ylim=c(0,100))









