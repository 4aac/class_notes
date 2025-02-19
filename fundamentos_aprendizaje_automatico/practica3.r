# SI SE HACE EN RSTUDIO:
# Para usar esto hay que ir a la barra de arriba, Session, SetWorkingDIrectory, choosedirectory y elegimos la carpeta de class notes

# Trabajaremos a lo largo de este laboratorio con el siguiente ejemplo. Se ha examinado a 25 alumnos, aspirantes a ingresar en el Máster Interuniversitario en Inteligencia Artificial, de 5 materias diferentes: Programación (cuyo resultado se almacena en la variable prog), Ingeniería de Computadores (ingcom), Ingeniería del Software (ingsof), Sistemas de la Información (sist) y Estadística (estad). Las puntuaciones obtenidas se encuentran en el fichero aspirantes.txt y se muestran a continuación.

dat = read.table("aspirantes.txt", header=TRUE)
head(dat)

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
# 1. Calculamos la matriz de covarianza
s = cov(dat)
s

# 2. Calculamos los autovalores:
s_autovalores = eigen(s)[1]  # Si no usasemos el 1, dos daría autavalores y autovectores
s_autovalores

# 3. Hacemos la raiz cuadrada de los autovalores:
s_pca = lapply(s_autovalores1, sqrt)
s_pca

# 4. Comparamos con la medida real:
test.pca[1]


# También se puede calcular manualmente
n = dim(dat)[1]
dat_matrix = as.matrix(dat)
dat_matrix_media = matrix(rep(colMeans(dat_matrix), each = n), nrow = n, byrow = TRUE)

# 1. Calcular la matriz de covarianza manualmente
s2 = ( (t(dat_matrix  - dat_matrix_media)) %*% (dat_matrix - dat_matrix_media) ) / (n - 1)
s2

# 2. Calcular los autovalores manualmente
s2_autovalores = eigen(s2)$values
s2_autovalores

# 3. Raíz cuadrada de los autovalores manuales
s2_pca = sqrt(s2_autovalores)
s2_pca 

