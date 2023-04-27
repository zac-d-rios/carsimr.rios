#' Move blue cars on a carsimr object.
#'
#' @param x A grid where the blue cars will be moved
#' @noRd
move_blue <- function(t_grid) {
  # Find all blue cars
  starting <- which(t_grid == 2, arr.ind = TRUE)

  # Find all next moves
  next_move <- starting
  next_move[, 1] <- next_move[, 1] - 1
  next_move[, 1][next_move[, 1] == 0] <- nrow(t_grid)

  # Figure out which cars can move
  can_move <- t_grid[next_move] == 0

  # Move the cars that are unimpeded
  t_grid[matrix(next_move[can_move, ], ncol = 2)] <- 2
  t_grid[matrix(starting[can_move, ], ncol = 2)] <- 0
  return(t_grid)
}

#' Move red cars on a carsimr object.
#'
#' @param x A grid where the red cars will be moved
#' @noRd
move_red <- function(t_grid) {
  # Find all red cars
  starting <- which(t_grid == 1, arr.ind = TRUE)

  # Find all next moves
  next_move <- starting
  next_move[, 2] <- next_move[, 2] + 1
  next_move[, 2][next_move[, 2] > ncol(t_grid)] <- 1

  # Figure out which cars can move
  can_move <- t_grid[next_move] == 0

  # Move the cars that are unimpeded
  t_grid[matrix(next_move[can_move, ], ncol = 2)] <- 1
  t_grid[matrix(starting[can_move, ], ncol = 2)] <- 0
  return(t_grid)
}

#' Moving cars
#'
#' This function moves the cars in the grid created by the initialize_grid
#'  function. Now comes with an Rcpp version!
#'
#' @param t_grid An object of class carsimr.
#'
#' @param trials The number of moves that the cars will make, blue cars move on
#'  odd time periods, red cars move on even time periods.
#'
#' @returns An object of class carsimr_list, which contains the initial_grid
#'  along with along with each of the "trial" movements.
#'
#' @examples
#' t_grid <- initialize_grid(rho = 10, dims = c(5, 5), prob_blue = 0.5)
#' move_cars(t_grid, trials = 5)
#'
#' @export

move_cars <- function(t_grid, trials) {
  if (!is.matrix(t_grid)) {
    stop("Move cars takes carsimr objects as input.")
  }
  if (attr(t_grid, "class") != "carsimr") {
    warning("Input was not a carsimr object, attempting to coerce.")
    t_grid <- carsimr(t_grid)
  }
  # Initialize empty list
  carsimr_list_temp <- vector(mode = "list", length = trials + 1)

  # Store initial grid
  carsimr_list_temp[[1]] <- t_grid

  # Move blue cars on odd iterations and red cars on even iterations (and store)
  for (i in 1:trials) {
    if (i %% 2 == 1) {
      temp <- move_blue(carsimr_list_temp[[i]])
    }
    if (i %% 2 == 0) {
      temp <- move_red(carsimr_list_temp[[i]])
    }
    carsimr_list_temp[[i + 1]] <- temp
  }

  # Return carsimr_list object
  obj <- carsimr_list(carsimr_list_temp)
  return(obj)
}
