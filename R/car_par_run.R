#' Parallelize many simulations
#'
#' This function allows users to simulate car movements on many different grids
#'  at the same time. The user can specify a number of cores greater than 1 if
#'  they would like to parallelize this process.
#'
#' @param rho Either a proportion from 0 to 1 of the grid to be occupied by
#'  cars, or an integer value specifying the number of cars on the grid.
#' @param dims A numeric vector of length 2 specifying the number of
#'  (rows, columns) of the grid.
#' @param prob_blue Probability that a given car is blue.
#' @param trials The number of moves that the cars will make, blue cars move on
#'  odd time periods, red cars move on even time periods.
#' @param replicates The number of different simulations.
#' @param cores The number of cores this process will be run on.
#'
#' @return A list of "carsimr_list" objects.
#'
#' @import parallel
#'
#' @export
car_par_run <- function(rho, dims, prob_blue, trials, replicates, cores = 1) {
  if (cores == 1) {
    carsimr_lists <- vector(mode = "list", length = replicates)
    for (i in 1:replicates) {
      carsimr_lists[[i]] <- move_cars_cpp(
        initialize_grid_cpp(
          rho,
          dims,
          prob_blue
        ),
        trials
      )
    }
  } else {
    # Initialize cluster based on user-provided cores.
    cl <- parallel::makeCluster(cores)

    # Export the variables to the nodes
    parallel::clusterExport(cl, c(
      "rho", "dims", "prob_blue", "trials",
      "replicates"
    ),
    envir = environment()
    )

    # Create initial grids in parallel, and then move them in parallel
    carsimr_lists <- parallel::parLapply(cl,
      parLapply(cl, rep(rho, replicates),
        initialize_grid,
        dims = dims,
        prob_blue = prob_blue
      ),
      move_cars,
      trials = trials
    )

    on.exit(parallel::stopCluster(cl = cl))
  }
  return(carsimr_lists)
}
