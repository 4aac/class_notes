# Para usar esto hay que ir a la barra de arriba, Session, SetWorkingDIrectory, choosedirectory y elegimos la carpeta de class notes

comarca = read.csv2("ComarGal2.csv", dec=".", sep=";", string=TRUE, enc="UTF-8")
summary(comarca)

comarca_num = comarca[, c(4,5,6,7,8,11,12,13)]  # Valores numéricos
summary(comarca_num)

xmed = apply(comarca_num, 2, mean, na.rm=TRUE)  # Media de valores
xmed

sigma = cov(comarca_num, use="pairwise")
sigma

matriz_covarianza = cov(comarca_num, use="pairwise")  # Pairwise se usa para calcular solo con los datos no faltantes
matriz_covarianza

matriz_correlacion = cor(comarca_num, use="pairwise") 
matriz_correlacion


summary(comarca)

plot(comarca_num$X.Univ, comarca_num$Abs, col="black", cex=comarca_num$PIBCap/4000)  # Con cex añadimos la tercera variable de radio
text(comarca_num$X.Univ, comarca_num$Abs, col="blue", comarca$Comarca)




install.packages("GGally")
install.packages("ggplot2")

library(GGally)
library(ggplot2)

ggpairs(comarca_num) + theme_bw()
ggpairs(comarca_num, aes(colour=comarca$Prov)) + theme_bw()

install.packages("ellipse")
library(ellipse)

# Matriz de correlaciones en gráfico de elipse
plotcorr(cor(comarca_num))
cor(comarca_num)

install.packages("ggExtra")
library(ggExtra)
p = ggplot(comarca_num,  aes(x=RendMedio, PIBCap, col=comarca$Prov))+geom_point(); p

# histograma de las marginales
p1 = ggMarginal(p, type="histogram");p1

# densidad NP de las marginales
p2 = ggMarginal(p, type="density");p2

# boxplot de las marginales
p3 = ggMarginal(p, type="boxplot");p3



# Pintar una continua y una categorica
boxplot(comarca$RendMedio~comarca$Prov)  # La ~ se hace para representar una continua y una categorica

ggplot(comarca, aes(x=Prov, y=RendMedio, fill=Prov)) + geom_boxplot()  # Igual que el de antes pero coloreado

plot(comarca$RendMedio, comarca$Tnat, col=comarca$Prov, pch=16)
ggplot(comarca, aes(x=RendMedio, y=Tnat, color=Prov)) + geom_point(size=4)

plot(comarca$Pob2018, comarca$Dens2017, col=comarca$Prov, pch=16)

ggplot(comarca, aes(x=Pob2018, y=Dens2017, size=Pob2018, color=Prov)) + geom_point()


# Diagrama de coordenadas paralelas
ggparcoord(na.omit(comarca), columns=4:7, groupColumn=2, order="anyClass", showPoints = TRUE, title="diagrama de coordenadas para comarcas", alphaLines = 0.4) + theme_bw() + theme(legend.position = "top")








