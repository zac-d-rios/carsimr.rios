test_that("test data behaves as expected", {
  # This is not very general, it may be worth updating
  test_data <- readRDS(testthat::test_path("data/test_carsimr_data.RDS"))
  fix_test_data <- function(x) {
    for (i in seq_along(x)) {
      for (q in seq_along(x[[i]])) {
        mid <- matrix(unlist(x[[i]][q]), ncol = 4)
        swap_1 <- which(mid == 1)
        swap_2 <- which(mid == 2)
        mid[swap_1] <- 2
        mid[swap_2] <- 1
        x[[i]][[q]] <- carsimr(mid)
      }
    }
    return(x)
  }

  test_data <- fix_test_data(test_data)
  test_1 <- carsimr(test_data[[1]][[1]]) # pull out initial grid
  test_1 <- move_cars_cpp(test_1, 2) # move initial grid twice

  # checks that all grid states are the same
  expect_equal(test_1, carsimr_list(test_data[[1]]))

  test_2 <- carsimr(test_data[[2]][[1]])
  test_2 <- move_cars_cpp(test_2, 2)

  # checks that all grid states are the same
  expect_equal(test_2, carsimr_list(test_data[[2]]))

  test_3 <- carsimr(test_data[[3]][[1]])
  test_3 <- move_cars_cpp(test_3, 2)

  # checks that all grid states are the same
  expect_equal(test_3, carsimr_list(test_data[[3]]))

  test_4 <- carsimr(test_data[[4]][[1]])
  test_4 <- move_cars_cpp(test_4, 2)

  # checks that all grid states are the same
  expect_equal(test_4, carsimr_list(test_data[[4]]))
})

test_that("cars stay on the grid", {
  grid_check_move <- initialize_grid_cpp(
    rho = 0.5,
    dims = c(9, 10),
    prob_blue = 0.5
  )
  starting_cars <- c(sum(grid_check_move == 2), sum(grid_check_move == 1))

  post_move <- move_cars_cpp(grid_check_move, 12)
  post_move <- post_move[[13]]
  ending_cars <- c(sum(post_move == 2), sum(post_move == 1))

  expect_equal(starting_cars, ending_cars)
})
