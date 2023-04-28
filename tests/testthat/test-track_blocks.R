test_that("car blocks work", {
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

  # Fill in the block information manually from the test data.
  block_list <- data.frame(
    blue = c(0, 0.5, 1, 0.5),
    red = c(0, 0.5, 0.5, 1)
  )

  # Helper function to check equality for a list of matrices.
  move_check <- function(tester, target_blue, target_red) {
    tester_c <- carsimr_list(tester)
    tester_move <- move_cars(tester_c[[1]], trials = 2)
    tester_block <- track_blocks(tester_move)
    expect_equal(tester_block[[1]], target_blue)
    expect_equal(tester_block[[2]], target_red)
  }

  for (i in 1:4) {
    move_check(test_data[[i]], block_list$blue[i], block_list$red[i])
  }
})
