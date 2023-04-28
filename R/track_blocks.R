#' Track blocked cars
#'
#' This function finds the proportion of blocked cars at each time iteration
#'  for a carsimr_list objects.
#'
#' @param carsimr_list An object of type carsimr_list
#'
#' @return A list of length 2, where the first element is a vector of block
#'  proportions for BLUE cars on blue moves, and the second element is a vector
#'  of block proportions for RED cars on red moves
#'
#' @export
track_blocks <- function(carsimr_list) {
  # Set up constants based on carsimr_list
  moves <- length(carsimr_list)
  prop_blue <- vector(mode = "numeric", length = floor(moves / 2))
  prop_red <- vector(mode = "numeric", length = floor((moves - 1) / 2))
  blue_cars <- sum(carsimr_list[[1]] == 2)
  red_cars <- sum(carsimr_list[[1]] == 1)

  # Loop through the list and check proportions of blocked cars
  for (i in (seq_along(carsimr_list)[-1] - 1)) {
    if (i %% 2 == 1) {
      block <- length(intersect(
        which(carsimr_list[[i]] == 2),
        which(carsimr_list[[i + 1]] == 2)
      ))
      prop_block <- block / blue_cars
      prop_blue[ceiling(i / 2)] <- prop_block
    }
    if (i %% 2 == 0) {
      block <- length(intersect(
        which(carsimr_list[[i]] == 1),
        which(carsimr_list[[i + 1]] == 1)
      ))
      prop_block <- block / red_cars
      prop_red[floor(i / 2)] <- prop_block
    }
  }

  # Return as a list
  return(list(prop_blue, prop_red))
}
