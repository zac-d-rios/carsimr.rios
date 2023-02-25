new_carsimr <- function(x) {
  structure(x, class = "carsimr")
}

validate_carsimr <- function(x) {
  is.matrix(x)
}

#' @export

carsimr <- function(x) {
  check <- validate_carsimr(x)
  if (check) {
    return(new_carsimr(x))
  }
}

new_carsimr_list <- function(x) {
  structure(x, class = "carsimr_list")
}

validate_carsimr_list <- function(x) {
  is.list(x)
}

#' @export

carsimr_list <- function(x) {
  check <- validate_carsimr_list(x)
  if (check) {
    return(new_carsimr_list(x))
  }
}
