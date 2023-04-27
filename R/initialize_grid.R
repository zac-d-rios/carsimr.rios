#' Initializing the grid
#'
#' This function initializes a matrix, representing a grid of cars. Now comes
#' with an Rcpp version!
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
#'
#' @examples
#' # Proportion rho
#' initialize_grid(rho = 0.5, dims = c(3, 5), prob_blue = 0.5)
#'
#' # Integer rho
#' initialize_grid(rho = 8, dims = c(3, 5), prob_blue = 0.5)
#'
#' @export

initialize_grid <- function(rho, dims, prob_blue) {
  if (!is.numeric(rho)) {
    stop("Invalid input for rho, must be numeric")
  }
  if (rho >= 1 && rho %% 1 != 0) {
    warning("Rho is not an integer and is greater than 1, rounding to integer")
  }
  if (!is.numeric(prob_blue)) {
    stop("prob_blue must be numeric")
  }
  if (prob_blue < 0 || prob_blue > 1) {
    stop("Probability that a car should be blue cannot be greater than 1 or
         less than 0")
  }
  if (!is.numeric(dims)) {
    stop("dims must be a numeric vector of length 2")
  }
  if (length(dims) != 2) {
    stop("dims must be a numeric vector of length 2")
  }

  # Get length of vector required to create matrix
  total <- dims[1] * dims[2]

  # Logic for when rho is a proportion
  if (rho < 1) {
    # Create car vector based on proportion, also make vector with no cars
    temp <- round(total * rho)
    car <- rep(1, temp)
    no_car <- rep(0, total - temp)

    # Creates blue cars by adding 1
    blue <- round(length(car) * prob_blue)

    # Logic for edge case that does not work with indexing
    if (blue != 0) {
      car <- c(car[1:blue] + 1, car)
      car <- car[1:temp]
    }

    # Sample all from both vectors and construct matrix
    x <- sample(c(car, no_car), total, replace = FALSE)
    grid_init <- matrix(x, nrow = dims[1], ncol = dims[2])
    grid_init <- carsimr(grid_init)
    return(grid_init)
  }
  if (rho >= 1) {
    # Create car vector based on integer rho, also make vector with no cars
    rho <- round(rho)
    car <- rep(1, rho)
    no_car <- rep(0, total - rho)

    # Creates blue cars by adding 1
    blue <- round(length(car) * prob_blue)

    # Logic for edge case that does not work with indexing
    if (blue != 0) {
      car <- c(car[1:blue] + 1, car)
      car <- car[1:rho]
    }

    # Sample all from both vectors and construct matrix
    x <- sample(c(car, no_car), total, replace = FALSE)
    grid_init <- matrix(x, nrow = dims[1], ncol = dims[2])
    grid_init <- carsimr(grid_init)
    return(grid_init)
  }
}
