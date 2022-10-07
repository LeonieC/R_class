### Practice 3.2

library("tidyverse")

# Create the following data frame from scratch.

before_diet <- c(104, 95, 87, 77, 112)
after_diet <- c(96, 91, 81, 75, 118)
bubble_tea_diet <- data.frame(before_diet, after_diet, row.names = c("subject_1", "subject_2", "subject_3", "subject_4", "subject_5"))
bubble_tea_diet


# Reformat this data frame to obtain the weight as a double into one column and the time of measurement as a factor with two levels before_diet and after_diet.

btd_long <- bubble_tea_diet %>% pivot_longer(before_diet:after_diet, names_to = "measurement_time", values_to = "weight")
btd_long

typeof(btd_long$weight)

btd_long <- as.data.frame(btd_long)
str(btd_long)
class(btd_long)


# You will store this data frame as the first element of a list called BUBBLE_DIET.

BUBBLE_DIET <- list(btd_long = btd_long)


# The second element of this list will be another list called WEIGHT_LOSS, storing three elements:
# [1] a vector of character extracting the row names of the table previously created
list_row <- row.names(bubble_tea_diet)
list_row

# [2] a numeric vector (double) indicating the weight loss (in %) of each subject (can be positive or negative)

weight_loss_percentage <- c(((after_diet-before_diet)/before_diet)*100)
weight_loss_percentage

# [3] a combination of these two elements in a table with two columns: subject and weight_loss.

WEIGHT_LOSS_table <- data.frame(subject=list_row, weight_loss=weight_loss_percentage)
WEIGHT_LOSS_table

WEIGHT_LOSS <- list(list_row = list_row, weight_loss_percentage = weight_loss_percentage, WEIGHT_LOSS_table = WEIGHT_LOSS_table)
WEIGHT_LOSS
str(WEIGHT_LOSS)
class(WEIGHT_LOSS)


# The third element of the list BUBBLE_DIET will be any message saying how much you enjoy manipulating data in R.

message_about_R <- c("I think R is helpful when you're doing some data analysis. But it's a little bit hard for me to manipulating data in R. I'm still trying to do my best and trying to enjoy it!")
BUBBLE_DIET <- list(btd_long = btd_long, WEIGHT_LOSS = WEIGHT_LOSS, message_about_R = message_about_R)
BUBBLE_DIET

str(BUBBLE_DIET)

