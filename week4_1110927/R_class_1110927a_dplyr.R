rm(list=ls()) #clean memory
install.packages("dplyr")
library (dplyr)

summary(iris)
summarised <- summarise(iris, Mean.Width = mean(Sepal.Width))
head(summarised)
summarised <- summarise(iris, Mean.var1 = mean(Sepal.Width)) #change name
summarised
# summarised <- summarise(iris, Mean.var1 = mean(Sepal.Width))
# head()

select(iris,1)
# by column names
selected1 <- dplyr::select(iris, Sepal.Length, Sepal.Width, Petal.Length)
head(selected1) 
head(iris)

# by column range
selected2 <- dplyr::select(iris, Sepal.Length:Petal.Length)
head(selected2, 4)

# by column range number
selected3 <- dplyr::select(iris,c(2:5))
head(selected3)
selected4 <- dplyr::select(iris,c(1,3,5))
head(selected4)

#Use - to hide a particular column
selected5 <- dplyr::select(iris,-Species,-Sepal.Length)
head(selected5)

setosa<-iris$Species=="setosa"
setosa
setosa<-iris[setosa,]
setosa

# Select setosa species 
filtered1<- filter(iris,Species=="setosa")
filtered1

# Select versicolor species with Sepal width more than 3
filtered2 <- filter(iris, Species == "versicolor", Sepal.Width > 3)
tail(filtered2)
# choice more condition ??????????????  缺!!
filtered2 <- filter(iris, Species == "versicolor", Sepal.Length>4,Sepal.Width~2)
tail(filtered2)

head(filtered2)
tail(filtered2,2)
# ????????????   缺!!
filtered2[c(36:37),c(1,3)]

#To create a column “Greater.Half” which stores a logical vector
mutated1 <- mutate(iris, Greater.Half = Sepal.Width > 0.5 * Sepal.Length)
tail(mutated1)
head()  #?????????????  缺!!

# ????????????????????????  缺!!
table(mutated1$Greater.Half)
iris$mutated1
table(iris$mutated1.Greater.Half)



### Arrange
# Sepal Width by ascending order
arranged1 <- arrange(iris, Sepal.Width)
head(arranged1)  #從小排到大
tail(arranged1)  #從大排到小

# Sepal Width by descending order
arranged2 <- arrange(iris, desc(Sepal.Width))
tail(arranged2)



### Group_by
# Mean sepal width by Species
gp <- group_by(iris, Species)
gp
gp.mean <- summarise(gp,Mean.Sepal = mean(Sepal.Width))
gp.mean



### Pipe operator
#To select the rows with conditions
iris%>% filter(Species == "setosa",Sepal.Width > 3.8)

iris%>%arrange(iris$Sepal.Width)%>%filter(Species=="setosa",Sepal.Width>3)
head(iris%>%arrange(iris$Sepal.Width)%>%filter(Species=="setosa",Sepal.Width>3))
tail(iris%>%arrange(iris$Sepal.Width)%>%filter(Species=="setosa",Sepal.Width>3),2)
#To find mean SepalLength by Species, we use the pipe operator as following:
iris%>% group_by(Species) %>% summarise(Mean.Length = mean(Sepal.Length))




