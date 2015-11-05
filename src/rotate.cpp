#include <math.h>

double translate_rotate_x(double x, double y, double rot, double h, double w, double hadj) {
  double pi = 3.141592653589793115997963468544185161590576171875;
  double alpha = -rot * pi / 180;

  double Px = x + (0.5-hadj) * w;
  double Py = y - 0.5 * h;

  double _cos = cos( alpha );
  double _sin = sin( alpha );

  double Ppx = x + (Px-x) * _cos - (Py-y) * _sin ;

  return Ppx - 0.5 * w;
}


double translate_rotate_y(double x, double y, double rot, double h, double w, double hadj) {
  double pi = 3.141592653589793115997963468544185161590576171875;
  double alpha = -rot * pi / 180;

  double Px = x + (0.5-hadj) * w;
  double Py = y - 0.5 * h;

  double _cos = cos( alpha );
  double _sin = sin( alpha );

  double Ppy = y + (Px-x) * _sin + (Py-y) * _cos;

  return Ppy - 0.5 * h;
}
