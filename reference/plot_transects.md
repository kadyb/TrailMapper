# Plot transects

Plot transects.

## Usage

``` r
plot_transects(x, index = NULL, fixed_elev = TRUE, save_dir = NULL, ...)
```

## Arguments

- x:

  A data frame containing sampling points from transects. It should
  include at least the following columns: ID, x, y, and elevation.

- index:

  (Numeric). Which transects should be displayed? The default is `NULL`,
  which displays all transects.

- fixed_elev:

  (Logical). Should the Y-axis (elevation) be constant for all
  transects? The default is `TRUE`.

- save_dir:

  The path to the directory where the images will be saved. The default
  value is `NULL`, which means they will not be saved to disk.

- ...:

  Parameters that will be passed to
  [`png`](https://rdrr.io/r/grDevices/png.html) such as `width`,
  `height`, and `resolution`.

## Value

If `save_dir = NULL`, it displays the image. If a directory is
specified, it will be saved to disk in PNG format.

## Examples

``` r
library("terra")
#> terra 1.9.50

DEM = system.file("DEM.tif", package = "TrailMapper")
DEM = rast(DEM)

boundary = system.file("boundary.gpkg", package = "TrailMapper")
boundary = vect(boundary)
boundary$ID = 1 # this is now required to work

output = sample_transects(DEM, boundary, interval = 2)

# plot transect no. 1
plot_transects(output[[4]], index = 1)
```
