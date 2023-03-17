test_that("errors display correctly in constructors", {
  incorrect_object <- "hello"
  incorrect_list <- list("hello", "goodbye")

  # proper error message when inputting invalid object into carsimr
  expect_error(carsimr(incorrect_object), regexp = "matrix inputs")

  # proper error message when inputting non-lists into carsimr_list
  expect_error(carsimr_list(incorrect_object), regexp = "lists of carsimr")

  # proper error message when inputting lists with incorrect objects
  expect_error(carsimr_list(incorrect_list), regexp = "lists of carsimr")
})
