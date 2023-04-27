#' Plot a carsimr object
#'
#' This function allows users to plot an object of class carsimr, where the
#'  blue cars are represented by blue tiles on a matrix, and the red cars are
#'  represented by red tiles on a matrix.
#'
#' @param x An object of class carsimr.
#'
#' @param y Required to create plot generic, not used.
#' @param ... Additional parameters to be passed into the plot function.
#'
#' @returns Plots the state of the grid.
#'
#' @importFrom graphics image
#' @importFrom graphics grid
#'
#' @export

plot.carsimr <- function(x, y, ...) {
  # Remove class attribute from carsimr object.
  attr(x, "class") <- NULL
  rowx <- nrow(x)
  # Use image function with set aspect ratio.
  image(seq_len(ncol(x)), seq_len(nrow(x)), t(x[rowx:1, ]),
    col = c("gray", "red", "blue"),
    axes = FALSE, xlab = "", ylab = "", breaks = -1:2, asp = 1, ...
  )
}


#' Sequential plots of carsimr objects
#'
#' This function allows users to plot an object of class carsimr_list, which
#'  successively plots carsimr objects
#'
#' @param x An object of class carsimr_list.
#'
#' @param y Required to create plot generic, not used.
#' @param pause Length of time (in seconds) in between plotting objects of
#'  carsimr.
#' @param ... Additional parameters to be passed into plot.
#'
#' @returns A series of plots representing the movement of cars along the grid
#'  for iterations of time.
#'
#' @export

plot.carsimr_list <- function(x, y, pause = 1, ...) {
  # Plot carsimr objects sequentially
  for (i in seq_along(x)) {
    plot(x[[i]], main = paste("Iteration", i - 1, sep = " "))
    Sys.sleep(pause)
  }
  return("Simulation Complete")
}
