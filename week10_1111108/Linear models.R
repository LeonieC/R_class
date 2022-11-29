##### Linear models


library(Hmisc)
library(corrplot)
library(MASS)
library(car)
library(interactions)
library(yarrr)
library(tidyr)
library(readr)
library(lme4)
library (lmerTest)
library(nlme)
library(gvlma)



### Linear regression
## Definition

# correlation
rairuoho<-read.table('https://www.dipintothereef.com/uploads/3/7/3/5/37359245/rairuoho.txt',header=T, sep="\t", dec=".")
cor.test(rairuoho$day6, rairuoho$day7)

# 相關係數
corr<-cor(rairuoho[,1:6])
corr # cor.test does not work on Matrix

# p-value
p.val<-rcorr(as.matrix(rairuoho[,1:6]))$P
corrplot(corr,type='upper',method='color', addCoef.col = "black", p.mat=as.matrix(p.val), sig.level = 0.05,title = "Correlation Matrix", mar = c(2,0,2,0), diag=F)

# do scatterplot(散佈圖) and add line
plot(rairuoho$day6, rairuoho$day7)
abline(lm(rairuoho$day7~rairuoho$day6), col="red", lwd=2)
# abline(a = NULL, b = NULL, h = NULL, v = NULL, reg = NULL, coef = NULL, untf = FALSE, ...)
# a 要繪製的直線截距 / b 直線的斜率 / h 繪製水平線時的縱軸值 / v 繪製垂直線時的橫軸值
# reg 是一個具有coef方法的回歸對象名稱。若該對象返回的向量長度為1，則該值會作為該該函數的斜率，否則前兩個值將會分別作為所繪直線的截距和斜率。
# coef 一個二維向量，給出截距和斜率
# untf 邏輯值，如果UNTF為真，且坐標軸中的一個或兩個進行了對數變換，則會繪製對應於原始坐標系中的直線的曲線，否則在變換坐標系中繪製線。

# remember `ggplot`
ggplot(rairuoho, aes(x = day6, y = day7)) + 
geom_point() +
stat_smooth(method = "lm", col = "red")



## Formula and basics

# The formula of linear regression can be written as follows:
# y=β0+β1∗x+ϵ
# β0 and β1 are known as the regression beta coefficients or parameters:
# β0 is the "intercept" of the regression line; that is the predicted value when x = 0. (β0->回歸線的截距)
# β1 is the "slope" of the regression line. (β1->回歸線的斜率)
# ϵ is the "error term" (also known as the "residual errors") (ϵ->誤差項、殘差)
# residual errors (ϵ) have approximately mean zero.



## Computation

# lm -> base function about statistic in R  (lm -> linear model)
# In the iris data set, a linear model equation can be written as follow:
# Petal.Width=β0+β1∗Petal.Length

model1 <- lm(Petal.Width ~ Petal.Length, data = iris)
model1$coefficients
# (Intercept) Petal.Length --> Intercept=β0 / Petal.Length=β1
# -0.3630755    0.4157554 

ggplot(iris, aes(x = Petal.Length, y = Petal.Width)) +
  geom_point(aes(fill=Species),shape = 21, size=5) +
  stat_smooth(method = "lm", col = "blue")



## Model summary

summary(model1)

confint(model1)





model1 <- lm(Petal.Width ~ Petal.Length, data = iris)
plot(model1)   # enter *4 -> 四種圖




# gvlma( ) function in the gvlma package --> 可以把所有function放在一起




###### 11/22 #######
### Regression diagnostics --> improtant need remember!

## Diagnostic plots


### Bootstrap

## Dataset Simulation

set.seed(2021)
n <- 1000
x <- rnorm(n)
y <- x + rnorm(n)
population.data <- as.data.frame(cbind(x, y))

sample.data <- population.data[sample(nrow(population.data), 20, replace = TRUE),]

population.data
sample.data


## Simple regression models

population.model <- lm(y~x, population.data)
summary (population.data)

sample.model <- lm(y~x, sample.data) # lm just on our sample
summary (sample.model)
# we will expect Estimate of sample will similar with population

# Bootstrap Approach --> repeat 1000 times up,趨於鐘形分布 --> to se if you are something stable

# Containers for the coefficients
sample_coef_intercept <- NULL
sample_coef_x1 <- NULL

for (i in 1:1000) {
  #Creating a resampled dataset from the sample data
  sample_d = sample.data[sample(1:nrow(sample.data), nrow(sample.data), replace = TRUE), ]
  
  #Running the regression on these data
  model_bootstrap <- lm(y ~ x, data = sample_d)
  
  #Saving the coefficients
  sample_coef_intercept <-
    c(sample_coef_intercept, model_bootstrap$coefficients[1])
  
  sample_coef_x1 <-
    c(sample_coef_x1, model_bootstrap$coefficients[2])
}

coefs <- rbind(sample_coef_intercept, sample_coef_x1)
coefs


## Cross Validation








### Comparing Models

install.packages("MBESS")
library(MBESS)
data(prof.salary)

fit.prof1 <- lm(salary~pub, data=prof.salary)
fit.prof2  <- lm(salary~citation, data=prof.salary)
fit.prof3 <- lm(salary~pub+citation, data=prof.salary)
fit.prof4  <- lm(salary~citation+pub, data=prof.salary)

# compare model 3 to model 1 - stepping approach, evaluating a new variable (cits)
anova(fit.prof1,fit.prof3)# note this is anova, not Anova

# compare model 3 to model 2 - stepping approach, evaluating a new variable (pubs)
anova(fit.prof2,fit.prof3)# note this is anova, not Anova



### Variable Selection

# Akaike Information Criterion (AIC) --> 檢視哪個model比較好
# The AIC replaces log(n) by 2, so it penalizes less complex models.
# 少變數 --> 用AIC // 複雜者 --> 用BIC

# stepAIC() and stepBIC() --> 諸多因子中，推薦較適合開始分析的簡單因子

# model.full <- lm(salary ~., data = prof.salary) --> salary ~. => "." means everything(every variable)




###### 11/29 #######
### F-tests

### Anova models

students<-read.table('https://www.dipintothereef.com/uploads/3/7/3/5/37359245/students.txt',header=T, sep="\t", dec='.') 
lm.cat<-lm(shoesize~gender, data=students)
anova(lm.cat)

iris.lm<-lm(Petal.Width ~ Species, data=iris)
summary(iris.lm)

anova(iris.lm)


## Full-factorial between-subjects ANOVA

pirateplot(formula = time ~ cleaner + type,
           data = poopdeck,
           ylim = c(0, 150),
           xlab = "Cleaner",
           ylab = "Cleaning Time (minutes)",
           main = "poopdeck data",
           back.col = gray(.97), 
           cap.beans = TRUE, 
           theme = 2)


# ANOVA 只能告訴你3組之間有顯著差異,無法告訴你是誰不一樣,需要使用事後檢定(TukeyHSD)

# Random Effects --> 例如:計算成績,想看進步幅度,而非最終到達分數,要考慮此random effect --> consider Individual variation

# last plot --> 斜率不變, 上下會移動
ggplot(rai, aes(x = day, y = length)) +
  geom_line(data = newdata2,
            color = 'blue') +
  geom_point() +
  scale_x_continuous(breaks = 0:7) +
  facet_wrap(~ID) +
  labs(y = "Length", x = "Days")

# Random Intercept and slope model -> 起始能力不同(Intercept) & 進步能力不同(slope model)

