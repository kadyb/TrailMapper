# Sample transects

Sample transects.

## Usage

``` r
sample_transects(x, y, interval, keep = 1, spar = 0.3,
                 rm.intersections = TRUE, transect.length = NULL)
```

## Arguments

- x:

  A `SpatRaster` containing at least one layer.

- y:

  A `SpatVector` containing a polygon or a line that defines the
  boundary of an area.

- interval:

  (Numeric). Distance between transects.

- keep:

  (Numeric). The proportion of vertices from the polygon to be retained.
  The lower the value, the faster the processing, but at the cost of
  accuracy. Default value is 1.

- spar:

  (Numeric). The smoothing factor of the centerline ranging from 0 to 1.
  The higher the value, the greater the smoothing. Default value is 0.3.

- rm.intersections:

  (Logical). Should overlapping transects be removed? Default is `TRUE`.

- transect.length:

  (Numeric). Transect length. By default, this is automatically
  estimated.

## Value

The result is a list consisting of four objects:

1.  The centerline of the polygon as `SpatVector`.

2.  Points on the centerline as `SpatVector`.

3.  Perpendicular transects to the centerline as `SpatVector`.

4.  The data frame containing cell values for the transects.

## Examples

``` r
library("terra")

DEM = system.file("DEM.tif", package = "TrailMapper")
DEM = rast(DEM)

boundary = system.file("boundary.gpkg", package = "TrailMapper")
boundary = vect(boundary)
boundary$ID = 1 # this is now required to work

output = sample_transects(DEM, boundary, interval = 2)
str(output)
#> List of 4
#>  $ centerline      :S4 class 'SpatVector' [package "terra"]
#>  $ central_points  :S4 class 'SpatVector' [package "terra"]
#>  $ transects       :S4 class 'SpatVector' [package "terra"]
#>  $ transects_points:'data.frame':    251 obs. of  4 variables:
#>   ..$ ID : int [1:251] 1 1 1 1 1 1 1 1 1 1 ...
#>   ..$ x  : num [1:251] 631877 631877 631877 631877 631877 ...
#>   ..$ y  : num [1:251] 5814235 5814235 5814235 5814235 5814235 ...
#>   ..$ DEM: num [1:251] 111 111 111 111 111 ...

# plot centerline
plot(output[[1]], main = "Centerline")

# plot central points
points(output[[2]])

# plot transects
lines(output[[3]])
```
