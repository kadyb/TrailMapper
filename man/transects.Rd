\name{transects}
\alias{transects}

\title{Generate transects}

\usage{
transects(x, polygon, interval, transect.length = NULL)
}

\description{
Generate transects for the centerline.
}

\arguments{
  \item{x}{A \code{SpatVector} representing the centerline.}
  \item{polygon}{A \code{SpatVector} containing a polygon (or a line) that
  defines the boundary of an area.}
  \item{interval}{(Numeric). Distance between transects.}
  \item{transect.length}{(Numeric). Transect length. By default, this is
  automatically estimated. If the transect is too short, enter your preferred
  value.}
}

\value{
The result is a list consisting of two objects:
  \enumerate{
    \item Perpendicular transects to the centerline as \code{SpatVector}.
    \item Points on the centerline as \code{SpatVector}.
  }
}

\examples{
library("terra")

boundary = system.file("boundary.gpkg", package = "TrailMapper")
boundary = vect(boundary)
boundary$ID = 1 # this is now required to work

cl = centerline(boundary, smooth = 0)
tr = transects(cl, boundary, interval = 2)

plot(boundary, border = "grey")
plot(cl, lwd = 2, add = TRUE)
plot(tr$transects, add = TRUE)
}
