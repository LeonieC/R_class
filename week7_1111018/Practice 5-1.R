library(leaflet)
library(readxl)



read_excel('D:/R_class/week7_1111018/100 peaks of Taiwan.xlsx')
peaks_taiwan<-read_excel('D:/R_class/week7_1111018/100 peaks of Taiwan.xlsx')
peaks_taiwan


mountainIcons <- icons(iconUrl = ifelse(peaks_taiwan$`icon D or N` < 1, # 若`icon D or N` < 1爲真
                                        "D:/R_class/week7_1111018/mountain.png", # test = TRUE
                                        "D:/R_class/week7_1111018/climbing.png"), # test = FALSE
                       iconWidth = 40, iconHeight = 40)

leaflet(data = peaks_taiwan) %>%
  addTiles() %>%
  setView(lng=121, lat=23.5, zoom = 7.45) %>%
  addMarkers(peaks_taiwan$longitude, peaks_taiwan$latitude, icon = mountainIcons, popup = paste(peaks_taiwan$name, peaks_taiwan$`done or not`))



