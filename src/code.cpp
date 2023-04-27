#include <Rcpp.h>
using namespace Rcpp;

// [[Rcpp::export]]
int randWrapper(const int n){
  return floor(unif_rand()*n);
}

// [[Rcpp::export]]
Rcpp::IntegerVector random_shuffle_cpp(Rcpp::IntegerVector a) {
  // clone a into b to leave a alone
  Rcpp::IntegerVector b = Rcpp::clone(a);
  int n = b.size();
  int j;
  // Fisher-Yates Shuffle Algorithm
  for (int i = 0; i < n - 1; i++) {
    j = i + randWrapper(n - i);
    std::swap(b[i], b[j]);
  }
  return b;
}

//' @rdname initialize_grid
//' @export
// [[Rcpp::export]]
IntegerMatrix initialize_grid_cpp(float rho, IntegerVector dims, float prob_blue){
  int num_cars;

  if (rho >= 1){
    num_cars = int(round(rho));
  }
  else {
    num_cars = int(round(dims[0]*dims[1]*rho));
  }

  IntegerVector cars(dims[0]*dims[1]);

  for (int i=0; i < num_cars; i++){
    cars[i] = (unif_rand() > (1 - prob_blue)) + 1;
  }
  cars = random_shuffle_cpp(cars);

  cars.attr("dim") = Dimension(dims[0], dims[1]);
  IntegerMatrix grid = as<IntegerMatrix>(cars);

  grid.attr("class") = "carsimr";

  return(grid);

}


 // [[Rcpp::export]]
 IntegerMatrix move_blue_cpp(IntegerMatrix t_grid) {
   IntegerMatrix grid = clone(t_grid);
   IntegerMatrix moved = clone(t_grid);
   int nrow = grid.nrow();
   int ncol = grid.ncol();

   for (int j = 0; j < nrow; ++j) {
     for (int i = 0; i < ncol; ++i) {
       if (grid(j, i) == 2) { // Check if the cell contains a blue car
         int next_j = j - 1; // Calculate next row index
         if (next_j == -1) {
           next_j = nrow - 1;
         }
         if (grid(next_j, i) == 0) { // Check if the next cell is empty
           moved(next_j, i) = 2; // Mark the blue car to be moved to the next cell
           moved(j, i) = 0; // Mark the current cell to be emptied
         } else {
           moved(j, i) = grid(j, i); // Keep the car in the current cell if it can't move
         }
       }
     }
   }

   return(moved);
 }


// [[Rcpp::export]]
IntegerMatrix move_red_cpp(IntegerMatrix t_grid) {
  IntegerMatrix grid = clone(t_grid);
  IntegerMatrix moved = clone(t_grid);
  int nrow = grid.nrow();
  int ncol = grid.ncol();

  for (int j = 0; j < nrow; ++j) {
    for (int i = 0; i < ncol; ++i) {
      if (grid(j, i) == 1) { // Check if the cell contains a red car
        int next_i = i + 1; // Calculate next column index
        if (next_i == ncol) {
          next_i = 0;
        }
        if (grid(j, next_i) == 0) { // Check if the next cell is empty
          moved(j, next_i) = 1; // Mark the red car to be moved to the next cell
          moved(j, i) = 0; // Mark the current cell to be emptied
        } else {
          moved(j, i) = grid(j, i); // Keep the car in the current cell if it can't move
        }
      }
    }
  }

  return moved;
}

//' @rdname move_cars
//' @export
 // [[Rcpp::export]]
 List move_cars_cpp(IntegerMatrix t_grid, int trials) {
   List grids(trials + 1);
   t_grid.attr("class") = "carsimr";
   grids[0] = t_grid;

   for (int t = 0; t < trials; ++t) {
     IntegerMatrix current_grid = grids[t];
     if (t % 2 == 0) {
       grids[t + 1] = move_blue_cpp(current_grid);
     } else {
       grids[t + 1] = move_red_cpp(current_grid);
     }
   }

   grids.attr("class") = "carsimr_list";
   return grids;
 }


