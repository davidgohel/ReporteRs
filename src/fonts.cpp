#include "Rcpp.h"

bool is_bold(int face) {
  return face == 2 || face == 4;
}
bool is_italic(int face) {
  return face == 3 || face == 4;
}

std::string fontname(const char* family_, int face,
                            std::string serif_, std::string sans_, std::string mono_, std::string symbol_) {

  std::string family(family_);

  if( face == 5 ) return symbol_;

  if (family == "mono") {
    return mono_;
  } else if (family == "serif") {
    return serif_;
  } else if (family == "sans" || family == "") {
    return sans_;
  } else {
    return sans_;
  }
}
