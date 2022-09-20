#Manipulation(in class version)
rm(list=ls())

libarary(datasets)
data(iris)
head(iris)

str(iris)

summary(iris)

fix(iris)
str(iris)

#selection

students<-read.table('https://www.dipintothereef.com/uploads/3/7/3/5/37359245/students.txt',header=T, sep="\t", dec='.') # read data set from url
str(students) 
head(students)

students$height

#R syntaxt:dataset[no row, no column]
students[,1]  #[列,行]---直行橫列
students[1,1]
students[10,]

students$height[5]
students[c(1,10),]

students

#sunset

students$gender=="female"
f<-students$gender=="female"
females<-students[f,]
females
rownames(females)<-c("Vanessa","Vicky","Michelle","Joyce","Victoria")
females
rownames(females)<-females$height
females





#Practice 2.1
#no need this --> iris$Species=="setosa" --> just for check
s<-iris$Species=="setosa"
setosa<-iris[s,]
setosa
str(setosa)

ve<-iris$Species=="versicolor"
versicolor<-iris[ve,]
versicolor
str(versicolor)

vi<-iris$Species=="virginica"
virginica<-iris[vi,]
virginica
str(virginica)
head(virginica)





#choose the one to presentation
#sample
1:nrow(females)
sample(1:nrow(females),3)
females
sample(1:nrow(females),3,replace=TRUE)
sample(1:nrow(females),4,replace=TRUE)
sf<-sample(1:nrow(females),2)
sf
females[sf,]





#sorting

indl<-order(students$height)
indl
students[order(students$height),]
students[-order(students$height),]
students[order(-students$height),]





#recoding

colors<-ifelse(students$gender=="male","blue","red")
colors
students$color<-ifelse(students$gender=="male","blue","red")
students
students$gender<-ifelse(students$gender=="male","green","yellow")
students
tall<-students$height>=160
tall
tall<-students[tall,]
tall
str(tall)
not38<-students>=160
not38<-students$shoesize!=38
not38
shoessize<-students[not38,]
shoessize





#Practice 2.2

#Iris setosa is purple.Iris versicolor is blue. Iris virginica is pink.
#iris$flowercolors -->新增flowercolors的title
iris$flowercolors<-ifelse(iris$Species=="setosa","purple",ifelse(iris$Species=="versicolor","blue","pink"))
iris
iris[c(1,51,102),] #check 3 species color  #() call a function.、[] call a data.
#Sort individuals by decreasing Sepal.Width.
iris[order(-iris$Sepal.Width),]
sepalwidth<-iris[order(-iris$Sepal.Width),]
sepalwidth
sepalwidth[150,]
#What can you hypothesize on the size of sepal for these three species. 
#--> see sepalwidth and maybe you can say setosa is bigger

#Get back the data set for the species having the smallest sepal width.
#Delete the variable color in this subset
head(iris)
smallest.sepal.width<-iris$Species=="versicolor" #可省略
smallest.sepal.width  #可省略
smallest.sepal.width<-iris[iris$Species=="versicolor",]
smallest.sepal.width

smallest.sepal.width$flowercolors<-NULL
smallest.sepal.width
