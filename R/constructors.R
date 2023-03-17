new_carsimr <- function(x) {
  structure(x, class = "carsimr")
}

validate_carsimr <- function(x) {
  is.matrix(x)
}

#' Construct carsimr objects
#'
#' This function constructs carsimr objects.
#'
#' @param x A matrix to be turned into an object of type carsimr.
#'
#' @returns An object of type carsimr, essentially a matrix with a generic for
#' plot.
#'
#' @export

carsimr <- function(x) {
  check <- validate_carsimr(x)
  if (check) {
    return(new_carsimr(x))
  } else {
    stop("Function carsimr currently only has functionality for matrix inputs")
  }
}

new_carsimr_list <- function(x) {
  structure(x, class = "carsimr_list")
}

validate_carsimr_list <- function(x) {
  check1 <- is.list(x)
  classes_in_list <- lapply(x, class)
  check2 <- all(classes_in_list == "carsimr")
  return(check1 & check2)
}

#' Construct carsimr_list objects
#'
#' This function constructs carsimr_list objects.
#'
#' @param x A list to be turned into an object of type carsimr_list.
#'
#' @returns An object of type carsimr_list, essentially a list of matrices with
#' a generic for plot.
#'
#' @export

carsimr_list <- function(x) {
  check <- validate_carsimr_list(x)
  if (check) {
    return(new_carsimr_list(x))
  } else {
    stop("carsimr_list currently only takes lists of carsimr objects")
  }
}
