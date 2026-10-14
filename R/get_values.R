get_values = function(x, y) {

  if (!inherits(x, "SpatRaster")) {
    stop("`x` must be a SpatRaster.")
  }

  if (!inherits(y, "SpatVector")) {
    stop("`y` must be a SpatVector.")
  }

  if (!terra::same.crs(x, y)) {
    y = terra::project(y, terra::crs(x))
    message(
      "Different coordinate reference systems of the datasets.\n",
      "The boundaries have been projected automatically."
    )
  }

  if (terra::is.lines(y)) {
    output = terra::extractAlong(x, y, xy = TRUE)
  } else if (terra::is.points(y)) {
    output = terra::extract(x, y, bind = TRUE)
  } else {
    stop("'x' must be a point or line type.")
  }

  return(output)

}
