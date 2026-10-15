\name{get_values}
\alias{get_values}

\title{Get values}

\usage{
get_values(x, y)
}

\description{
Get raster values for transects or center points.
}

\arguments{
  \item{x}{A \code{SpatRaster} containing at least one layer.}
  \item{y}{A \code{SpatVector} containing transects or central points.}
}

\value{
Data frame, if transects were used.

SpatVector, if center points were used.
}

\examples{
library("terra")

DEM = system.file("DEM.tif", package = "TrailMapper")
DEM = rast(DEM)

boundary = system.file("boundary.gpkg", package = "TrailMapper")
boundary = vect(boundary)
boundary$ID = 1 # this is now required to work

cl = centerline(boundary, smooth = 0)
pts = centerpoints(cl, interval = 2)
tr = transects(cl, pts, boundary)

# sample for centerpoints (SpatVector)
pts = get_values(DEM, pts)

# sample for transects (data frame)
tr_smp = get_values(DEM, tr)
}
