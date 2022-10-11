library(tidyverse)

head(iris)



##### Point and line plots
### Basics

plot(iris$Petal.Length)
plot(iris$Petal.Width)
plot(Petal.Length ~ Petal.Width, data = iris)

plot(iris$Petal.Length ~ iris$Petal.Width)
plot(Petal.Length ~ Petal.Width, data = iris,
     xlab = 'Petal width (cm)', 
     ylab = 'Petal length (cm)',
     main = 'Petal width & length of iris flower') 

plot(Petal.Length ~ Petal.Width, data = iris,
     xlab = 'Petal width (cm)', 
     ylab = 'Petal length (cm)', 
     main = 'Petal width and length of iris flower',
     pch = 19, cex=2, 
     col = rgb (1,0,0,0.10))

# create a vector of character with color names
col.iris<-ifelse(iris$Species=='setosa','purple',ifelse(iris$Species=='versicolor','blue','pink')) 
col.iris
head(iris)


plot(Petal.Length ~ Petal.Width, data = iris,
     xlab = 'Petal width (cm)', 
     ylab = 'Petal length (cm)', 
     main = 'Petal width and length of iris flower',
     pch = 19, cex=2, 
     col = col.iris)


plot(Petal.Length ~ Petal.Width, data = iris,
     xlab = 'Petal width (cm)', 
     ylab = 'Petal length (cm)', 
     main = 'Petal width and length of iris flower',
     pch = 19, cex=2, 
     col = scales::alpha(col.iris, 0.2))


# 三種設定顏色的方法
col = rgb (0,0,1,0.10))
col = "#9D3BBS" # hexadecimal code
col = "green"



## level 設置 need use as.factor
levels(col.iris)
col.iris


col.iris<-ifelse(iris$Species=='setosa','purple',ifelse(iris$Species=='versicolor','blue','pink')) 
col.iris

as.factor(col.iris)

col.iris.hexa <- scales::alpha(col.iris, 0.2)
col.iris.hexa <- as.factor(col.iris.hexa)
col.iris.hexa
levels(col.iris.hexa)
###



#可以specify(指定)名稱after create a plot
# --> 用legend

plot(Petal.Length ~ Petal.Width, dat = iris,
     xlab = 'Petal width (cm)', 
     ylab = 'Petal length (cm)', 
     main = 'Petal width and length of iris flower',
     pch = 19, cex=2, 
     col = scales::alpha(col.iris, 0.2))

legend(x="bottomright", pch= 19, cex=1.0, legend= c("versicolor","setosa", "virginica"), col=levels(as.factor(scales::alpha(col.iris, 0.2))))




ratio<-iris$Petal.Length/iris$Sepal.Width  # ratio between the length of petal and the width of Sepal
plot(Petal.Length ~ Petal.Width, dat = iris,
     xlab = 'Petal width (cm)', 
     ylab = 'Petal length (cm)', 
     main = 'Petal width and length of iris flower',
     cex.axis=1.0, cex.lab=1.5, cex.main=1.5,
     pch = 19, las=1, cex= ratio * 2, 
     col = scales::alpha(col.iris, 0.2))

legend(x="bottomright", pch= 19, cex=1.0, legend= c("versicolor","setosa", "virginica"), col=levels(as.factor(scales::alpha(col.iris, 0.2))))



### Types

## PANEL PLOT
pairs(iris[1:4], pch=19, col = scales::alpha(col.iris, 0.2))
pairs(iris[1:4], pch=19, col = col.iris)


## LINE PLOT
# generate a data frame with chronological variable
blossom<-NULL  # 創建新的空資料夾,再開始fill in ~
blossom$year <- 2010:2019
blossom$count.alaska <- c(3, 1, 5, 2, 3, 8, 4, 7, 6, 9)
blossom$count.canada <- c(4, 6, 5, 7, 10, 8, 10, 11, 15, 17)
as.data.frame(blossom)


# default(默認) us point we want to turn to line
plot(count.alaska ~ year,dat = blossom, type='l',
     ylab = "No. of flower blossoming") 


plot(count.alaska ~ year,dat = blossom, type='b', pch=20,
     ylab = "No. of flower blossoming") 


plot(count.alaska ~ year,dat = blossom, type='b', pch=20,
     lty=2, lwd=0.5, col='red',          # lty --> line type
     ylab = "No. of flower blossoming") 


plot(count.alaska ~ year,dat = blossom, type='b', pch=20,
     lty=2, lwd=0.5, col='red',
     ylab = "No. of flower blossoming") 
lines(count.canada ~ year,dat = blossom, type='b', pch=20,
      lty=3, lwd=0.5, col='blue')
# lines --> add something on that already present

# xlim and ylim --> how to find? --> arrange!
y.rng<-range(c(blossom$count.alaska, blossom$count.canada))
y.rng

plot(count.alaska ~ year,dat = blossom, type='l', ylim = y.rng,
     lty=2, lwd=1, col='red',
     ylab = "No. of flower blossoming") 
lines(count.canada ~ year,dat = blossom,
      lty=1, lwd=1, col='blue')


plot(count.alaska ~ year,dat = blossom, type='l', ylim =c(1,20),
     lty=2, lwd=1, col='red',
     ylab = "No. of flower blossoming")
lines(count.canada ~ year,dat = blossom,
      lty=1, lwd=1, col='blue')




iris.ver<- subset(iris, Species == "versicolor")
iris.vir<- subset(iris, Species == "virginica")

y.rng <- range( c(iris.ver$Petal.Length, iris.vir$Petal.Length) , na.rm = TRUE) 
x.rng <- range( c(iris.ver$Petal.Width, iris.vir$Petal.Width) , na.rm = TRUE) 

# Plot an empty plot

plot(Petal.Length ~ Petal.Width, dat = iris.ver,
     xlab = 'Petal width (cm)', 
     ylab = 'Petal length (cm)', 
     main = 'Petal width and length of iris flower',
     cex.axis=1.0, cex.lab=1.5, cex.main=1.5, type='n',
     xlim=x.rng,  ylim=y.rng)
# build an empty plot!

# Add points for versicolor
points(Petal.Length ~ Petal.Width, dat = iris.ver, pch = 20,cex=2, 
       col = rgb(0,0,1,0.10))

# Add points for versicolor
points(Petal.Length ~ Petal.Width, dat = iris.vir, pch = 20,cex=2, 
       col =  scales::alpha('#fc03c6', 0.2))

# Add legend
legend("topleft", c("versicolor", "virginica"), pch = 19, cex=1.2,
       col = c(rgb(0,0,1,0.10), scales::alpha('#fc03c6', 0.2)))



## BOX PLOT

boxplot(iris$Sepal.Width, na.rm = TRUE)

boxplot(iris$Sepal.Width,iris$Sepal.Length, iris$Petal.Width,iris$Petal.Length, names = c("Sepal.Width", "Sepal.Length", "Petal.Length","Petal.Width"), main = "Iris flower traits")

boxplot(iris$Sepal.Width,iris$Sepal.Length, iris$Petal.Width,iris$Petal.Length, names = c("Sepal.Width", "Sepal.Length", "Petal.Length","Petal.Width"), main = "Iris flower traits",outline = FALSE, horizontal = TRUE )

boxplot(Sepal.Width ~ Species,iris) 


iris$Species.ord <- reorder(iris$Species,iris$Sepal.Width, median)
levels(iris$Species.ord)

boxplot(Sepal.Width ~ Species.ord, iris)




## HISTOGRAM PLOT

hist(iris$Sepal.Width, xlab = "Width of Sepal", main = NA)

hist(iris$Sepal.Width, xlab = "Width of Sepal", main = NA, breaks=10)

n <- 10  # Define the number of bin
minx <- min(iris$Sepal.Width, na.rm = TRUE)
maxx <- max(iris$Sepal.Width, na.rm = TRUE)
bins <- seq(minx, maxx, length.out = n +1)
hist(iris$Sepal.Width, xlab = "Width of Sepal", main = NA, breaks = bins)



## DENSITY PLOT

dens <- density(iris$Sepal.Width)
plot(dens, main = "Density distribution of the width of sepal")

dens <- density(iris$Sepal.Width, bw=0.05)
plot(dens, main = "Density distribution of the width of sepal")



## QQ PLOT

qqnorm(iris$Sepal.Width)
qqline(iris$Sepal.Width)





## Settings
# `las` within the `plot` function
plot(Petal.Length ~ Petal.Width, dat = iris,las=1)

# `las` set as a graphical setting
par(las=1) 
plot(Petal.Length ~ Petal.Width, dat = iris)



######## 補see Settings~Practice 4.2 




### lattice
library(lattice)

densityplot(~ Petal.Length | Species, iris, plot.points = "", layout=c(1,3))

histogram(~ Petal.Length | Species, iris, plot.points = "", nint = 20, layout=c(1,3))

qqmath(~ Petal.Length | Species, iris, plot.points = "", nint = 20, layout=c(3,1))
qqmath(~ Petal.Length | Species, iris, plot.points = "", nint = 20, layout=c(3,1))

iris$variety<-rep(c(rep('main',25), rep('hybrid',25)),3) # fake variable
bwplot(Petal.Length ~  variety|Species, iris)



### Multivariate data set (just for introduction --> complicated)

### ggplot2
#(HW--看全部使用&了解)



