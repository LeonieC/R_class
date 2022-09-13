fish<-read.table('D:/R_wd/week1/R_classs/R_classs/reef_fish.txt', header=T, sep='\t', dec='.')
barplot(fish$richness, main="Top 10 reef fish Richness (Allen, 2000)", horiz=TRUE, names.arg=fish$country, cex.names=0.5, las=1)

library(readxl) # load the package `readxl'
read_excel('D:/R_wd/week1/R_classs/R_classs/reef_fish.xlsx') # automatically print on my screen


fish<-read_excel('D:/R_wd/week1/R_classs/R_classs/reef_fish.xlsx') # store my table in an object called `fish`
fish # print my object `fish`   

fish2<-read.table('D:/R_wd/week1/R_classs/R_classs/reef_fish.txt', header=T, sep='\t', dec='.') 

barplot(fish2$richness, main="Top 10 reef fish Richness (Allen, 2000)", horiz=TRUE, names.arg=fish$country, cex.names=0.5, las=1)

###
?git push
