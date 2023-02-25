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

move_blue <- function(t_grid) {
  starting <- which(t_grid == 2, arr.ind = TRUE)
  next_move <- starting
  next_move[, 1] <- next_move[, 1] - 1
  next_move[, 1][next_move[, 1] == 0] <- nrow(t_grid)
  can_move <- t_grid[next_move] == 0
  t_grid[matrix(next_move[can_move, ], ncol = 2)] <- 2
  t_grid[matrix(starting[can_move, ], ncol = 2)] <- 0
  return(t_grid)
}


move_red <- function(t_grid) {
  starting <- which(t_grid == 1, arr.ind = TRUE)
  next_move <- starting
  next_move[, 2] <- next_move[, 2] + 1
  next_move[, 2][next_move[, 2] > ncol(t_grid)] <- 1
  can_move <- t_grid[next_move] == 0
  t_grid[matrix(next_move[can_move, ], ncol = 2)] <- 1
  t_grid[matrix(starting[can_move, ], ncol = 2)] <- 0
  return(t_grid)
}

#' @export

move_cars <- function(t_grid, trials) {
  carsimr_list_temp <- vector(mode = "list", length = trials + 1)
  carsimr_list_temp[[1]] <- t_grid
  for (i in 1:trials) {
    if (i %% 2 == 1) {
      temp <- move_blue(carsimr_list_temp[[i]])
    }
    if (i %% 2 == 0) {
      temp <- move_red(carsimr_list_temp[[i]])
    }
    carsimr_list_temp[[i + 1]] <- temp
  }
  obj <- carsimr_list(carsimr_list_temp)
  return(obj)
}
