centerpoints = function(x, interval) {

  if (interval < 0) {
    stop("`interval` must be greater than zero.")
  }

  coords = terra::crds(x)
  d_seg = sqrt(diff(coords[, 1L])^2 + diff(coords[, 2L])^2)
  d_total = c(0, cumsum(d_seg))
  last = d_total[length(d_total)]
  at = seq(0, last, by = interval)

  pts = cbind(
    x = stats::approx(d_total, coords[, 1L], xout = at)$y,
    y = stats::approx(d_total, coords[, 2L], xout = at)$y
  )

  pts = pts[-1, ] # skip first point which is on the border
  pts = terra::vect(pts, type = "points", crs = terra::crs(x))
  pts$ID = seq_len(nrow(pts))

  return(pts)

}
