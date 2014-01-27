#include <Rinternals.h>
#include <R.h>

#include <R_ext/GraphicsEngine.h>
#include "R_ext/GraphicsDevice.h"
#include <R_ext/Boolean.h>



extern "C" {


static Rboolean DOCXDeviceDriver(pDevDesc dev, const char* filename, double* width,
		double* height, double* offx, double* offy, double ps, int nbplots,
		const char* fontname, SEXP env);


void GE_DOCXDevice(const char* filename, double* width, double* height, double* offx,
		double* offy, double ps, int nbplots, const char* fontfamily);

static void DOCX_activate(pDevDesc dev);

static void DOCX_Circle(double x, double y, double r, const pGEcontext gc,
		pDevDesc dev);

static void DOCX_Line(double x1, double y1, double x2, double y2,
		const pGEcontext gc, pDevDesc dev) ;

static void DOCX_Polyline(int n, double *x, double *y, const pGEcontext gc,
		pDevDesc dev) ;

static void DOCX_Polygon(int n, double *x, double *y, const pGEcontext gc,
		pDevDesc dev) ;

static void DOCX_Rect(double x0, double y0, double x1, double y1,
		const pGEcontext gc, pDevDesc dev) ;

static void DOCX_Text(double x, double y, const char *str, double rot,
		double hadj, const pGEcontext gc, pDevDesc dev);

static void DOCX_NewPage(const pGEcontext gc, pDevDesc dev) ;
static void DOCX_Close(pDevDesc dev) ;
static void DOCX_Clip(double x0, double x1, double y0, double y1, pDevDesc dev);

static void DOCX_MetricInfo(int c, const pGEcontext gc, double* ascent,
		double* descent, double* width, pDevDesc dev);
static void DOCX_Size(double *left, double *right, double *bottom, double *top,
		pDevDesc dev);

static double DOCX_StrWidth(const char *str, const pGEcontext gc, pDevDesc dev);

//SEXP setDimensions(SEXP devNumber, SEXP ext, SEXP off);

SEXP R_DOCX_Device(SEXP filename, SEXP width, SEXP height, SEXP offx,
		SEXP offy, SEXP pointsize, SEXP fontfamily, SEXP env);

};
