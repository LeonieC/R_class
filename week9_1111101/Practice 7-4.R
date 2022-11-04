### Practice 7.4 
# Create your own my.t.test function (e.g. you will not use the above t.test function but you will code your own function).
# You will probably need to check at ?pt in order to extract the p-value.
# You can look at getAnywhere("t.test.default") for the actual source code of the t.test function.
# Please use your customized function to test the effect of treatment on length at various days in the rairuoho dataset.Interpret.



library (psych)
library(ggplot2)
library(dplyr)
library(gridExtra)
library(car)
library (tidyr)
library(plyr)


# Group the data
rairuoho<-read.table('https://www.dipintothereef.com/uploads/3/7/3/5/37359245/rairuoho.txt', header=T, sep='\t', dec='.') 
rairuoho


rairuoho_long <- rairuoho %>% pivot_longer(day3:day8, names_to = "day", values_to = "length")
rairuoho_long <- rairuoho_long[,-c(1,2,4,5,6,7)]
rairuoho_long

rai.day3 <- rairuoho_long[rairuoho_long$day == 'day3', ] 
rai.day3

rai.day4 <- rairuoho_long[rairuoho_long$day == 'day4', ] 
rai.day4

rai.day5 <- rairuoho_long[rairuoho_long$day == 'day5', ] 
rai.day5

rai.day6 <- rairuoho_long[rairuoho_long$day == 'day6', ] 
rai.day6

rai.day7 <- rairuoho_long[rairuoho_long$day == 'day7', ] 
rai.day7

rai.day8 <- rairuoho_long[rairuoho_long$day == 'day8', ] 
rai.day8



# Test the data I set
t.test(rai.day3[rai.day3$treatment=="water",]$length, rai.day3[rai.day3$treatment=="nutrient",]$length)
t.test(rai.day4[rai.day4$treatment=="water",]$length, rai.day4[rai.day4$treatment=="nutrient",]$length)



# Create your own my.t.test function
my.t.test <- function(x, y) {
  m.x <- mean(x)
  m.y <- mean(y)
  sd.x <- sd(x)
  sd.y <- sd(y)
  n.x <- length(x)
  n.y <- length(y)
  t_value = (m.x-m.y)/sqrt((sd.x^2)/n.x+(sd.y^2)/n.y)
  df= (length(x)-1)+(length(y)-1)
  p= pt(t_value, df, lower.tail = F)  ## pt(q, df, ncp, lower.tail = TRUE, log.p = FALSE)
  paste('t=', t_value, ', degree_of_freedom=', df, ' , p = ', p)

}

# Try my.t.test
my.t.test(rai.day3[rai.day3$treatment=="water",]$length, rai.day3[rai.day3$treatment=="nutrient",]$length)
my.t.test(rai.day4[rai.day4$treatment=="water",]$length, rai.day4[rai.day4$treatment=="nutrient",]$length)
my.t.test(rai.day5[rai.day5$treatment=="water",]$length, rai.day5[rai.day5$treatment=="nutrient",]$length)
my.t.test(rai.day6[rai.day6$treatment=="water",]$length, rai.day6[rai.day6$treatment=="nutrient",]$length)
my.t.test(rai.day7[rai.day7$treatment=="water",]$length, rai.day7[rai.day7$treatment=="nutrient",]$length)
my.t.test(rai.day8[rai.day8$treatment=="water",]$length, rai.day8[rai.day8$treatment=="nutrient",]$length)


# some 
# rai.day3[rai.day3$treatment=="water",]$length
# filter(rai.day3, rai.day3$treatment=="water")
# test <- filter(rai.day3, treatment%in%"water")
# test$length



