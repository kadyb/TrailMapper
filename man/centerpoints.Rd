\name{centerpoints}
\alias{centerpoints}

\title{Generate center points}

\usage{
centerpoints(x, interval)
}

\description{
Generate center points on the center line. The points are then used to
generate transects.
}

\arguments{
  \item{x}{A \code{SpatVector} representing the centerline.}
  \item{interval}{(Numeric). Distance between center points.}
}

\value{SpatVector}

\examples{
library("terra")

boundary = system.file("boundary.gpkg", package = "TrailMapper")
boundary = vect(boundary)
boundary$ID = 1 # this is now required to work

cl = centerline(boundary, smooth = 0)
pts = centerpoints(cl, interval = 2)

plot(boundary, border = "grey")
plot(cl, lwd = 2, add = TRUE)
plot(pts, col = "blue", add = TRUE)
text(pts, pos = 4, cex = 0.7)
}
