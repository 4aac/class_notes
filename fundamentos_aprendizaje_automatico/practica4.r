# PASO 1) Abrir librería
library(faraway)

# PASO 2) Seleccionar datos
data("phbirths")

# PASO 3) Analizar datos
summary(phbirths)
names(phbirths)
head(phbirths)
length(phbirths$black)
??faraway::phbirts  # Ver que significan los datos

# Vemos cual es el bebe más pequeño
which.min(phbirths$grams)

# El más grande
which.max(phbirths$grams)

#####################################


par(mfrow = c(2,2)) 

plot(density(phbirths$grams))
plot(x=phbirths$grams, y=phbirths$gest)
plot(density(phbirths$gest))


y = log(phbirths$grams)
x = phbirths$gestate
z = lm(y ~ x); z

summary(z)

# Calculamos los residuos
y.estimado = coef(z)[[1]] + coef(z)[[2]] * x
y.estimado

error = y - y.estimado; error
summary(error)

# t de student
# f de snedecor

xbarra = mean(x)
ybarra = mean(y)
par(mfrow = c(1,1)) 
plot(x, y,  col=as.factor(phbirths$black), pch=16)
abline(z)
abline(h = ybarra, col="blue")
abline(v = xbarra, col="blue")


xbarra = mean(x)
ybarra = mean(y)
par(mfrow = c(1,1)) 
plot(x, y,  col=as.factor(phbirths$smoke), pch=16)
abline(z)
abline(h = ybarra, col="blue")
abline(v = xbarra, col="blue")








