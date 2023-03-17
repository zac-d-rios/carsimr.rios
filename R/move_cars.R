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

#' Moving cars
#'
#' This function moves the cars in the grid created by the initialize_grid
#'  function.
#'
#' @param t_grid An object of class carsimr.
#'
#' @param trials The number of moves that the cars will make, blue cars move on
#'  odd time periods, red cars move on even time periods.
#'
#' @returns An object of class carsimr_list, which contains the initial_grid
#'  along with along with each of the "trial" movements.
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
