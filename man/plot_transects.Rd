\name{plot_transects}
\alias{plot_transects}

\title{Plot transects}

\usage{
plot_transects(x, index = NULL, fixed_elev = TRUE, save_dir = NULL, ...)
}

\description{
Plot transects.
}

\arguments{
  \item{x}{A data frame containing sampling points from transects. It should
  include at least the following columns: ID, x, y, and elevation.}
  \item{index}{(Numeric). Which transects should be displayed? The default
  is \code{NULL}, which displays all transects.}
  \item{fixed_elev}{(Logical). Should the Y-axis (elevation) be constant for
  all transects? The default is \code{TRUE}.}
  \item{save_dir}{The path to the directory where the images will be saved.
  The default value is \code{NULL}, which means they will not be saved to disk.}
  \item{...}{Parameters that will be passed to \code{\link{png}} such as
  \code{width}, \code{height}, and \code{resolution}.}
}

\value{
If \code{save_dir = NULL}, it displays the image. If a directory is specified,
the image will be saved to disk in PNG format.
}

\examples{
library("terra")

DEM = system.file("DEM.tif", package = "TrailMapper")
DEM = rast(DEM)

boundary = system.file("boundary.gpkg", package = "TrailMapper")
boundary = vect(boundary)
boundary$ID = 1 # this is now required to work

output = sample_transects(DEM, boundary, interval = 2)

# plot transect no. 1
plot_transects(output[[4]], index = 1)
}
