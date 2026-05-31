\name{sample_transects}
\alias{sample_transects}

\title{Sample transects}

\usage{
sample_transects(x, y, interval, keep = 1, spar = 0.3,
                 rm.intersections = TRUE, transect.length = NULL)
}

\description{
Sample transects.
}

\arguments{
  \item{x}{A \code{SpatRaster} containing at least one layer.}
  \item{y}{A \code{SpatVector} containing a polygon or a line that defines the
  boundary of an area.}
  \item{interval}{(Numeric). Distance between transects.}
  \item{keep}{(Numeric). The proportion of vertices from the polygon to be
  retained. Default value is 1.}
  \item{spar}{(Numeric). The smoothing factor of the centerline ranging from 0
  to 1. The higher the value, the greater the smoothing. Default value is 0.3.}
  \item{rm.intersections}{(Logical). Should overlapping transects be removed?
  Default is \code{TRUE}.}
  \item{transect.length}{(Numeric). Transect length. By default, this is
  automatically estimated.}
}

\value{
The result is a list consisting of three objects:
  \item{}{1. The centerline of the polygon as \code{SpatVector}.}
  \item{}{2. The data frame containing the cell values for the center points.}
  \item{}{3. The data frame containing cell values for the transects.}
}

\examples{
library("terra")

DEM = system.file("DEM.tif", package = "TrailMapper")
DEM = rast(DEM)

boundary = system.file("boundary.gpkg", package = "TrailMapper")
boundary = vect(boundary)
boundary$ID = 1 # this is now required to work

output = sample_transects(DEM, boundary, interval = 2)
str(output)

# plot centerline
plot(output[[1]], main = "Centerline")

# plot central points
points(output[[2]]$x, output[[2]]$y, pch = 19)

# plot transects points
for (i in unique(output[[3]]$ID)) {
  d = output[[3]][output[[3]]$ID == i, ]
  lines(d$x, d$y, lwd = 2)
}
}
