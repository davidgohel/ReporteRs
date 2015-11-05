double min_value(double *x, int size){
  double min = x[0];

  for (int i = 0; i < size; i++) {
    if (x[i] < min)
      min = x[i];
  }
  return min;
}

double max_value(double *x, int size){
  double max = x[0];
  for (int i = 0; i < size; i++) {
    if (x[i] > max)
      max = x[i];
  }
  return max;
}

double min_value_(double x0, double x1 ){
  if (x0 >= x1) {
    return x1;
  }
  return x0;
}

double max_value_(double x0, double x1 ){
  if (x0 >= x1) {
    return x0;
  }
  return x1;
}

double p2e_(double x) {
  double y = x * 12700;
  return y;
}
