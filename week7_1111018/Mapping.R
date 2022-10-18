install.packages("maptools")
install.packages("rgdal")
install.packages("sp")
install.packages("raster")
install.packages("ggplot2")
install.packages("sf")
install.packages("rnaturalearth")
install.packages("rnaturalearthdata")
install.packages("ggspatial")
install.packages("rgbif")
install.packages("mapr")
install.packages("leaflet")

library(maptools)
library(rgdal)
library (sp)
library(raster)
library(ggplot2)
library(sf)
library(rnaturalearth)
library(rnaturalearthdata)
library(ggspatial)
library(rgbif)
library(mapr)
library(marmap)
library(leaflet)



### Basic map

# Simplified world country polygons
data(wrld_simpl) 
# “Plot the world”
plot(wrld_simpl)

plot(wrld_simpl,xlim=c(100,130),ylim=c(-20,50),col='olivedrab3',bg='lightblue')

# zoom on Taiwan
str(wrld_simpl)  # many Polygons
?wrld_simpl
plot(wrld_simpl,xlim=c(120,125),ylim=c(20,30),col='olivedrab3',bg='lightblue')
# X-->經度Longitude / Y-->緯度Latitude



### Shapes
## gpx track

par(mfrow=c(1,2)) #--> 1 row 2 colum (每個框框可以放一個圖=2個圖)
plot(1)
plot(2)

par(mfrow=c(2,2)) #--> 2 row 2 colum (每個框框可以放一個圖=4個圖)
plot(1)
plot(2)
plot(3)
plot(4)


# reading  --> 可以自己下載設定gpx

par(mfrow=c(1,2))
run1 <- readOGR(dsn="D:/R_class/week7_1111018/run.gpx",layer="tracks")

plot(run1, main='Line') # my running activity
run2 <- readOGR(dsn="D:/R_class/week7_1111018/run.gpx",layer="track_points")

plot(run2, main='Points')

dev.off() # 清除plot設定

# writing

writeOGR(wrld_simpl, dsn="Data", layer = "world_test", driver = "ESRI Shapefile", overwrite_layer = TRUE) 
# ESRI Shapefile is default



### shp files

world_shp <- readOGR(dsn = "Data",layer = "world_test")

plot(world_shp)



### Spatial data

# SpatialPointsDataFrame for plotting points
plot(wrld_simpl,xlim=c(115,128) ,ylim=c(19.5,27.5),col='#D2B48C',bg='lightblue') # TW map
coords <- matrix(c(121.537290,120.265541, 25.021335, 22.626524),ncol=2) # NTU and SYS univ. 
coords <- coordinates(coords) # assign values as spatial coordinates(把經緯度轉成：座標)
spoints <- SpatialPoints(coords) # create SpatialPoints
df <- data.frame(location=c("NTU","SYS")) # create a dataframe
spointsdf <- SpatialPointsDataFrame(spoints,df) # create a SpatialPointsDataFrame
plot(spointsdf,add=T,col=c('black','black'),pch=19,cex=2.2) # plot it on our map   # add 加上去
text(121,24, 'TAIWAN', cex=1)  # 把字放到121,24、沒有改成coordinates並存到SpatialPoints,如果換圖-字會跑掉

# SpatialLinesDataFrame for plotting lines: let’s move to Canada where the provinces where drw with a ruler: an example with the province of Saskatchewan and following the same logic as ealier.
plot(wrld_simpl,xlim=c(-130,-60),ylim=c(45,80),col='#D2B48C',bg='lightblue')
coords <- matrix(c(-110,-102,-102,-110,-110,60,60,49,49,60),ncol=2)
l <- Line(coords)
ls <- Lines(list(l),ID="1")
sls <- SpatialLines(list(ls))
df <- data.frame(province="Saskatchewan")
sldf <- SpatialLinesDataFrame(sls,df)
plot(sldf,add=T,col='#3d2402', cex=2)
text(-114, 55, 'Saskatchewan', srt=90, cex=0.5)
text(-114, 63, 'CANADA', cex=1)

# SpatialPolygonesDataFrame for plotting polygons instead of lines. It will help in filling the spatial shpae with a selected color or pattern.
plot(wrld_simpl,xlim=c(-130,-60),ylim=c(45,80),col='#D2B48C',bg='lightblue')
coords <- matrix(c(-110,-102,-102,-110,-110,60,60,49,49,60),ncol=2)
p <- Polygon(coords)
ps <- Polygons(list(p),ID="1")
sps <- SpatialPolygons(list(ps))
df <- data.frame(province="Saskatchewan")
spdf <- SpatialPolygonsDataFrame(sps,df)
plot(spdf,add=T,col='#45220d') 
text(-114, 55, 'Saskatchewan', srt=90, cex=0.7)
text(-114, 63, 'CANADA', cex=1)
text(-103, 46, 'UNITED STATES', cex=1)
text(-40, 78, 'GREENLAND', cex=1)
text(-35, 55, 'Atlantic Ocean', cex=1, col='#071238')

# 通常不用做地圖，網路上可以抓，直接匯入地圖



### GADM

# 匯入地圖
TWN1 <- getData('GADM', country="TWN", level=0) # data Taiwan
JPN <- getData('GADM', country="JPN", level=0) # data Japan
class(TWN1) # those datasets are SpatialPolygonsDataFrame  # every country has it code need 查(Taiwan: TWN)

par(mfrow = c(1, 2))
plot(TWN1,axes=T,bg=colors()[431],col='grey')
plot(JPN,axes=T,bg=colors()[431],col='grey')

dev.off()

# zoom on a point a map
# Simply set up xlim and ylim

plot (TWN1, axes=T, xlim=c(121,122), ylim=c(24,25.5), bg=colors()[431],col='grey') 

# Level
TWN2 <- getData('GADM', country="TWN", level=1)
TWN2$NAME_1

plot(TWN1,col="grey",xlim=c(119,122.5), ylim=c(21.5,25.5), bg=colors()[431], axes=T)
KAO <- TWN2[TWN2$NAME_1=="Kaohsiung",]
plot(KAO,col="grey 33",add=TRUE)

TWN1
TWN2 # have 7 polygon


# A map can further be customized by combining all seen earlier (e.g. adding population)
# base map
plot(TWN1,col="grey",xlim=c(121,122), ylim=c(24,25.5), bg=colors()[431], axes=T)
# adding  spatial polygones 
TAI <- TWN2[TWN2$NAME_1=="Taipei" | TWN2$NAME_1=="New Taipei" ,]  # | --> and
plot(TAI,col="black",add=TRUE)
# adding spatial points 
coords <- matrix(cbind(lon=c(121.2,121.55,121.8),lat=c(25,25.19,24.5)),ncol=2)
coords <- coordinates(coords)
spoints <- SpatialPoints(coords)
df <- data.frame(location=c("City 1","City 2","City 3"),pop=c(138644,390095,34562))
spointsdf <- SpatialPointsDataFrame(spoints,df)
scalefactor <- sqrt(spointsdf$pop)/sqrt(max(spointsdf$pop))
plot(spointsdf,add=TRUE,col='white',pch=1,cex=scalefactor*3,lwd=2) 
# adding a location of NTU (not spatial point here)
points(121.537290,25.021335, type="p", pch=18, col='white', cex=1.5)
# adding text
text(121.53,24.921335,"NTU", col='white', font=2)
# adding scale
maps::map.scale(x=120, y=25.4)
# adding north arrow
GISTools::north.arrow(xb=120.3,yb=24.7, len=0.06, lab='N')   #??????????????下載不了

install.packages("GISTools")
install.packages("GISTools", dependencies = TRUE)
getOption("GISTools")



### Country data
# 已經是Taiwan computure don't need do this
# Sys.setlocale(category = "LC_ALL", "Chinese (Traditional)_Taiwan.950")

# copy download link-->don't need to download!

url <- 'https://data.moi.gov.tw/MoiOD/System/DownloadFile.aspx?DATA=72874C55-884D-4CEA-B7D6-F60B0BE85AB0'
path1 <- tempfile(fileext = ".zip")
if (file.exists(path1))  'file alredy exists' else download.file(url, path1, mode="wb")
zip::unzip(zipfile = path1,exdir = 'Data')

taiwan <- readOGR('Data/COUNTY_MOI_1090820.shp', use_iconv=TRUE, encoding='UTF-8')

plot(taiwan,axes=T,bg=colors()[431],col='grey')

taiwan$COUNTYNAME
taiwan$COUNTYENG 

dev.off()



### ggplot2 & sf
library("ggplot2")
library("sf")

############  處理?????????????????????? 檢查today's all package
remove.packages("e1071")
install.packages("e1071")
library("sf")


## Theme and datasets

theme_set(theme_bw()) 

world <- ne_countries(scale = "medium", returnclass = "sf")
class(world)



## A ggplot map

ggplot(data = world) +
  geom_sf()

ggplot(data = world) +
  geom_sf() +
  coord_sf(expand = FALSE)

# Title, subtitle, and axis labels using ggtitle, xlab, ylab

ggplot(data = world) +
  geom_sf() +
  coord_sf(expand = FALSE) +
  xlab("Longitude") + ylab("Latitude") +
  ggtitle("World map", subtitle = paste0("(", length(unique(world$name)), " countries)"))

# Map color in geom_sf
ggplot(data = world) + 
  geom_sf(color = "black", fill = "lightgreen") +
  coord_sf(expand = FALSE) 

# example that shows the population of each country
ggplot(data = world) +
  geom_sf(aes(fill = pop_est)) +
  coord_sf(expand = FALSE) +
  scale_fill_viridis_c(option = "plasma", trans = "sqrt") # sqrt transform


# Projection and extend (coord_sf)
ggplot(data = world) +
  geom_sf() +
  scale_fill_viridis_c(option = "plasma", trans = "sqrt") +
  coord_sf(crs = "+proj=laea +lat_0=52 +lon_0=10 +x_0=4321000 +y_0=3210000 +ellps=GRS80 +units=m +no_defs ")


ggplot(data = world) +
  geom_sf() +
  coord_sf(crs = "+init=epsg:3035")

# OR

ggplot(data = world) +
  geom_sf() +
  coord_sf(crs = st_crs(3035))


# allowing to “zoom” in the area of interest
ggplot(data = world) +
  geom_sf(aes(fill = pop_est)) +
  coord_sf(xlim = c(118, 128), ylim = c(17, 27), expand = FALSE) +
  scale_fill_viridis_c(option = "plasma") # linear scale



### ggspatial elements

# Scale bar and North arrow
ggplot(data = world) +
  geom_sf(aes(fill = pop_est)) +
  coord_sf(xlim = c(118, 128), ylim = c(17, 27), expand = FALSE) +
  scale_fill_viridis_c(option = "plasma") +
  annotation_scale(location = "br", width_hint = 0.3) +
  annotation_north_arrow(location = "br", which_north = "true", 
                         pad_x = unit(0.5, "cm"), pad_y = unit(1, "cm"),
                         style = north_arrow_fancy_orienteering) 


# 進階--jst see
sf::sf_use_s2(FALSE) # FOR ERROR turn off the s2 processing
world_points<- st_centroid(world)
world_points <- cbind(world, st_coordinates(st_centroid(world$geometry)))

ggplot(data = world) +
  geom_sf(aes(fill = pop_est)) +
  geom_text(data= world_points,aes(x=X, y=Y, label=name),
            color = "grey", fontface = "bold", check_overlap = FALSE) +
  scale_fill_viridis_c(option = "plasma") +
  annotate(geom = "text", x = 124, y = 21, label = "Pacific Ocean", fontface = "italic", color = "#0b3c8a", size = 5) +
  annotate(geom = "text", x = 124.2, y = 24, label = "Ryukyu archipelago", fontface = "italic", color = "#d41919", size = 3) + 
  coord_sf(xlim = c(118, 128), ylim = c(17, 27), expand = FALSE)

# 進階too：  To goo further: Finalization
ggplot(data = world) +
  geom_sf(fill= 'antiquewhite') + 
  geom_text(data= world_points,aes(x=X, y=Y, label=name), color = 'darkblue', fontface = 'bold', check_overlap = FALSE) + 
  annotate(geom = 'text', x = -90, y = 26, label = 'Gulf of Mexico', fontface = 'italic', color = 'grey22', size = 6) +
  annotation_scale(location = 'bl', width_hint = 0.5) + 
  annotation_north_arrow(location = 'bl', which_north = 'true', pad_x = unit(0.75, 'in'), pad_y = unit(0.5, 'in'), style = north_arrow_fancy_orienteering) + 
  coord_sf(xlim = c(-102.15, -74.12), ylim = c(7.65, 33.97), expand = FALSE) + 
  xlab('Longitude') + ylab('Latitude') + 
  ggtitle('Map of the Gulf of Mexico and the Caribbean Sea') + 
  theme(panel.grid.major = element_line(color = gray(.5), linetype = 'dashed', size = 0.5), panel.background = element_rect(fill = 'aliceblue'))



### Exporting map

ggsave("Figures/Datamap.pdf")
ggsave("Figures/map_web.png", width = 6, height = 6, dpi = "screen")
# ???????????????????????????????????????????????????????????????????????????? how to save pic??


### Special

### Species distribution rgbif

gbif.res <- occ_search(scientificName = "Urocissa caerulea", limit = 1200)

map_ggplot(gbif.res) +
  coord_sf(xlim = c(120, 123), ylim = c(21, 26), expand = FALSE)



### Bathymetric map with marmap

install.packages("marmap")
library("marmap")



# query
TW.bathy <- getNOAA.bathy(lon1=118,lon2=124, lat1=21,lat2=26,resolution=1) # don't put too wide / resolution: 1 
# define palette
blues <- colorRampPalette(c("darkblue", "cyan"))  # deep-darkblue / shollow-cyan
greys <- colorRampPalette(c(grey(0.4),grey(0.99))) # 兩種不同灰色(深--矮 / 淺--高)
# make the plot
plot.bathy(TW.bathy,
           image=T,
           deepest.isobath=c(-6000,-120,-30,0),   # 下界
           shallowest.isobath=c(-1000,-60,0,0),   # 上界
           step=c(2000,60,30,0),   # 區間: 多少區間畫一條線
           lwd=c(0.3,1,1,2),   # 線粗細
           lty=c(1,1,1,1),   # 線的形式(虛線or實線)：1=實線
           col=c("grey","black","black","black"),    # 線的顏色
           drawlabels=c(T,T,T,F),   # ???
           bpal = list(c(0,max(TW.bathy),greys(100)),c(min(TW.bathy),0,blues(100))),   # ???
           land=T, xaxs="i")  # ???

# Profiles can be extract using get.transect:

manual.profile<-get.transect (TW.bathy, loc=T,dist=T)  # 自選圖上的剖面
plotProfile(manual.profile)

tw.profile <-get.transect(TW.bathy,x1=119.5,y1=23.75, x2=122,y2=23.75, dis=TRUE)
plotProfile(tw.profile) 



### Interactive maps
install.packages("Leaflet")
library("leaflet")

FRE <- paste(sep = "<br/>",
             "<b><a href='https://www.dipintothereef.com/'>FRELAb TAIWAN</a></b>",
             "Functional Reef Ecology Lab",
             "Institute of Oceanography, NTU")


leaflet(taiwan) %>%
  addPolygons(weight=0.5) %>%
  addTiles(group="Kort") %>%
  addPopups(121.53725, 25.021252, FRE, options = popupOptions(closeButton = FALSE))


# change 背景
leaflet(taiwan) %>%
  addPolygons(weight=0.5) %>%
  addProviderTiles(providers$Stamen.Toner) %>%
  addPopups(121.53725, 25.021252, FRE, options = popupOptions(closeButton = FALSE))




