#' Initializing the grid
#'
#' This function initializes a matrix, representing a grid of cars.
#'
#' @param rho Either a proportion from 0 to 1 of the grid to be occupied by
#'  cars, or an integer value specifying the number of cars on the grid.
#'
#' @param dims A numeric vector of length 2 specifying the number of
#'  (rows, columns) of the grid.
#' @param prob_blue Probability that a given car is blue.
#'
#' @returns An object of class carsimr, essentially a matrix with a generic for
#'  plot.
#' @export

initialize_grid <- function(rho, dims, prob_blue) {
  total <- dims[1] * dims[2]
  if (rho < 1) {
    temp <- round(total * rho)
    car <- rep(1, temp)
    no_car <- rep(0, total - temp)
    blue <- round(length(car) * prob_blue)
    if (blue != 0) {
      car <- c(car[1:blue] + 1, car)
      car <- car[1:temp]
    }
    x <- sample(c(car, no_car), total, replace = FALSE)
    grid_init <- matrix(x, nrow = dims[1], ncol = dims[2])
    grid_init <- carsimr(grid_init)
    return(grid_init)
  }
  if (rho >= 1) {
    rho <- round(rho)
    car <- rep(1, rho)
    no_car <- rep(0, total - rho)
    blue <- round(length(car) * prob_blue)
    if (blue != 0) {
      car <- c(car[1:blue] + 1, car)
      car <- car[1:rho]
    }
    x <- sample(c(car, no_car), total, replace = FALSE)
    grid_init <- matrix(x, nrow = dims[1], ncol = dims[2])
    grid_init <- carsimr(grid_init)
    return(grid_init)
  }
}
