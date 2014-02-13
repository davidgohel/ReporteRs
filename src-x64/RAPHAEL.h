#include <Rinternals.h>
#include <R.h>

#include <R_ext/GraphicsEngine.h>
#include "R_ext/GraphicsDevice.h"
#include <R_ext/Boolean.h>



extern "C" {


static Rboolean RAPHAELDeviceDriver(pDevDesc dev, const char* filename, double* width,
		double* height, double* offx, double* offy, double ps, int nbplots,
		const char* fontname, SEXP env);


void GE_RAPHAELDevice(const char* filename, double* width, double* height, double* offx,
		double* offy, double ps, int nbplots, const char* fontfamily);

static void RAPHAEL_activate(pDevDesc dev);

static void RAPHAEL_Circle(double x, double y, double r, const pGEcontext gc,
		pDevDesc dev);

static void RAPHAEL_Line(double x1, double y1, double x2, double y2,
		const pGEcontext gc, pDevDesc dev) ;

static void RAPHAEL_Polyline(int n, double *x, double *y, const pGEcontext gc,
		pDevDesc dev) ;

static void RAPHAEL_Polygon(int n, double *x, double *y, const pGEcontext gc,
		pDevDesc dev) ;

static void RAPHAEL_Rect(double x0, double y0, double x1, double y1,
		const pGEcontext gc, pDevDesc dev) ;

static void RAPHAEL_Text(double x, double y, const char *str, double rot,
		double hadj, const pGEcontext gc, pDevDesc dev);

static void RAPHAEL_NewPage(const pGEcontext gc, pDevDesc dev) ;
static void RAPHAEL_Close(pDevDesc dev) ;
static void RAPHAEL_Clip(double x0, double x1, double y0, double y1, pDevDesc dev);

static void RAPHAEL_MetricInfo(int c, const pGEcontext gc, double* ascent,
		double* descent, double* width, pDevDesc dev);
static void RAPHAEL_Size(double *left, double *right, double *bottom, double *top,
		pDevDesc dev);

static double RAPHAEL_StrWidth(const char *str, const pGEcontext gc, pDevDesc dev);

//SEXP setDimensions(SEXP devNumber, SEXP ext, SEXP off);

SEXP R_RAPHAEL_Device(SEXP filename, SEXP width, SEXP height, SEXP offx,
		SEXP offy, SEXP pointsize, SEXP fontfamily, SEXP env);
};
