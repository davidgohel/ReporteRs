/*
 * This file is part of ReporteRs.
 * Copyright (c) 2014, David Gohel All rights reserved.
 *
 * It is inspired from sources of R package grDevices:
 * Copyright (C) 1995, 1996  Robert Gentleman and Ross Ihaka
 * Copyright (C) 1998--2014  The R Core Team
 *
 * ReporteRs is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * ReporteRs is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with ReporteRs.  If not, see <http://www.gnu.org/licenses/>.
**/

#include <string.h>
#include <stdio.h>
#include <math.h>

#include <locale.h>
#include <R_ext/Riconv.h>
#include <errno.h>
#include "RAPHAEL.h"

#define R_USE_PROTOTYPES 1

#include "datastruct.h"
#include "utils.h"
#include "common.h"

static Rboolean RAPHAELDeviceDriver(pDevDesc dev, const char* filename, double* width,
		double* height, double* offx, double* offy, double ps, int nbplots,
		const char* fontname, int canvas_id, SEXP env) {

	DOCDesc *rd;
	rd = (DOCDesc *) malloc(sizeof(DOCDesc));

	FontInfo *fi = (FontInfo *) malloc(sizeof(FontInfo));
	fi->isinit=0;
	fi->fontsize=(int)ps;
	rd->fi = fi;

	rd->canvas_id = canvas_id;

	rd->filename = strdup(filename);
	rd->fontname = strdup(fontname);
	rd->id = 0;
	rd->pageNumber = 0;
	rd->offx = offx[0];
	rd->offy = offy[0];
	rd->extx = width[0];
	rd->exty = height[0];
	rd->maxplot = nbplots;
	rd->x = offx;
	rd->y = offy;
	rd->width = width;
	rd->height = height;
	rd->fontface = 1;
	rd->fontsize = (int) ps;
	rd->env=env;
	//
	//  Device functions
	//
	dev->deviceSpecific = rd;
	dev->activate = RAPHAEL_activate;
	dev->close = RAPHAEL_Close;
	dev->size = RAPHAEL_Size;
	dev->newPage = RAPHAEL_NewPage;
	dev->clip = RAPHAEL_Clip;
	dev->strWidth = RAPHAEL_StrWidth;
	dev->text = RAPHAEL_Text;
	dev->rect = RAPHAEL_Rect;
	dev->circle = RAPHAEL_Circle;
	dev->line = RAPHAEL_Line;
	dev->polyline = RAPHAEL_Polyline;
	dev->polygon = RAPHAEL_Polygon;
	dev->metricInfo = RAPHAEL_MetricInfo;
	dev->hasTextUTF8 = (Rboolean) FALSE;
	dev->wantSymbolUTF8 = (Rboolean) FALSE;
	dev->useRotatedTextInContour = (Rboolean) FALSE;
	/*
	 * Initial graphical settings
	 */
	dev->startfont = 1;
	dev->startps = ps;
	dev->startcol = R_RGB(0, 0, 0);
	dev->startfill = R_TRANWHITE;
	dev->startlty = LTY_SOLID;
	dev->startgamma = 1;


	/*
	 * Device physical characteristics
	 */

	dev->left = 0;
	dev->right = width[0];
	dev->bottom = height[0];
	dev->top = 0;

	dev->cra[0] = 0.9 * ps;
	dev->cra[1] = 1.2 * ps;
	dev->xCharOffset = 0.4900;
	dev->yCharOffset = 0.3333;
	//dev->yLineBias = 0.2;
	dev->ipr[0] = 1.0 / 72.2;
	dev->ipr[1] = 1.0 / 72.2;
	/*
	 * Device capabilities
	 */
	dev->canClip = (Rboolean) FALSE;
	dev->canHAdj = 2;//canHadj – integer: can the device do horizontal adjustment of text via the text callback, and if so, how precisely? 0 = no adjustment, 1 = {0, 0.5, 1} (left, centre, right justification) or 2 = continuously variable (in [0,1]) between left and right justification.
	dev->canChangeGamma = (Rboolean) FALSE;	//canChangeGamma – Rboolean: can the display gamma be adjusted? This is now ignored, as gamma support has been removed.
	dev->displayListOn = (Rboolean) FALSE;

	dev->haveTransparency = 2;
	dev->haveTransparentBg = 3;

	return (Rboolean) TRUE;
}


void GE_RAPHAELDevice(const char* filename, double* width, double* height, double* offx,
		double* offy, double ps, int nbplots, const char* fontfamily, int canvas_id, SEXP env) {
	pDevDesc dev = NULL;
	pGEDevDesc dd;
	R_GE_checkVersionOrDie (R_GE_version);
	R_CheckDeviceAvailable();

	if (!(dev = (pDevDesc) calloc(1, sizeof(DevDesc))))
		Rf_error("unable to start RAPHAEL device");
	if (!RAPHAELDeviceDriver(dev, filename, width, height, offx, offy, ps, nbplots,
			fontfamily, canvas_id, env)) {
		free(dev);
		Rf_error("unable to start RAPHAEL device");
	}

	dd = GEcreateDevDesc(dev);
	GEaddDevice2(dd, "RAPHAEL");

}

static void RAPHAEL_activate(pDevDesc dev) {
}


void RAPHAEL_SetLineSpec(pDevDesc dev, R_GE_gcontext *gc, int idx) {
	DOCDesc *pd = (DOCDesc *) dev->deviceSpecific;
	char *saved_locale;
	saved_locale = setlocale(LC_NUMERIC, "C");

	float alpha =  R_ALPHA(gc->col)/255.0;
	fprintf(pd->dmlFilePointer, "elt_%d.attr({", idx);

	if (gc->lty > -1 && gc->lwd > 0.0 && alpha > 0) {
		fprintf(pd->dmlFilePointer, "'stroke': \"#%s\"", RGBHexValue(gc->col) );
		fprintf(pd->dmlFilePointer, ", 'stroke-opacity': \"%.3f\"", alpha );

		fprintf(pd->dmlFilePointer, ", 'stroke-width': %.3f", gc->lwd );

		switch (gc->lty) {
		case LTY_BLANK:
			break;
		case LTY_SOLID:
			break;
		case LTY_DOTTED:
			fputs(", 'stroke-dasharray': \".\"", pd->dmlFilePointer );
			break;
		case LTY_DASHED:
			fputs(", 'stroke-dasharray': \"-\"", pd->dmlFilePointer );
			break;
		case LTY_LONGDASH:
			fputs(", 'stroke-dasharray': \"--\"", pd->dmlFilePointer );
			break;
		case LTY_DOTDASH:
			fputs(", 'stroke-dasharray': \"-.\"", pd->dmlFilePointer );
			break;
		case LTY_TWODASH:
			fputs(", 'stroke-dasharray': \"--\"", pd->dmlFilePointer );
			break;
		default:
			break;
		}

		switch (gc->ljoin) {
		case GE_ROUND_JOIN: //round
			fputs(", 'stroke-linejoin': \"round\"", pd->dmlFilePointer );
			break;
		case GE_MITRE_JOIN: //mitre
			fputs(", 'stroke-linejoin': \"miter\"", pd->dmlFilePointer );
			break;
		case GE_BEVEL_JOIN: //bevel
			fputs(", 'stroke-linejoin': \"bevel\"", pd->dmlFilePointer );
			break;
		default:
			fputs(", 'stroke-linejoin': \"round\"", pd->dmlFilePointer );
			break;
		}
	} else {
		fputs("'stroke-width': 0", pd->dmlFilePointer );
	}
	fputs("});\n", pd->dmlFilePointer );
	setlocale(LC_NUMERIC, saved_locale);

}

void RAPHAEL_SetFillColor(pDevDesc dev, R_GE_gcontext *gc, int idx) {
	DOCDesc *pd = (DOCDesc *) dev->deviceSpecific;
	char *saved_locale;
	saved_locale = setlocale(LC_NUMERIC, "C");
	fprintf(pd->dmlFilePointer, "elt_%d.attr({", idx);

	float alpha =  R_ALPHA(gc->fill)/255.0;
	if (alpha > 0) {
		fprintf(pd->dmlFilePointer, "'fill': \"#%s\"", RGBHexValue(gc->fill) );
		fprintf(pd->dmlFilePointer, ",'fill-opacity': \"%.3f\"", alpha );
	}
	fputs("});\n", pd->dmlFilePointer );
	setlocale(LC_NUMERIC, saved_locale);

}

void RAPHAEL_SetFontSpec(pDevDesc dev, R_GE_gcontext *gc, int idx) {
	DOCDesc *pd = (DOCDesc *) dev->deviceSpecific;
	char *saved_locale;
	saved_locale = setlocale(LC_NUMERIC, "C");

	float alpha =  R_ALPHA(gc->col)/255.0;
	double fontsize = getFontSize(gc->cex, gc->ps, gc->lineheight);


	if ( gc->cex > 0.0 && alpha > 0 ) {
		fprintf(pd->dmlFilePointer, "elt_%d.attr({", idx);
		fprintf(pd->dmlFilePointer, "'fill': \"#%s\"", RGBHexValue(gc->col) );
		fprintf(pd->dmlFilePointer, ", 'fill-opacity': \"%.3f\"", alpha );
		fprintf(pd->dmlFilePointer, ", 'font-family': \"%s\"", pd->fi->fontname );
		fprintf(pd->dmlFilePointer, ", 'font-size': \"%.0f\"", fontsize );
		if (gc->fontface == 2) {
			fputs(", 'font-weight': \"bold\"", pd->dmlFilePointer );
		} else if (gc->fontface == 3) {
			fputs(", 'font-style'=\"italic\"", pd->dmlFilePointer );
		} else if (gc->fontface == 4) {
			fputs(", 'font-weight': \"bold\", 'font-style'=\"italic\"", pd->dmlFilePointer );
		}
		fputs("});\n", pd->dmlFilePointer );


	}

	setlocale(LC_NUMERIC, saved_locale);

}


static void RAPHAEL_Circle(double x, double y, double r, const pGEcontext gc,
		pDevDesc dev) {
	DOCDesc *pd = (DOCDesc *) dev->deviceSpecific;
	int idx = get_and_increment_idx(dev);

	fprintf(pd->dmlFilePointer,
			"var elt_%d = %s.circle(%.0f, %.0f, %.0f);\n", idx, pd->objectname, x, y, r);
	RAPHAEL_SetLineSpec(dev, gc, idx);
	RAPHAEL_SetFillColor(dev, gc, idx);

	fflush(pd->dmlFilePointer);
}

static void RAPHAEL_Line(double x1, double y1, double x2, double y2,
		const pGEcontext gc, pDevDesc dev) {
	DOCDesc *pd = (DOCDesc *) dev->deviceSpecific;

	if (gc->lty > -1 && gc->lwd > 0.0 ){
		int idx = get_and_increment_idx(dev);
		fprintf(pd->dmlFilePointer, "var elt_%d = %s.path(\"", idx, pd->objectname );
		fprintf(pd->dmlFilePointer, "M %.0f %.0f", x1, y1);
		fprintf(pd->dmlFilePointer, "L %.0f %.0f", x2, y2);
		fputs("\");\n", pd->dmlFilePointer );

		RAPHAEL_SetLineSpec(dev, gc, idx);

		fflush(pd->dmlFilePointer);
	}

	//return;
}

static void RAPHAEL_Polyline(int n, double *x, double *y, const pGEcontext gc,
		pDevDesc dev) {
//	Rprintf("RAPHAEL_Polyline\n");

	DOCDesc *pd = (DOCDesc *) dev->deviceSpecific;
	if (gc->lty > -1 && gc->lwd > 0.0 ){

		int idx = get_and_increment_idx(dev);
		int i;
		fprintf(pd->dmlFilePointer, "var elt_%d = %s.path(\"", idx, pd->objectname );
		fprintf(pd->dmlFilePointer, "M %.0f %.0f", x[0], y[0]);

		for (i = 1; i < n; i++) {
			fprintf(pd->dmlFilePointer, "L %.0f %.0f", x[i], y[i]);
		}
		fputs("\");\n", pd->dmlFilePointer );


		RAPHAEL_SetLineSpec(dev, gc, idx);

		fflush(pd->dmlFilePointer);
	}
}

static void RAPHAEL_Polygon(int n, double *x, double *y, const pGEcontext gc,
		pDevDesc dev) {

	DOCDesc *pd = (DOCDesc *) dev->deviceSpecific;
	int idx = get_and_increment_idx(dev);
	int i;

	fprintf(pd->dmlFilePointer, "var elt_%d = %s.path(\"", idx, pd->objectname );
	fprintf(pd->dmlFilePointer, "M %.0f %.0f", x[0], y[0]);

	for (i = 1; i < n; i++) {
		fprintf(pd->dmlFilePointer, "L %.0f %.0f", x[i], y[i]);
	}

	fputs("Z\");\n", pd->dmlFilePointer );

	RAPHAEL_SetLineSpec(dev, gc, idx);
	RAPHAEL_SetFillColor(dev, gc, idx);

	fflush(pd->dmlFilePointer);

}

static void RAPHAEL_Rect(double x0, double y0, double x1, double y1,
		const pGEcontext gc, pDevDesc dev) {
	DOCDesc *pd = (DOCDesc *) dev->deviceSpecific;
	int idx = get_and_increment_idx(dev);

	double temp;
	if( y1 < y0 ){
		temp = y1;
		y1 = y0;
		y0 = temp;
	}
	if( x1 < x0 ){
		temp = x1;
		x1 = x0;
		x0 = temp;
	}

	fprintf(pd->dmlFilePointer, "var elt_%d = %s.rect(", idx, pd->objectname );
	fprintf(pd->dmlFilePointer, "%.0f,%.0f", x0, y0);
	fprintf(pd->dmlFilePointer, ",%.0f,%.0f", x1-x0, y1-y0);
	fputs(");\n", pd->dmlFilePointer );

	RAPHAEL_SetLineSpec(dev, gc, idx);
	RAPHAEL_SetFillColor(dev, gc, idx);

	fflush(pd->dmlFilePointer);

}


static void RAPHAEL_Text(double x, double y, const char *str, double rot,
		double hadj, const pGEcontext gc, pDevDesc dev) {

	DOCDesc *pd = (DOCDesc *) dev->deviceSpecific;
	int idx = get_and_increment_idx(dev);
	double w = RAPHAEL_StrWidth(str, gc, dev);
	double fontsize = getFontSize(gc->cex, gc->ps, gc->lineheight);
	double h = fontsize;
	if( h < 1.0 ) return;
	double pi = 3.141592653589793115997963468544185161590576171875;

	double alpha = -rot * pi / 180;
	double height = h;
	double Qx = x;
	double Qy = y ;
	double Px = x + (0.5-hadj) * w;
	double Py = y - 0.5 * height;
	double _cos = cos( alpha );
	double _sin = sin( alpha );

	double Ppx = Qx + (Px-Qx) * _cos - (Py-Qy) * _sin ;
	double Ppy = Qy + (Px-Qx) * _sin + (Py-Qy) * _cos;

	double corrected_offx = Ppx ;//- 0.5 * w;
	double corrected_offy = Ppy ;//- 0.5 * h;


	fprintf(pd->dmlFilePointer, "var elt_%d = %s.text(", idx, pd->objectname );
	fprintf(pd->dmlFilePointer, "%.0f,%.0f", corrected_offx, corrected_offy);

	fprintf(pd->dmlFilePointer, ",\"%s\"", str);
	fputs(");\n", pd->dmlFilePointer );

	RAPHAEL_SetFontSpec(dev, gc, idx);
	if( rot > 0 ) {
		fprintf(pd->dmlFilePointer, "elt_%d.transform(\"", idx);
		fprintf(pd->dmlFilePointer, "R-%.0f", rot);
		fputs("\");\n", pd->dmlFilePointer );
	}

	fflush(pd->dmlFilePointer);

}

static void RAPHAEL_NewPage(const pGEcontext gc, pDevDesc dev) {
	DOCDesc *pd = (DOCDesc *) dev->deviceSpecific;
	if (pd->pageNumber > 0) {
		closeFile(pd->dmlFilePointer);
	}

	int which = pd->pageNumber % pd->maxplot;
	pd->pageNumber++;
	pd->canvas_id++;
	dev->right = pd->width[which];
	dev->bottom = pd->height[which];
	pd->offx = pd->x[which];
	pd->offy = pd->y[which];
	pd->extx = pd->width[which];
	pd->exty = pd->height[which];

	char *filename={0};
	filename = getRaphaelFilename(pd->filename, pd->pageNumber);

	pd->dmlFilePointer = (FILE *) fopen(filename, "w");
	char *canvasname={0};
	canvasname = getCanvasName(pd->canvas_id);
	if (pd->dmlFilePointer == NULL) {
		Rf_error("error while opening %s\n", filename);
	}
	updateFontInfo(dev, gc);
	pd->objectname = getJSVariableName(pd->filename, pd->canvas_id);
	fprintf(pd->dmlFilePointer, "var %s = new Raphael(document.getElementById('%s'), %.0f, %.0f);\n"
			, pd->objectname, canvasname, dev->right, dev->bottom);

	SEXP cmdSexp = PROTECT(allocVector(STRSXP, 3));
	SET_STRING_ELT(cmdSexp, 0, mkChar(filename));
	SET_STRING_ELT(cmdSexp, 1, mkChar(pd->objectname));
	SET_STRING_ELT(cmdSexp, 2, mkChar(canvasname));

	eval( lang3(install("registerRaphaelGraph")
						, cmdSexp, pd->env
						), R_GlobalEnv);
    UNPROTECT(1);

	free(filename);
	free(canvasname);

}
static void RAPHAEL_Close(pDevDesc dev) {
	DOCDesc *pd = (DOCDesc *) dev->deviceSpecific;
	//update_canvas_id(dev);
	closeFile(pd->dmlFilePointer);
	free(pd);
}

static void RAPHAEL_Clip(double x0, double x1, double y0, double y1, pDevDesc dev) {
}

static void RAPHAEL_MetricInfo(int c, const pGEcontext gc, double* ascent,
		double* descent, double* width, pDevDesc dev) {
	DOC_MetricInfo(c, gc, ascent, descent, width, dev);
}

static void RAPHAEL_Size(double *left, double *right, double *bottom, double *top,
		pDevDesc dev) {
	*left = dev->left;
	*right = dev->right;
	*bottom = dev->bottom;
	*top = dev->top;
}


static double RAPHAEL_StrWidth(const char *str, const pGEcontext gc, pDevDesc dev) {
	return DOC_StrWidth(str, gc, dev);
}



SEXP R_RAPHAEL_Device(SEXP filename
		, SEXP width, SEXP height, SEXP offx,
		SEXP offy, SEXP pointsize, SEXP fontfamily, SEXP canvas_id, SEXP env) {

	double* w = REAL(width);
	double* h = REAL(height);

	double* x = REAL(offx);
	double* y = REAL(offy);
	int nx = length(width);

	double ps = asReal(pointsize);
	int canvasid = INTEGER(canvas_id)[0];

	BEGIN_SUSPEND_INTERRUPTS;
	GE_RAPHAELDevice(CHAR(STRING_ELT(filename, 0))
			, w, h, x, y, ps, nx, CHAR(STRING_ELT(fontfamily, 0))
			, canvasid
			, env);
	END_SUSPEND_INTERRUPTS;
	return R_NilValue;
}

