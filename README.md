# TrailMapper

<!-- badges: start -->

<!-- badges: end -->

**TrailMapper** is an R package for morphometric analysis of trails.
This is an open-source implementation of the ArcGIS toolbox created by
Tweneboah Kodua Dwamena.

## Installation

You can install the development version from [GitHub](https://github.com/) with:

```r
# install.packages("remotes")
remotes::install_github("kadyb/TrailMapper")
```

## Usage

```r
library("terra")
library("TrailMapper")

DEM = system.file("DEM.tif", package = "TrailMapper")
DEM = rast(DEM)

boundary = system.file("boundary.gpkg", package = "TrailMapper")
boundary = vect(boundary)
boundary$ID = 1 # this is now required to work

# create the centerline
cl = centerline(boundary, smooth = 0)

# create center points
pts = centerpoints(cl, interval = 2)

# create transects
tr = transects(cl, pts, boundary)

# sample for transects
tr_smp = get_values(DEM, tr)

# plot transect no. 1
plot_transects(tr_smp, index = 1)
```
