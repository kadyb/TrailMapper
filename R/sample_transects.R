sample_transects = function(x, y, interval, keep = 1, spar = 0.3,
                            rm.intersections = TRUE, transect.length = NULL) {

  if (!inherits(x, "SpatRaster")) {
    stop("`x` must be a SpatRaster.")
  }

  if (!inherits(y, "SpatVector")) {
    stop("`y` must be a SpatVector.")
  }

  if (interval < 0) {
    stop("`interval` must be greater than zero.")
  }

  if (terra::is.lines(y)) {
    y = terra::as.polygons(y)
  }

  centerline = centerline::cnt_path_guess(y, keep = keep)

  if (spar > 0 && !is.null(spar)) {
    centerline = .smooth_centerline(centerline, spar = spar)
  }

  npts = floor(terra::perim(centerline) / interval)
  pts = terra::spatSample(centerline, size = npts, method = "regular")
  transects = .perp_lines(pts, y, transect.length = transect.length)

  if (rm.intersections) {
    transects = .remove_intersections(transects)
  }

  pts_extract = terra::extract(x, pts, xy = TRUE)
  transect_extract = terra::extractAlong(x, transects, xy = TRUE)

  output = list(
    centerline = centerline,
    central_points = pts_extract,
    transects = transect_extract
  )
  return(output)

}

.smooth_centerline = function(centerline, spar = 0.3) {
  crds = terra::crds(centerline)
  idx = seq_len(nrow(crds))
  smooth_x = stats::smooth.spline(idx, crds[, 1L], spar = spar)$y
  smooth_y = stats::smooth.spline(idx, crds[, 2L], spar = spar)$y
  centerline_smooth = terra::vect(cbind(smooth_x, smooth_y),
                                  type = "lines", crs = terra::crs(centerline))
  return(centerline_smooth)
}

.perp_lines = function(pts, polygon, transect.length = NULL) {

  x = terra::crds(pts)[, 1L]
  y = terra::crds(pts)[, 2L]
  n = nrow(pts)
  lines_list = vector("list", n)

  if (is.null(transect.length)) {
    e = terra::ext(polygon)
    transect.length = sqrt((e[2L] - e[1L])^2 + (e[4L] - e[3L])^2)
    transect.length = unname(transect.length * 0.5)
  }

  for (i in seq_len(n)) {
    if (i == 1L) {
      angle = atan2(y[i + 1L] - y[i], x[i + 1L] - x[i])
    } else if (i == n) {
      angle = atan2(y[i] - y[i - 1L], x[i] - x[i - 1L])
    } else {
      angle = atan2(y[i + 1L] - y[i - 1L], x[i + 1L] - x[i - 1L])
    }

    perp_angle = angle + pi/2

    dx = cos(perp_angle) * (transect.length / 2)
    dy = sin(perp_angle) * (transect.length / 2)

    p1 = c(x[i] + dx, y[i] + dy)
    p2 = c(x[i] - dx, y[i] - dy)

    lines_list[[i]] = matrix(c(p1, p2), ncol = 2L, byrow = TRUE)
  }

  perp_lines = terra::vect(lines_list, type = "lines", crs = terra::crs(pts))
  perp_lines = terra::crop(perp_lines, polygon)

  return(perp_lines)
}

.remove_intersections = function(x) {
  lines_clean = x

  while (TRUE) {
    rel = terra::relate(lines_clean, relation = "intersects")
    n = rowSums(rel)
    if (all(n == 1L)) break
    counts = n - 1L
    idx = which.max(counts)
    lines_clean = lines_clean[-idx]
  }

  return(lines_clean)
}
