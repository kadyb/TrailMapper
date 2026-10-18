transects = function(x, centerpoints, polygon, transect.length = NULL) {

  if (!inherits(x, "SpatVector")) {
    stop("`x` must be a SpatVector.")
  }

  if (!inherits(polygon, "SpatVector")) {
    stop("`polygon` must be a SpatVector.")
  }

  if (terra::is.lines(polygon)) {
    polygon = terra::as.polygons(polygon)
  }

  if (!terra::same.crs(x, polygon)) {
    polygon = terra::project(polygon, terra::crs(x))
    message(
      "Different coordinate reference systems of the datasets.\n",
      "The boundaries have been projected automatically."
    )
  }

  line_len = terra::perim(x)
  transects = .perp_lines(centerpoints, polygon, line_len, transect.length)
  transects$width = terra::perim(transects)

  return(transects)
}

.perp_lines = function(pts, polygon, len, transect.length = NULL) {

  x = terra::crds(pts)[, 1L]
  y = terra::crds(pts)[, 2L]
  n = nrow(pts)
  lines_list = vector("list", n)

  if (is.null(transect.length)) {
    area = terra::expanse(polygon, unit = "m")
    transect.length = 4 * (area / len)
  }

  for (i in seq_len(n)) {
    # calculate local direction of the line between points
    if (i == 1L) {
      angle = atan2(y[i + 1L] - y[i], x[i + 1L] - x[i])
    } else if (i == n) {
      angle = atan2(y[i] - y[i - 1L], x[i] - x[i - 1L])
    } else {
      angle = atan2(y[i + 1L] - y[i - 1L], x[i + 1L] - x[i - 1L])
    }

    # rotate the angle by 90 degrees
    perp_angle = angle + pi/2

    # calculate offset
    dx = cos(perp_angle) * (transect.length / 2)
    dy = sin(perp_angle) * (transect.length / 2)

    # rotate coordinates
    p1 = c(x[i] + dx, y[i] + dy)
    p2 = c(x[i] - dx, y[i] - dy)

    # set starting and ending points
    lines_list[[i]] = matrix(c(p1, p2), ncol = 2L, byrow = TRUE)
  }

  perp_lines = terra::vect(lines_list, type = "lines", crs = terra::crs(pts))
  perp_lines$ID = seq_len(n)
  perp_lines = terra::crop(perp_lines, polygon)

  return(perp_lines)
}


