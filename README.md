# TrailMapper

<!-- badges: start -->

<!-- badges: end -->

**TrailMapper** is an R package for morphometric analysis of trails.
This is an open-source implementation of the ArcGIS toolbox.

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

output = sample_transects(DEM, boundary, interval = 2)
str(output)
```
