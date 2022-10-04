library(dplyr)
library(tidyr)


### Numeric

x <- c(1.0, -3.4, 2, 140.1) # numeric and double
typeof(x)  # 有小數點-->double
mode(x)  # 是數字-->numeric

x <- 4  # 軟體會自己有估計值,不當成整數
typeof(x)

x <- 4L  #所以我們想要有單純數值need加L
typeof(x)



### Character

x <- c("bubul", "magpie", "spoonbill", "barbet")
typeof(x)

x <- 3
y <- 5.3
x + y

x <- "3"
y <- "5.3"
# not run:  x+ y




### Logical

x <- c(TRUE, FALSE, FALSE, TRUE)

x1<-c(1,0,0,1)
x2 <- as.logical(c(1,0,0,1))
# OR: x3 <- as.logical(c(1,0,0,1))



### Factor

a <- c("M", "F", "F", "U", "F", "M", "M", "M", "F", "U")
typeof(a) # mode character

class(a)# class character

as.factor(a)  # [1] M F F U F M M M F U   Levels: F M U  變成F->1,M->2,U->3
a.fact <- as.factor(a)
a
a.fact

mode(a)
mode(a.fact)

class(a.fact)# class factor

a.fact
attributes(a.fact)
factor(a)
factor(a, levels=c("U","F","M"))  # 改變1,2,3代表順序

## Practice 3.1
data(iris)
iris
iris.sel<- subset(iris, Species == "setosa" | Species == "virginica")
levels(iris.sel$Species)  # 3 species are still there
# boxplot(Petal.Width ~ Species, iris.sel, horizontal = TRUE)
dim(iris)
dim(iris.sel)
str(iris)
str(iris.sel)

boxplot(Petal.width)            #######補



### Date


### NAs and NULLs

x <- c(23, NA, 1.2, 5)
mean(x)
mean(x, na.rm=T)



### Data structures




### (Atomic) vectors

x <- c(674 , 4186 , 5308 , 5083 , 6140 , 6381)
x
x[3]

x[c(1,3,4)]
x[2:4]
x[2] <- 0
x

x <- c("all", "b", "olive")
x
x <- c( 1.2, 5, "Rt", "2000")
x



### Matrices and arrays

m <- matrix(runif(9,0,10), nrow = 3, ncol = 3) # nrow=3,3橫、ncol=3,3直
m

m <- array(runif(27,0,10), c(3,3,3))
m



### Data frames  -->與Matrices不同！ 回看!!!

name   <- c("a1", "a2", "b3")
value1 <- c(23, 4, 12)
value2 <- c(1, 45, 5)
dat    <- data.frame(name, value1, value2) #combine those tree
dat

str(dat) #check!
attributes(dat) # provide attribute
names(dat) # extract colum names
rownames(dat) # extract row names



### Lists --> you can combine everythings together!

A <- data.frame(
  x = c(7.3, 29.4, 29.4, 2.9, 12.3, 7.5, 36.0, 4.8, 18.8, 4.2),
  y = c(5.2, 26.6, 31.2, 2.2, 13.8, 7.8, 35.2, 8.6, 20.3, 1.1) )

A # data frame
B <- c(TRUE, FALSE)
B # logical
C <- c("apples", "oranges", "round")
C # character
my.lst <- list(A = A, B = B, C = C)
str(my.lst)

names(my.lst)

my.lst$A
my.lst[[1]]

class(my.lst[[1]])
lst.notags <- list(A, B, D)
lst.notags

names(lst.notags)

M <- lm( y ~ x, A)
str(M)

names(M)
str(M$qr)
M$qr$rank



### Coercing data  --> change one type data to another type

y   <- c("23.8", "6", "100.01","6")
y.c <- as.numeric(y)
y.c
