\name{transects}
\alias{transects}

\title{Generate transects}

\usage{
transects(x, centerpoints, polygon, transect.length = NULL)
}

\description{
Generate transects for the centerline.
}

\arguments{
  \item{x}{A \code{SpatVector} representing the centerline.}
  \item{centerpoints}{A \code{SpatVector} containing center points.}
  \item{polygon}{A \code{SpatVector} containing a polygon (or a line) that
  defines the boundary of an area.}
  \item{transect.length}{(Numeric). Transect length. By default, this is
  automatically estimated. If the transect is too short, enter your preferred
  value.}
}

\value{
SpatVector
}

\examples{
library("terra")

boundary = system.file("boundary.gpkg", package = "TrailMapper")
boundary = vect(boundary)
boundary$ID = 1 # this is now required to work

cl = centerline(boundary, smooth = 0)
pts = centerpoints(cl, interval = 2)
tr = transects(cl, pts, boundary)

plot(boundary, border = "grey")
plot(cl, lwd = 2, add = TRUE)
plot(tr, add = TRUE)
}
