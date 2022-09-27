#####tidyr
rm(list=ls()) #clean memory
install.packages("tidyr")
library (tidyr)

getwd()

TW_corals<-read.table('D:/R_class/week4_1110927/tw_corals.txt', header=T, sep='\t', dec='.') 
TW_corals
# ?read.table
# sep	the field separator character. Values on each line of the file are separated by this character. If sep = "" (the default for read.table) the separator is ‘white space’, that is one or more spaces, tabs, newlines or carriage returns.

#turn table's width to length for ggplot
TW_corals_long <- TW_corals %>% pivot_longer(Southern_TW:Northern_Is, names_to = "Region_TW", values_to = "Richness")
# : 是指從哪裡到哪裡
# %>% 是想要什麼東西做什麼事
TW_corals_long 

# reverse the table
TW_corals_wide<-pivot_wider(TW_corals_long, names_from = "Region_TW",values_from = "Richness")
TW_corals_wide



income<-read.table('D:/R_class/week4_1110927/metoo.txt',header=T, sep="\t", dec=".", na.strings = "n/a")
income

# 改變項目--整合(性別、工作時間)
income_long <- income %>%  pivot_longer(cols = -state, 
                                        names_to = c("gender","work_type"), 
                                        names_sep = "_", 
                                        values_to = "income")
# 去除state之外，剩下的名稱改成gender跟work_type，名稱以"_"作為分隔；數值變成income
income_long  #for跑出表格


income_wide<-income_long %>% pivot_wider(names_from = c("gender","work_type"), 
                            values_from = "income",
                            names_sep = ".")
income_wide

income



###Splitting

###columns
# Let's first create a delimited table
income_long_var <- income %>%  pivot_longer(cols = -1, 
                                            names_to = "var1", 
                                            values_to = "income")
income_long_var

# Split var1 column into two columns
income_sep <- income_long_var %>%  separate(col = var1, 
                                            sep = "_", 
                                            into = c("gender", "work_type"))
income_sep
head(income_sep)

#簡化上面income_sep的step
income_sep2 <- income %>% pivot_longer(col = -1, 
                                       names_to = "var1",
                                       values_to = "income")%>%  
                separate(col = var1,
                sep = "_",
                into = c("gender", "work_type"))
income_sep2

#簡化上面income_sep and income_sep2 的step
income_sep3<- income %>%  pivot_longer(cols = -1, 
                                       names_to = c("gender","work_type"), 
                                       values_to = "income",
                                       names_sep = "_")
income_sep3



###rows
#Split var1 into two rows
income_long_var %>% separate_rows(var1, sep = "_")

#many other functions, such as uncount
df<-tibble(x=c("a","b"),n=c(1,2))
uncount(df,n)
uncount(df,n, .id="id")

df<-tibble(x=c("Dark","Brunette","Blond"),n=c(10,3,1))
df




