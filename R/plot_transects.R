plot_transects = function(x, index = NULL, fixed_elev = TRUE,
                          save_dir = NULL, ...) {

  if (!is.data.frame(x) || ncol(x) < 4L) {
    stop("`x` must be a data frame with at least four columns: ID, x, y, and elevation.")
  }

  if (!is.null(save_dir)) {
    if (!dir.exists(save_dir)) {
      dir.create(save_dir)
    }
  }

  if (is.null(index)) {
    lines = unique(x[[1L]])
    idx = seq_len(nrow(x))
  } else {
    lines = index
    idx = which(x[[1L]] %in% index)

    if (length(idx) == 0L) {
      stop("None of the provided transect IDs occur in `x`.")
    }

  }

  if (isTRUE(fixed_elev)) {
    elev_max = ceiling(max(x[idx, 4], na.rm = TRUE))
    elev_min = floor(min(x[idx, 4], na.rm = TRUE))
    ylim = c(elev_min, elev_max)
  } else {
    ylim = NULL
  }

  for (i in lines) {
    sel = which(x[[1L]] == i)

    len = length(sel)
    first = x[sel, ][1L, 2:3]
    last = x[sel, ][len, 2:3]

    d = dist(rbind(first, last))
    d = as.vector(d)
    x_labels = seq(0, d, length.out = len)

    draw_plot = function() {
      plot(x_labels, x[sel, 4L], type = "l", ylim = ylim,
           ylab = "Elevation [m]", xlab = "Distance [m]",
           main = paste("Transect", i))
    }

    if (is.null(save_dir)) {
      draw_plot()
    } else {
      filename = paste0("transect_", i, ".png")
      file = file.path(save_dir, filename)
      grDevices::png(filename = file, ...)
      draw_plot()
      grDevices::dev.off()
    }
  }

  invisible(NULL)
}
