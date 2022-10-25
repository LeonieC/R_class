library(animation)
library(ggplot2)
library (gganimate)

##### LOOPS

### Basics

for(i in 1:100) {
  print("Hello world!")
  print(i*i)  # i x i --> 1x1=1 ； 2x2=4 ； 3x3=9......
}



foo <- seq (1,100,by=2) # sequence  1, 3, ..., 99  # 1~100數字,隔2 = 1,3,5,7,9,......99
n<-length(foo) #  size of the foo sequence
foo.squared = NULL #  empty object

foo.squared[1] = foo[1]^2
foo.squared
foo.squared[5] = foo[5]^2
foo.squared

foo.squared = NULL



for (i in 1:n) { # our counter
  foo.squared[i] = foo[i]^2 # the task
}


foo.df<-data.frame(foo,foo.squared) 
foo.df
plot (foo.df$foo~foo.df$foo.squared)


# all上面 = 這兩行!!!
foo.squared2<-foo^2
foo.squared2
plot (foo~foo.squared2)


# 系統需要跑多久time 0 0 0 --> 快!
system.time(foo.squared2<-foo^2)



### Recycling

num_gen <- 10 #   no. generation
N <- rep (0,num_gen) #  "vector" of 10 zeros (could be `NULL`)
N[1] <- 2 # We need a beginning for our population
for (i in 2:num_gen){ # counter
  N[i]=2*N[i-1] # task: double individuals
}
plot (N)

num_gen<-10 
generation<-1:num_gen 
N <- rep (0,num_gen)
N[1] <- 2
for (i in 2:num_gen) { 
  N[i]=2*N[i-1]
}
plot(N~generation, type='b')



### Function --> provid a function

grow <- function (growth.rate) { # argument "growth.rate" of function "grow" 
  num_gen<-10
  generation<-1:num_gen
  N <- rep (0,num_gen)
  N[1] <- 1
  for (i in 2:num_gen) {
    N[i]=growth.rate*N[i-1] # not the use growth.rate argument  # 這一行是loop,其他行是function
  }
  plot(N~generation,type='b', main=paste("Rate =", growth.rate)) 
}

grow(1.8)
grow(20)
# --> 1.8、20 is growth rate



par(mfrow=c(2,3)) # 2x3 plot
for (i in 2:7){ # i = 2~7
  grow(i)
}



## Practice 6.1
#Create a function called grow2 where both arguments: the growth.rate and number.generation can be customized.

grow2 <- function (growth.rate, number.generation) { 
  num_gen<-number.generation
  generation<-1:num_gen
  N <- rep (0,num_gen)
  N[1] <- 1
  for (i in 2:num_gen) {
    N[i]=growth.rate*N[i-1] 
  }
  plot(N~generation,type='b', main=paste("Rate =", growth.rate, ", ", number.generation, "generations"))
}

grow2(2.2, 20)
grow2(1.2, 100)



### Animation
## gif

# to fix axis numerical value, add limite to x and y axis
# to create many plot to save a gif. It's a loop!
grow3 <- function (growth.rate) { 
  num_gen<-10
  generation<-1:num_gen
  N <- rep (0,num_gen)
  N[1] <- 1
  for (i in 2:num_gen) {
    N[i]=growth.rate*N[i-1]
  }
  plot(N~generation, xlim=c(0,10), ylim=c(0,100000), type='b', main=paste("Rate =", growth.rate))
}


# combine plot together~ can vary the speed?
saveGIF({
  for (i in 2:10){
    grow3(i)
  }})



### gganimate
# not really useful on science, just for cute XDD
demo<-NULL
demo$count<-N
demo$generation<-generation
demo<-as.data.frame(demo)

p <- ggplot(demo, aes(x = generation, y=count, size =2)) +
  geom_point(show.legend = FALSE, alpha = 0.7) +
  scale_color_viridis_d() +
  scale_size(range = c(0, 12)) +
  labs(x = "Generation", y = "Individuals")

p + transition_time(generation) +
  labs(title = "Generation: {frame_time}") +
  shadow_wake(wake_length = 0.2, alpha = FALSE)



### Progressing
## Practice 6.2

# Write the code to illustrate a different kind of growth, the logistic growth.
# Logistic growth follows: Nt+1=Nt+[growth.rate∗Nt∗(100−Nt/100)]
# The 100 value is called the “carrying capacities” or K, it means the population will be limited at 100 individuals.
# In your model you will start with a population of 10 individuals.
# You will then make the number of generation flexible using a function simulating population growth over 50 generations.
# You will further make this function flexible by changing growth.rate.
# Save the outcome as a .gif if you can make it.


#Explanation, but no solution. Call me when you are here.
# if r < 1 then the increase in population size between t and t+1 will be less than the difference between N and K and the population will adjust monotonically.
# if 1 < r < 2 then the population will have a dampened oscillation.
# When r > 2 but < 2.5 the population may display a stable (regular with same amplitude) limit cycle.
# When r > 2 especially if r > 2.52 oscillation will actually increase and the population growth will become chaotic
# When r >> 2 the population will likely crash, generally in a short time

dev.off()

grow4 <- function (growth.rate) { 
  num_gen<-50
  generation<-1:num_gen
  N <- rep (0,num_gen)
  N[1] <- 10 # 族群數量從10開始
  for (i in 2:num_gen) {
    N[i]=N[i-1]+(growth.rate*N[i-1]*((100-N[i-1])/100)) #更改的公式
  }
  plot(N~generation, xlim=c(0,50), ylim=c(0,150), type='b', main=paste("Rate =", growth.rate))
}



grow4(0.3)
grow4(1.3)
grow4(1.5)
grow4(1.9)
grow4(2.3)
grow4(2.4)
grow4(2.5)
grow4(2.6)
grow4(2.7)
grow4(2.8)
grow4(3.5)


# combine plot together
saveGIF({
  for (i in seq(1,4, by=0.2)){ # growth.rate 1~4 , 間隔0.2 --> 1.0, 1.2, ..., 3.8, 4.0
    grow4(i)
  }}, interval=0.2) # interval --> change GIF's speed ; lower faster



