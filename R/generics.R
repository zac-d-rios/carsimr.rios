#' @importFrom graphics image
#' @importFrom graphics grid
#' @export

plot.carsimr <- function(x, y, ...) {
  attr(x, "class") <- NULL
  image(seq_len(ncol(x)), seq_len(nrow(x)), t(x[nrow(x):1, ]),
    col = c("gray", "red", "blue"),
    axes = FALSE, xlab = "", ylab = "", breaks = -1:2, ...
  )
  grid(ncol(x), nrow(x), lty = "solid", col = "black")
}

#' @export

plot.carsimr_list <- function(x, y, pause = 1, ...) {
  for (i in seq_along(x)) {
    plot(x[[i]], main = paste("Iteration", i - 1, sep = " "))
    Sys.sleep(pause)
  }
  return("Simulation Complete")
}
