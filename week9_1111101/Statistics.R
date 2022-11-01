library (psych)
library(ggplot2)
library(dplyr)
library(gridExtra)
library(car)




### Descriptive
## all-in-one


# students data set url 
students<-read.table('https://www.dipintothereef.com/uploads/3/7/3/5/37359245/students.txt',header=T, sep="\t", dec='.') 

students

summary(students)

psych::describe(students)

psych::describeBy (students,students$gender)

psych::describeBy (students, list(students$gender,students$population))



### Counts & proportions


### mean, median, sd, etc.



### Practice 7.1 
# Using the data ‘iris’ explore how the four traits vary among flower species.
# (1) Use boxplot as visual summaries then extract descriptive statistics by species (describeBy or others)
# (2) Count number of observations in each trait and species (be creative). it should results in a table of 3 species x 4 traits filled with “50” values.
# (3) Calculate the median of each variable by Species, then calculate the mean by Species but for the Sepal.Length only

iris

plot1 <-ggplot(iris, aes(x=Species, y=Sepal.Length)) + 
  geom_boxplot()

plot2 <-ggplot(iris, aes(x=Species, y=Sepal.Width)) + 
  geom_boxplot() 

plot3 <-ggplot(iris, aes(x=Species, y=Petal.Length)) + 
  geom_boxplot() 

plot4 <-ggplot(iris, aes(x=Species, y=Petal.Width)) + 
  geom_boxplot() 

grid.arrange(plot1, plot2,plot3, plot4, ncol=2)  # put 4 plot in one figure
describeBy (iris, iris$Species)  # ( data , which want to print )

iris %>% group_by(Species) %>% summarise(across(c(1:4), length))

aggregate(iris[,1:4],by=list(iris$Species), median)

tapply(iris$Sepal.Length , iris$Species, mean)



### Hypothesis

### Correlations

# dataset hypotheses?
x<-students$height
y<-students$shoesize
s<-students[,1:2] # a matrix
# Pearson correlation
# cor(x,y)
# cor(s)
cor(x,y)
cor.test(x,y)


ggplot(students, aes(x = height, y = shoesize)) + 
  geom_point() +
  stat_smooth(method = "lm", col = "red")


# Spearman correlation (monotonic)
# cor(x,y, method ='spearman')
cor.test(x,y, method ='spearman')


w<-(1:100)
z<-exp(x)
cor.test(w,z,method='pearson') # super low
cor.test(w,z,method='spearman') #super high



### Chi-square test

#Cast 240 times a die. We counted occurrence of 1,2,3,4,5,6
die<-data.frame(obs=c(55,44,35,45,31,30), row.names=c('Cast1','Cast2','Cast3','Cast4','Cast5','Cast6'))
die #Is this die fair? Define H0 and H1.  

chisq.test(die)


obs <- c(750, 50, 200)
exp <- c(0.60, 0.35, 0.05)
chisq.test (x=obs, p=exp)


F <- matrix(nrow=4,ncol=2,data=c(33,14, 8,18,31,25,14,12))
F
chisq.test(F) # alternative see `fisher.test`



### Student t-test

# One sample
t.test (students$height, mu=170)

# Two sample (with equal variances)
t.test (students$height~students$gender, var.equal = TRUE)

# Two sample (with unequal variances, default option when using t.test) 
t.test (students$height~students$gender)

# Two sample paired t.test
t.test (students$height~students$gender, paired=T)

#### DO Practice 2,3, fix how those condition mean!



### Mann-Whitney
# Normality plot & test
students$height[6]<-132
students$height[10]<-310
students$height[8]<-132
students$height[9]<-210
boxplot(height~gender, students)


qqnorm(students$height) 
qqline(students$height) 


shapiro.test(students$height) # data are not normal 
# h0 -> normal  /  h1 -> unormal


wilcox.test (students$height~students$gender) 



### Variances

# Test of variance: we test HO: homogeneous, H1:heterogeneous
fligner.test (students$height ~ students$gender)


tg<-ToothGrowth
tg$dose<-factor(tg$dose)
boxplot(len~dose*supp, data=tg)


# also work with: boxplot(len ~ interaction (dose,supp), data=tg)
# or: plot(len ~ interaction (dose,supp), data=tg)
bartlett.test(len~interaction (supp,dose),data=ToothGrowth) # sensitivity non-normality +++


leveneTest(len~interaction (supp,dose),data=ToothGrowth) # sensitivity non-normality ++


fligner.test(len~interaction (supp,dose),data=ToothGrowth) # sensitivity non-normality +





##### HW

# 1. create own T test --> couculate t / at least two sample
# 2. use pt  --> compare T with this pt --> 看分布
# 3. getAnywhere("t.test.default") --> can see what is the function detail inside " OOO "


