
<!-- README.md is generated from README.Rmd. Please edit that file -->

# carsimr.rios

<!-- badges: start -->

[![R-CMD-check](https://github.com/zac-d-rios/carsimr.rios/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/zac-d-rios/carsimr.rios/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

The goal of carsimr.rios is to simulate car movements for various
different car densities, while also allowing the user to visualize these
movements.

## Installation

You could install the development version of carsimr.rios, if it were
public, from [GitHub](https://github.com/zac-d-rios/carsimr.rios) with:

``` r
# install.packages("devtools")
devtools::install_github("zac-d-rios/carsimr.rios")
```

## Example

This is an example of how to initialize a grid, first with a proportion
and then with an integer number of cars

``` r
library(carsimr.rios)
example1 <- initialize_grid(0.5, c(5, 3), 0.7)

example2 <- initialize_grid(8, c(5, 3), 0.5)

example1
#>      [,1] [,2] [,3]
#> [1,]    0    2    1
#> [2,]    0    0    2
#> [3,]    0    0    2
#> [4,]    2    1    0
#> [5,]    2    2    0
#> attr(,"class")
#> [1] "carsimr"
```

``` r
example2
#>      [,1] [,2] [,3]
#> [1,]    1    0    2
#> [2,]    2    0    1
#> [3,]    1    2    0
#> [4,]    1    0    2
#> [5,]    0    0    0
#> attr(,"class")
#> [1] "carsimr"
```

Notice how they both have the same number of cars, but with a different
proportion of blue cars (represented by 2). Specifically, example1 has
about 70% blue cars, while example2 has about 50%.

For moving the cars, use the move cars function, which takes a carsimr
object and number of iterations to move.

``` r
move_cars(example2, 2)
#> [[1]]
#>      [,1] [,2] [,3]
#> [1,]    1    0    2
#> [2,]    2    0    1
#> [3,]    1    2    0
#> [4,]    1    0    2
#> [5,]    0    0    0
#> attr(,"class")
#> [1] "carsimr"
#> 
#> [[2]]
#>      [,1] [,2] [,3]
#> [1,]    1    0    0
#> [2,]    2    2    1
#> [3,]    1    0    2
#> [4,]    1    0    0
#> [5,]    0    0    2
#> attr(,"class")
#> [1] "carsimr"
#> 
#> [[3]]
#>      [,1] [,2] [,3]
#> [1,]    0    1    0
#> [2,]    2    2    1
#> [3,]    0    1    2
#> [4,]    0    1    0
#> [5,]    0    0    2
#> attr(,"class")
#> [1] "carsimr"
#> 
#> attr(,"class")
#> [1] "carsimr_list"
```

Notice how blue cars (2’s) moved upwards during the first move, and red
cars moved rightwards during the second move.

Shown below is an example of plotting the movements of cars through
various iterations

``` r
plot(move_cars(initialize_grid(rho = 0.3, c(5, 5), p = 0.5), trials = 5))
#> [1] "Simulation Complete"
```

<img src="man/figures/README-at_once,figures-side-1.png" width="33.33%" /><img src="man/figures/README-at_once,figures-side-2.png" width="33.33%" /><img src="man/figures/README-at_once,figures-side-3.png" width="33.33%" /><img src="man/figures/README-at_once,figures-side-4.png" width="33.33%" /><img src="man/figures/README-at_once,figures-side-5.png" width="33.33%" /><img src="man/figures/README-at_once,figures-side-6.png" width="33.33%" />
