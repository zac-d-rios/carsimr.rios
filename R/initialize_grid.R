initialize_grid <- function(rho, dims, prob_blue) {
  total <- dims[1] * dims[2]
  if (rho < 1) {
    temp <- round(total * rho)
    car <- rep(1, temp)
    no_car <- rep(0, total - temp)
    blue <- round(length(car) * prob_blue)
    car <- c(car[1:blue] + 1, car[(blue + 1):length(car)])
    x <- sample(c(car, no_car), total, replace = FALSE)
    grid_init <- matrix(x, nrow = dims[1], ncol = dims[2])
    return(grid_init)
  }
  if (rho >= 1) {
    car <- rep(1, rho)
    no_car <- rep(0, total - rho)
    blue <- round(length(car) * prob_blue)
    car <- c(car[1:blue] + 1, car[(blue + 1):length(car)])
    x <- sample(c(car, no_car), total, replace = FALSE)
    grid_init <- matrix(x, nrow = dims[1], ncol = dims[2])
    return(grid_init)
  }
}
