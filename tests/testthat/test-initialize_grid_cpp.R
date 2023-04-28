test_that("color probabilities work as expected", {
  grid_no_red <- initialize_grid_cpp(rho = 0.5, dims = c(10, 10), prob_blue = 1)
  expect_true(!any(grid_no_red == 1)) # check for no red cars

  grid_no_blue <- initialize_grid_cpp(
    rho = 0.5,
    dims = c(10, 10),
    prob_blue = 0
  )
  expect_true(!any(grid_no_blue == 2)) # check for no blue cars
})

test_that("car spawns work as expected", {
  grid_no_cars <- initialize_grid_cpp(
    rho = 0,
    dims = c(10, 10),
    prob_blue = 0.5
  )
  expect_true(all(grid_no_cars == 0)) # check for no cars


  grid_no_blanks <- initialize_grid_cpp(
    rho = 0.999,
    dims = c(10, 10),
    prob_blue = 0.5
  )
  expect_true(!any(grid_no_blanks == 0)) # check for all cars
})

test_that("rho values round correctly", {
  rho_test <- runif(1, min = 1, max = 100) # random non-integer from 1 to 100

  grid_rho_cars <- initialize_grid_cpp(
    rho = rho_test,
    dims = c(10, 10),
    prob_blue = 0.5
  )

  # number of cars on the grid is the same as the rounded random number
  expect_equal(sum(!(grid_rho_cars == 0)), round(rho_test))
})
