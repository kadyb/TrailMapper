centerline = function(x, keep = 1, smooth = 0.3) {

  if (!inherits(x, "SpatVector")) {
    stop("`x` must be a SpatVector.")
  }

  if (terra::is.lines(x)) {
    x = terra::as.polygons(x)
  }

  centerline = centerline::cnt_path_guess(x, keep = keep)
  if (ncol(centerline) != 0) {
    values(centerline) = NULL
  }

  if (smooth > 0 && !is.null(smooth)) {
    centerline = .smooth_centerline(centerline, smooth = smooth)
  }

  centerline = terra::crop(centerline, x)

  line_len = terra::perim(centerline)
  centerline$length = line_len
  centerline$sinuosity = .sinuosity(centerline, line_len)

  return(centerline)

}

.smooth_centerline = function(centerline, smooth = 0.3) {
  crds = terra::crds(centerline)
  idx = seq_len(nrow(crds))
  smooth_x = stats::smooth.spline(idx, crds[, 1L], spar = smooth)$y
  smooth_y = stats::smooth.spline(idx, crds[, 2L], spar = smooth)$y
  centerline_smooth = terra::vect(cbind(smooth_x, smooth_y),
                                  type = "lines", crs = terra::crs(centerline))
  return(centerline_smooth)
}

.sinuosity = function(x, line_len) {
  coords = terra::crds(x)
  first = coords[1L, ]
  last = coords[nrow(coords), ]
  d = stats::dist(rbind(first, last))
  d = as.vector(d)
  sinuosity = line_len / d
  return(sinuosity)
}
