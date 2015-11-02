/*
 * This file is part of PPTX.
 * Copyright (c) 2014, David Gohel All rights reserved.
 *
 * PPTX is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * PPTX is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with PPTX.  If not, see <http://www.gnu.org/licenses/>.
**/

#include "Rcpp.h"
#include <gdtools.h>
#include <string.h>
#include <math.h>
#include "R_ext/GraphicsEngine.h"

// SVG device metadata
class PPTXdesc {
public:
  FILE *file;
  std::string filename;
  int pageno;
  int id;
  double clipleft, clipright, cliptop, clipbottom;
  double offx;
  double offy;
  std::string fontname_serif;
  std::string fontname_sans;
  std::string fontname_mono;
  std::string fontname_symbol;
  bool editable;
  XPtrCairoContext cc;

  PPTXdesc(std::string filename_,
           std::string fontname_serif_,
           std::string fontname_sans_,
           std::string fontname_mono_,
           std::string fontname_symbol_,
           bool editable_, double offx_, double offy_ ):
      filename(filename_),
      pageno(0),
	    id(-1),
	    offx(offx_), offy(offy_),
	    fontname_serif(fontname_serif_),
	    fontname_sans(fontname_sans_),
	    fontname_mono(fontname_mono_),
	    fontname_symbol(fontname_symbol_),
	    editable(editable_),
      cc(gdtools::context_create()) {

    file = fopen(R_ExpandFileName(filename.c_str()), "w");
  }

  bool ok() const {
    return file != NULL;
  }

  int new_id() {
  	id++;
  	return id;
  }

  ~PPTXdesc() {
    if (ok())
      fclose(file);
  }
};

static std::string pptx_elt_tag_start = "<p:sp>";
static std::string pptx_elt_tag_end = "</p:sp>\n";

inline bool is_bold(int face) {
  return face == 2 || face == 4;
}
inline bool is_italic(int face) {
  return face == 3 || face == 4;
}

inline std::string fontname(const char* family_, int face,
                            std::string serif_, std::string sans_,
                            std::string mono_, std::string symbol_) {
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


inline double min_value(double *x, int size){
  double min = x[0];
  Rprintf( "values : ");

  for (int i = 0; i < size; i++) {
    Rprintf( "%.3f\t", x[i]);
    if (x[i] < min)
      min = x[i];
  }
  Rprintf( "\nmin : %.3f\n", min);
  return min;
}

inline double max_value(double *x, int size){
  double max = x[0];
  Rprintf( "values : ");
  for (int i = 0; i < size; i++) {
    Rprintf( "%.3f\t", x[i]);
    if (x[i] > max)
      max = x[i];
  }
  Rprintf( "\nmax : %.3f\n", max);
  return max;
}

inline double min_value_(double x0, double x1 ){
  if (x0 >= x1) {
    return x1;
  }
  return x0;
}
inline double max_value_(double x0, double x1 ){
  if (x0 >= x1) {
    return x0;
  }
  return x1;
}

inline double p2e_(double x) {
  double y = x * 12700;
  return y;
}
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

void write_nv_pr(pDevDesc dev, R_GE_gcontext *gc, const char *label) {
  PPTXdesc *pptx_dev = (PPTXdesc *) dev->deviceSpecific;
  int idx = pptx_dev->new_id();
  const char *pptx_lock_properties = "<p:cNvSpPr><a:spLocks noSelect=\"1\" noResize=\"1\" noEditPoints=\"1\" noTextEdit=\"1\" noMove=\"1\" noRot=\"1\" noChangeShapeType=\"1\"/></p:cNvSpPr><p:nvPr/>";
  const char *pptx_unlock_properties = "<p:cNvSpPr/><p:nvPr/>";
  if( !pptx_dev->editable )
  fprintf(pptx_dev->file,
          "<p:nvSpPr><p:cNvPr id=\"%d\" name=\"%s %d\" />%s</p:nvSpPr>", idx, label, idx, pptx_lock_properties);
  else fprintf(pptx_dev->file,
             "<p:nvSpPr><p:cNvPr id=\"%d\" name=\"%s %d\" />%s</p:nvSpPr>", idx, label, idx, pptx_unlock_properties);

}

void write_xfrm(pDevDesc dev, double x, double y, double width, double height, double rot) {
  PPTXdesc *pptx_dev = (PPTXdesc *) dev->deviceSpecific;
  if( rot == 0 )
    fputs("<a:xfrm>", pptx_dev->file);
  else fprintf(pptx_dev->file, "<a:xfrm rot=\"%.0f\">", (-rot) * 60000);
  fprintf(pptx_dev->file, "<a:off x=\"%.0f\" y=\"%.0f\"/>"
            , p2e_(pptx_dev->offx + x), p2e_(pptx_dev->offy + y));
  fprintf(pptx_dev->file, "<a:ext cx=\"%.0f\" cy=\"%.0f\"/>", p2e_(width), p2e_(height));
  fputs( "</a:xfrm>", pptx_dev->file );
}


void write_fill(pDevDesc dev, R_GE_gcontext *gc) {
  PPTXdesc *pptx_dev = (PPTXdesc *) dev->deviceSpecific;
  int alpha = R_ALPHA(gc->fill);
  if (gc->fill == NA_INTEGER || alpha == 0) {
    return ;
  } else {
    double alpha_ =  alpha / 255.0 * 100000;
    fprintf(pptx_dev->file,
            "<a:solidFill><a:srgbClr val=\"%02X%02X%02X\"><a:alpha val=\"%.0f\" /></a:srgbClr></a:solidFill>",
            R_RED(gc->fill), R_GREEN(gc->fill), R_BLUE(gc->fill), alpha_);
  }

}

void write_col(pDevDesc dev, R_GE_gcontext *gc) {
  PPTXdesc *pptx_dev = (PPTXdesc *) dev->deviceSpecific;
  int alpha = R_ALPHA(gc->col);
  if (gc->col == NA_INTEGER || alpha == 0) {
    return ;
  } else {
    double alpha_ =  alpha / 255.0 * 100000;
    fprintf(pptx_dev->file,
            "<a:solidFill><a:srgbClr val=\"%02X%02X%02X\"><a:alpha val=\"%.0f\" /></a:srgbClr></a:solidFill>",
            R_RED(gc->col), R_GREEN(gc->col), R_BLUE(gc->col), alpha_);
  }

}

void write_text_body_empty(pDevDesc dev) {
  PPTXdesc *pptx_dev = (PPTXdesc *) dev->deviceSpecific;
  fputs( "<p:txBody><a:bodyPr/><a:lstStyle/><a:p/></p:txBody>", pptx_dev->file );
}
void write_sppr_opening(pDevDesc dev) {
  PPTXdesc *pptx_dev = (PPTXdesc *) dev->deviceSpecific;
  fputs( "<p:spPr>", pptx_dev->file );
}
void write_sppr_closing(pDevDesc dev) {
  PPTXdesc *pptx_dev = (PPTXdesc *) dev->deviceSpecific;
  fputs( "</p:spPr>", pptx_dev->file );
}
void write_sp_opening(pDevDesc dev) {
  PPTXdesc *pptx_dev = (PPTXdesc *) dev->deviceSpecific;
  fputs( "<p:sp>", pptx_dev->file );
}
void write_sp_closing(pDevDesc dev) {
  PPTXdesc *pptx_dev = (PPTXdesc *) dev->deviceSpecific;
  fputs( "</p:sp>", pptx_dev->file );
}

void write_preset_geom(pDevDesc dev, const char *preset_geom) {
  PPTXdesc *pptx_dev = (PPTXdesc *) dev->deviceSpecific;
  fprintf(pptx_dev->file,"<a:prstGeom prst=\"%s\"><a:avLst/></a:prstGeom>", preset_geom);

}

void write_ppr(pDevDesc dev, double hadj, double fontsize) {
  PPTXdesc *pptx_dev = (PPTXdesc *) dev->deviceSpecific;

  fputs("<a:pPr", pptx_dev->file );

  if (hadj < 0.25)
    fputs(" algn=\"l\"", pptx_dev->file );
  else if (hadj < 0.75)
    fputs(" algn=\"ctr\"", pptx_dev->file );
  else
    fputs(" algn=\"r\"", pptx_dev->file );
  fputs(" marL=\"0\" marR=\"0\" indent=\"0\" >", pptx_dev->file );
  fprintf(pptx_dev->file, "<a:lnSpc><a:spcPts val=\"%.0f\"/></a:lnSpc>", fontsize*100);
  fputs("<a:spcBef><a:spcPts val=\"0\"/></a:spcBef>", pptx_dev->file );
  fputs("<a:spcAft><a:spcPts val=\"0\"/></a:spcAft>", pptx_dev->file );

  fputs("</a:pPr>", pptx_dev->file );

}
void write_rpr(pDevDesc dev, R_GE_gcontext *gc, double fontsize) {
  PPTXdesc *pptx_dev = (PPTXdesc *) dev->deviceSpecific;

  fprintf(pptx_dev->file, "<a:rPr sz=\"%.0f\"", fontsize*100);
  if (gc->fontface == 2) {
    fputs(" b=\"1\"", pptx_dev->file );
  } else if (gc->fontface == 3) {
    fputs(" i=\"1\"", pptx_dev->file );
  } else if (gc->fontface == 4) {
    fputs(" b=\"1\" i=\"1\"", pptx_dev->file );
  }

  fputs(">", pptx_dev->file );
  write_col(dev, gc);
  std::string fontname_ = fontname(gc->fontfamily, gc->fontface,
                                   pptx_dev->fontname_serif, pptx_dev->fontname_sans,
                                   pptx_dev->fontname_mono, pptx_dev->fontname_symbol);

  fprintf(pptx_dev->file,
          "<a:latin typeface=\"%s\"/><a:cs typeface=\"%s\"/>",
          fontname_.c_str(), fontname_.c_str() );

  fputs("</a:rPr>", pptx_dev->file );

}


void dml_write_path(pDevDesc dev, double *x, double *y, int size, int close) {
  int i;
  PPTXdesc *pptx_dev = (PPTXdesc *) dev->deviceSpecific;
  double maxx = max_value(x, size);
  double maxy = max_value(y, size);
  double minx = min_value(x, size);
  double miny = min_value(y, size);

  fprintf(pptx_dev->file, "<a:path w=\"%.0f\" h=\"%.0f\">", p2e_(maxx-minx), p2e_(maxy-miny));

  fprintf(pptx_dev->file,
          "<a:moveTo><a:pt x=\"%.0f\" y=\"%.0f\"/></a:moveTo>",
          p2e_(x[0] - minx), p2e_(y[0] - miny));
  for ( i = 1; i < size; i++) {
    fprintf(pptx_dev->file,
            "<a:lnTo><a:pt x=\"%.0f\" y=\"%.0f\"/></a:lnTo>",
            p2e_(x[i] - minx), p2e_(y[i] - miny));
  }
  if( close > 0 )
    fputs( "<a:close/>", pptx_dev->file );

  fputs( "</a:path>", pptx_dev->file );

}

void write_line(pDevDesc dev, R_GE_gcontext *gc) {
  PPTXdesc *pptx_dev = (PPTXdesc *) dev->deviceSpecific;
  int alpha = R_ALPHA(gc->col);

  int newlty = gc->lty;
  double newlwd = gc->lwd;
  int i;

  if (gc->col == NA_INTEGER || alpha == 0 || gc->lty < 0 || gc->lwd < 0.0 ) {
    return ;
  } else {
    fprintf(pptx_dev->file, "<a:ln w=\"%.0f\">", p2e_(gc->lwd * 72 / 96));
    write_col(dev, gc);

    switch (gc->lty) {
      case LTY_BLANK:
        break;
      case LTY_SOLID:
        fputs("<a:prstDash val=\"solid\" />", pptx_dev->file );
        break;
      case LTY_DOTTED:
        fputs("<a:prstDash val=\"dot\" />", pptx_dev->file );
        break;
      case LTY_DASHED:
        fputs("<a:prstDash val=\"dash\" />", pptx_dev->file );
        break;
      case LTY_LONGDASH:
        fputs("<a:prstDash val=\"lgDash\" />", pptx_dev->file );
        break;
      default:
        fputs("<a:custDash>", pptx_dev->file );
      for(i=0 ; i<8 && newlty&15 ; i++) {
        int lwd = (int)newlwd * newlty;
        lwd = lwd & 15;
        if( i%2 < 1 )
          fprintf(pptx_dev->file, "<a:ds d=\"%i\" ", lwd *100000 );
        else
          fprintf(pptx_dev->file, "sp=\"%i\"/>", lwd *100000 );
        newlty = newlty>>4;
      }
      fputs("</a:custDash>", pptx_dev->file );
      break;
    }

    switch (gc->ljoin) {
      case GE_ROUND_JOIN: //round
        fputs("<a:round />", pptx_dev->file );
        break;
      case GE_MITRE_JOIN: //mitre
        fputs("<a:miter />", pptx_dev->file );
        break;
      case GE_BEVEL_JOIN: //bevel
        fputs("<a:bevel />", pptx_dev->file );
        break;
      default:
        fputs("<a:round />", pptx_dev->file );
      break;
    }
    fputs("</a:ln>", pptx_dev->file );

  }



}
void write_escaped(FILE* f, const char* text) {
  for(const char* cur = text; *cur != '\0'; ++cur) {
    switch(*cur) {
    case '&': fputs("&amp;", f); break;
    case '<': fputs("&lt;",  f); break;
    case '>': fputs("&gt;",  f); break;
    default:  fputc(*cur,    f);
    }
  }
}
// Callback functions for graphics device --------------------------------------

static void pptx_metric_info(int c, const pGEcontext gc, double* ascent,
                            double* descent, double* width, pDevDesc dd) {
  PPTXdesc *pptx_dev = (PPTXdesc*) dd->deviceSpecific;

  // Convert to string - negative implies unicode code point
  char str[16];
  if (c < 0) {
    Rf_ucstoutf8(str, (unsigned int) -c);
  } else {
    str[0] = (char) c;
    str[1] = '\0';
  }

  std::string fn = fontname(gc->fontfamily, gc->fontface,
           pptx_dev->fontname_serif, pptx_dev->fontname_sans,
           pptx_dev->fontname_mono, pptx_dev->fontname_symbol);

  gdtools::context_set_font(pptx_dev->cc, fn,
    gc->cex * gc->ps, is_bold(gc->fontface), is_italic(gc->fontface));
  FontMetric fm = gdtools::context_extents(pptx_dev->cc, std::string(str));
  *ascent = fm.ascent;
  *descent = fm.descent;
  *width = fm.width;
}

static void pptx_clip(double x0, double x1, double y0, double y1, pDevDesc dd) {
  PPTXdesc *pptx_dev = (PPTXdesc*) dd->deviceSpecific;
  pptx_dev->clipleft = x0;
  pptx_dev->clipright = x1;
  pptx_dev->clipbottom = y0;
  pptx_dev->cliptop = y1;
}

static void pptx_new_page(const pGEcontext gc, pDevDesc dd) {
  PPTXdesc *pptx_dev = (PPTXdesc*) dd->deviceSpecific;

  if (pptx_dev->pageno > 0) {
    Rf_error("PPTX only supports one page");
  }
  pptx_dev->new_id();

  pptx_dev->pageno++;
}

static void pptx_close(pDevDesc dd) {
  PPTXdesc *pptx_dev = (PPTXdesc*) dd->deviceSpecific;

  delete(pptx_dev);
}



static double pptx_strwidth(const char *str, const pGEcontext gc, pDevDesc dd) {
  PPTXdesc *pptx_dev = (PPTXdesc*) dd->deviceSpecific;

  std::string fn = fontname(gc->fontfamily, gc->fontface,
                            pptx_dev->fontname_serif, pptx_dev->fontname_sans,
                            pptx_dev->fontname_mono, pptx_dev->fontname_symbol);

  gdtools::context_set_font(pptx_dev->cc, fn,
                            gc->cex * gc->ps, is_bold(gc->fontface), is_italic(gc->fontface));
  FontMetric fm = gdtools::context_extents(pptx_dev->cc, std::string(str));

  return fm.width;
}


static double pptx_strheight(const char *str, const pGEcontext gc, pDevDesc dd) {
  PPTXdesc *pptx_dev = (PPTXdesc*) dd->deviceSpecific;
  std::string fn = fontname(gc->fontfamily, gc->fontface,
                            pptx_dev->fontname_serif, pptx_dev->fontname_sans,
                            pptx_dev->fontname_mono, pptx_dev->fontname_symbol);

  gdtools::context_set_font(pptx_dev->cc, fn,
                            gc->cex * gc->ps, is_bold(gc->fontface), is_italic(gc->fontface));
  FontMetric fm = gdtools::context_extents(pptx_dev->cc, std::string(str));

  return fm.height;
}


static void pptx_line(double x1, double y1, double x2, double y2,
                     const pGEcontext gc, pDevDesc dd) {
  PPTXdesc *pptx_dev = (PPTXdesc*) dd->deviceSpecific;

  double minx = min_value_(x1, x2);
  double maxx = max_value_(x1, x2);
  double miny = min_value_(y1, y2);
  double maxy = max_value_(y1, y2);

  double path_x[2];
  path_x[0] = minx;
  path_x[1] = maxx;
  double path_y[2];
  path_y[0] = miny;
  path_y[1] = maxy;

  write_sp_opening(dd);
  write_nv_pr(dd, gc, "ln");
  write_sppr_opening(dd);
  write_xfrm(dd, minx, miny, maxx-minx, maxy-miny, 0);
  fputs( "<a:custGeom><a:avLst />", pptx_dev->file );
  fputs( "<a:pathLst>", pptx_dev->file );
  dml_write_path(dd, path_x, path_y, 2, 0);
  fputs( "</a:pathLst>", pptx_dev->file );


  fputs( "</a:custGeom>", pptx_dev->file );
  write_line(dd, gc);
  write_sppr_closing(dd);
  write_text_body_empty(dd);
  write_sp_closing(dd);
}


static void pptx_polyline(int n, double *x, double *y, const pGEcontext gc,
                         pDevDesc dd) {
  PPTXdesc *pptx_dev = (PPTXdesc*) dd->deviceSpecific;

  double maxx = max_value(x, n);
  double maxy = max_value(y, n);
  double minx = min_value(x, n);
  double miny = min_value(y, n);

  write_sp_opening(dd);
  write_nv_pr(dd, gc, "pl");

  write_sppr_opening(dd);
  write_xfrm(dd, minx, miny, maxx-minx, maxy-miny, 0);
  fputs( "<a:custGeom><a:avLst />", pptx_dev->file );
  fputs( "<a:pathLst>", pptx_dev->file );
  dml_write_path(dd, x, y, n, 0);
  fputs( "</a:pathLst>", pptx_dev->file );
  fputs( "</a:custGeom>", pptx_dev->file );
  write_line(dd, gc);
  write_sppr_closing(dd);
  write_text_body_empty(dd);

  write_sp_closing(dd);
}
static void pptx_polygon(int n, double *x, double *y, const pGEcontext gc,
                        pDevDesc dd) {
  PPTXdesc *pptx_dev = (PPTXdesc*) dd->deviceSpecific;

  double maxx = max_value(x, n);
  double maxy = max_value(y, n);
  double minx = min_value(x, n);
  double miny = min_value(y, n);


  write_sp_opening(dd);
  write_nv_pr(dd, gc, "pl");

  write_sppr_opening(dd);
  write_xfrm(dd, minx, miny, maxx-minx, maxy-miny, 0);

  fputs("<a:custGeom><a:avLst />", pptx_dev->file );
  fputs( "<a:pathLst>", pptx_dev->file );
  dml_write_path(dd, x, y, n, 1);
  fputs( "</a:pathLst>", pptx_dev->file );

  fputs("</a:custGeom>", pptx_dev->file );
  write_fill(dd, gc);
  write_line(dd, gc);
  write_sppr_closing(dd);

  write_text_body_empty(dd);
  write_sp_closing(dd);
}

void pptx_path(double *x, double *y,
              int npoly, int *nper,
              Rboolean winding,
              const pGEcontext gc, pDevDesc dd) {

}

static void pptx_rect(double x0, double y0, double x1, double y1,
                     const pGEcontext gc, pDevDesc dd) {
  double tmp;

  if (x0 >= x1) {
    tmp = x0;
    x0 = x1;
    x1 = tmp;
  }

  if (y0 >= y1) {
    tmp = y0;
    y0 = y1;
    y1 = tmp;
  }


  write_sp_opening(dd);
  write_nv_pr(dd, gc, "rc");

  write_sppr_opening(dd);
  write_xfrm(dd, x0, y0, x1 - x0, y1 - y0, 0);
  write_preset_geom(dd, "rect");
  write_fill(dd, gc);
  write_line(dd, gc);
  write_sppr_closing(dd);
  write_text_body_empty(dd);

  write_sp_closing(dd);
}

static void pptx_circle(double x, double y, double r, const pGEcontext gc,
                       pDevDesc dd) {

  write_sp_opening(dd);

    write_nv_pr(dd, gc, "rc");

    write_sppr_opening(dd);
      write_xfrm(dd, x - r, y - r, r * 2, r * 2, 0);
      write_preset_geom(dd, "ellipse");
      write_fill(dd, gc);
      write_line(dd, gc);
    write_sppr_closing(dd);

    write_text_body_empty(dd);

  write_sp_closing(dd);

}


static void pptx_text(double x, double y, const char *str, double rot,
                     double hadj, const pGEcontext gc, pDevDesc dd) {
  PPTXdesc *pptx_dev = (PPTXdesc*) dd->deviceSpecific;

  double w = pptx_strwidth(str, gc, dd);
  double h = pptx_strheight(str, gc, dd);
  double fs = gc->cex * gc->ps ;
  if( h < 1.0 ) return;

  double corrected_offx = translate_rotate_x(x, y, rot, h, w, hadj) ;
  double corrected_offy = translate_rotate_y(x, y, rot, h, w, hadj) ;


  write_sp_opening(dd);

  write_nv_pr(dd, gc, "tx");

  write_sppr_opening(dd);
  write_xfrm(dd, corrected_offx, corrected_offy, w, h, rot);
  write_preset_geom(dd, "rect");
  fputs("<a:noFill />", pptx_dev->file );
  write_sppr_closing(dd);

  fputs("<p:txBody>", pptx_dev->file );
  fputs("<a:bodyPr lIns=\"0\" tIns=\"0\" rIns=\"0\" bIns=\"0\" anchor=\"b\">", pptx_dev->file );
  //fputs("<a:spAutoFit />", pptx_dev->file );
  fputs("</a:bodyPr><a:lstStyle /><a:p>", pptx_dev->file );
  write_ppr(dd, hadj, fs);
  fputs("<a:r>", pptx_dev->file );
  write_rpr(dd, gc, fs) ;
  fputs("<a:t>", pptx_dev->file );
  write_escaped(pptx_dev->file, str);
  fputs("</a:t></a:r></a:p></p:txBody>", pptx_dev->file );
  write_sp_closing(dd);
}

static void pptx_size(double *left, double *right, double *bottom, double *top,
                     pDevDesc dd) {
  *left = dd->left;
  *right = dd->right;
  *bottom = dd->bottom;
  *top = dd->top;
}

static void pptx_raster(unsigned int *raster, int w, int h,
                       double x, double y,
                       double width, double height,
                       double rot,
                       Rboolean interpolate,
                       const pGEcontext gc, pDevDesc dd)
{

}


pDevDesc pptx_driver_new(std::string filename, int bg, double width, double height,
                         double offx, double offy,
                        int pointsize,
                        std::string fontname_serif,
                        std::string fontname_sans,
                        std::string fontname_mono,
                        std::string fontname_symbol,
                        bool editable) {

  pDevDesc dd = (DevDesc*) calloc(1, sizeof(DevDesc));
  if (dd == NULL)
    return dd;

  dd->startfill = bg;
  dd->startcol = R_RGB(0, 0, 0);
  dd->startps = pointsize;
  dd->startlty = 0;
  dd->startfont = 1;
  dd->startgamma = 1;

  // Callbacks
  dd->activate = NULL;
  dd->deactivate = NULL;
  dd->close = pptx_close;
  dd->clip = pptx_clip;
  dd->size = pptx_size;
  dd->newPage = pptx_new_page;
  dd->line = pptx_line;
  dd->text = pptx_text;
  dd->strWidth = pptx_strwidth;
  dd->rect = pptx_rect;
  dd->circle = pptx_circle;
  dd->polygon = pptx_polygon;
  dd->polyline = pptx_polyline;
  dd->path = pptx_path;
  dd->mode = NULL;
  dd->metricInfo = pptx_metric_info;
  dd->cap = NULL;
  dd->raster = pptx_raster;

  // UTF-8 support
  dd->wantSymbolUTF8 = (Rboolean) 1;
  dd->hasTextUTF8 = (Rboolean) 1;
  dd->textUTF8 = pptx_text;
  dd->strWidthUTF8 = pptx_strwidth;

  // Screen Dimensions in pts
  dd->left = 0;
  dd->top = 0;
  dd->right = width * 72;
  dd->bottom = height * 72;

  // Magic constants copied from other graphics devices
  // nominal character sizes in pts
  dd->cra[0] = 0.9 * pointsize;
  dd->cra[1] = 1.2 * pointsize;
  // character alignment offsets
  dd->xCharOffset = 0.4900;
  dd->yCharOffset = 0.3333;
  dd->yLineBias = 0.2;
  // inches per pt
  dd->ipr[0] = 1.0 / 72.0;
  dd->ipr[1] = 1.0 / 72.0;

  // Capabilities
  dd->canClip = FALSE;
  dd->canHAdj = 0;
  dd->canChangeGamma = FALSE;
  dd->displayListOn = FALSE;
  dd->haveTransparency = 2;
  dd->haveTransparentBg = 2;

  dd->deviceSpecific = new PPTXdesc(filename,
    fontname_serif, fontname_sans, fontname_mono, fontname_symbol,
    editable, offx*72, offy*72);
  return dd;
}

// [[Rcpp::export]]
bool devPPTX_(std::string file, std::string bg_, int width, int height,
    double offx, double offy,
    int pointsize,
    std::string fontname_serif,
    std::string fontname_sans,
    std::string fontname_mono,
    std::string fontname_symbol,
    bool editable) {

  int bg = R_GE_str2col(bg_.c_str());

  R_GE_checkVersionOrDie(R_GE_version);
  R_CheckDeviceAvailable();
  BEGIN_SUSPEND_INTERRUPTS {
    pDevDesc dev = pptx_driver_new(file, bg, width, height, offx, offy, pointsize,
      fontname_serif, fontname_sans, fontname_mono, fontname_symbol,
      editable);
    if (dev == NULL)
      Rcpp::stop("Failed to start PPTX device");

    pGEDevDesc dd = GEcreateDevDesc(dev);
    GEaddDevice2(dd, "devPPTX");
    GEinitDisplayList(dd);

  } END_SUSPEND_INTERRUPTS;

  return true;
}


