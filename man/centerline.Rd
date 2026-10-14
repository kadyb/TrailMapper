\name{centerline}
\alias{centerline}

\title{Generate a centerline}

\usage{
centerline(x, keep = 1, smooth = 0.3)
}

\description{
Generate a centerline.
}

\arguments{
  \item{x}{A \code{SpatVector} containing a polygon or a line that defines the
  boundary of an area.}
  \item{keep}{(Numeric). The proportion of vertices from the polygon to be
  retained. The lower the value, the faster the processing, but at the cost
  of accuracy. For complex polygons (i.e., long, narrow, and winding ones),
  a value that is too low may cause the centerline to be truncated. Default
  value is 1.}
  \item{smooth}{(Numeric). The smoothing factor of the centerline ranging from 0
  to 1. The higher the value, the greater the smoothing. Default value is 0.3.}
}

\value{SpatVector}

\examples{
library("terra")

boundary = system.file("boundary.gpkg", package = "TrailMapper")
boundary = vect(boundary)
boundary$ID = 1 # this is now required to work

cl = centerline(boundary, smooth = 0)

plot(boundary, border = "grey")
plot(cl, lwd = 2, add = TRUE)
}
