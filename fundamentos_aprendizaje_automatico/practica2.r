# par(bg="yellow") 
library(datasets)
attach(cars)

unique(speed)
unique(dist)
range(speed)
range(dist)

plot(speed, dist, 
xlab="velocidad", ylab="distancia", 
xlim=c(0,30), ylim=c(0,120), 
pch=22, col="red", bg="grey", bty="l", tcl=0.4, 
main="Gráfico personalizado", cex=1.5)
text(7, 100, expression(p==over(1, 1+e^-(beta*x+alpha))))
mtext("ejemplo", side=1, line=1, ar=1, cex=0.9, font=5)

x = seq(-3, 8, 0.25)
y1 = sin(x); y2 = cos(x)
plot(x, y1, type="l", col="red", lwd=2, main="ejemplo", ylim=c(-1,1.3), xlab="x", ylab="f(x)")

lines(x, y2, lty=2, lwd=1, col="blue")
legend(-3.2, 1.3, x("sin(x)", "cos(x)"), box.lty=c(1,2), lwd=c(2,1), col=x("red", "blue"))
abline(h=0, lwd=2, col="brown")


# --  

data(airquality)
attach(airquality)
par(airquality)
par(mfcol=c(1,2))
plot(Wind, Ozone)
plot(Wind, Ozone, type="p", main="Ejemplo", xlab="Viento", ylab="Ozono", col="red")
abline(a=97, b=-6)
abline(h=50, col="blue")
abline(a=5, col="grey", lty=5)

plot(Temp[1:10], Wind[1:10], pch=2, xlab="Temperatura", ylab="Viento")
arrows(Temp[1:9], Wind[1:9], Temp[2:10], Wind[2:10])
text(Temp[1:10], Wind[1:10])
paste(Month[1:10], "/", Day[1:10])


# --

x = seq(-10, 10, length=30)
y =x
f = function(x,y) {
    r = sqrt(x^2+y^2); 10*sin(r)/r
}
z = outer(x, y, f)
z[is.na(z)] = 1
op = par(bg = "white")
persp(x, y, z, theta=30, phi=30, expand=0.5, col="blue")

persp(x, y, z, theta=30, phi=30, expand=0.5, col="grey", ltheta=120, shade=0.75, ticktype="detailed", xlab="X", ylab="Y", zlab="Sinc(r)") = res
round(res, 3)


summary(volcano)
length(volcano)
dim(volcano)

z = 2 * volcano
x = 10 * (1:nrow(z))
y = 10 * (1:ncol(z))
par(bg = "slategray")
persp(x, y, z, theta=10, phi=50, col="green3", scale=FALSE, ltheta=-220, shade=0.75, border=NA, box=FALSE)

# rgraphgallery.com


# --

# if (condicion) expresion1 elseif (consdicion2) expresion2 else expresion3
x=-2; if (x>=0) {y="positivo; y"} else {y="negativo";y}


# bucles for
x = seq(-2, 2, 0.5)
n = length(x)
y = numeric(n)
 
for (i in 1:n) {y[i] = x[i]}


# while

x = x(1,2,3,4)
y = c(0,0,5,1)
n = length(x)
i = 0
z = numeric(n)
while (i<=n) {z[i] = x[i]+y[i], i=i+1}


# fucniones
fun = function(x) {aux}

# los ... indican que puede admitir parámetros de funciones
fun = function (a, b=3, ...) {
    z = a^b
    plot(z, ...)
}

fun(3,3)

fun(b=2, a=5, col=2)

fun(seq(0,1,length=100))

fun = function() print(x)
x = 1
fun()

# -- 

resultados = seq(1, 6)
lanzamientos = sample(resultados, 30, rep=T)  # Sample nos da valores aleatorios, rep = replace = T = True
frecuencias = table(lanzamientos)/30
barplot(frecuencias)


dado = function(n=30) {
    lanzamientos = sample(resultados, n, rep=T) 
    frecuencias = table(lanzamientos)/n
    barplot(frecuencias, main=paste("número de lanzamientos=", ne))
}

# Poner semilla para que todo al mundo le salga igual
dado(30000)


# --

# EJ 3

obtener_divisores = function(numero) {
    divisores = c()
    if (numero != as.integer(numero) | numero <= 0) {
        print("Error")
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

# EJ13

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
