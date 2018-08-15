## Exploring NASA data
## - sea surface temps
## - daily primary productivity 

####### libraries
library(tidyverse)
library(ncdf4)


###### open file
path <- file.path("N:", "Transfer", "HJohnson")
seasurface <- nc_open(file.path(path, "T2018188.L3m_DAY_SST_sst_9km.nc")) # from july 7, 2018


##### look at it more
names(seasurface)
seasurface$var[[1]]
