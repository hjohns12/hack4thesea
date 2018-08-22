## Exploring NASA data
## - sea surface temps
## - daily primary productivity 

install.packages("raster")

####### libraries
library(tidyverse)
library(ncdf4)
library(raster)


###### open file
path <- file.path("N:", "Transfer", "HJohnson")
seasurface <- nc_open(file.path(path, "T2018188.L3m_DAY_SST_sst_9km.nc")) # from july 7, 2018


##### look at it more
names(seasurface)
seasurface$var[[1]]

#seasurface$var$sst$units

##### using ncdf4 package
# resource: http://geog.uoregon.edu/bartlein/courses/geog490/week04-netCDF.html#reading-restructuring-and-writing-netcdf-files-in-r
print(seasurface)
lon <- ncvar_get(seasurface, "lon")
lat <- ncvar_get(seasurface, "lat")


##### using raster package 
# resource: https://rpubs.com/markpayne/358146
sea3d <- brick(file.path(path, "T2018188.L3m_DAY_SST_sst_9km.nc")) # brick: 3d data

sea3d         # there is 1 layer
plot(sea3d, xlab = "longitude", ylab = "latitude")   # this looks promising


# sea3d.raster <- raster(file.path(path, "T2018188.L3m_DAY_SST_sst_9km.nc"))  # raster: 2d data
# plot(sea3d.raster)


# extracting data in a region (right now a latitude line)

lon.section <- seq(-20, 20, by = 0.5)
lat.section <- rep(55, length(lon.section))

points(lon.section, lat.section, cex = 0.5,  col = "red")

extract.section <- cbind(lon.section, lat.section)
ext.values <- raster::extract(sea3d, extract.section, ncol = 2) 

# to do: make data frame with lat as rows and long as columns and fill with temps
#        automate the process above for all longs & lats

# making data frame
seasurftemp <- as.data.frame(cbind(extract.section, ext.values))
colnames(seasurftemp)[3] <- "temp" 

# plotting graph of temps by longitude
plot(lon.section, ext.values, xlab = "Longitude", ylab = "Temps in Celcius")

