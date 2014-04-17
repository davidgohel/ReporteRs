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

#include <Rinternals.h>
#include <R.h>

#include <R_ext/GraphicsEngine.h>
#include "R_ext/GraphicsDevice.h"
#include <R_ext/Boolean.h>

extern "C" {

static Rboolean PPTXDeviceDriver(pDevDesc dev, const char* filename, double* width,
		double* height, double* offx, double* offy, double ps, int nbplots,
		const char* fontname, int id_init_value, int editable);


void GE_PPTXDevice(const char* filename, double* width, double* height, double* offx,
		double* offy, double ps, int nbplots, const char* fontfamily, int id_init_value, int editable);

static void PPTX_activate(pDevDesc dev);

static void PPTX_Circle(double x, double y, double r, const pGEcontext gc,
		pDevDesc dev);

static void PPTX_Line(double x1, double y1, double x2, double y2,
		const pGEcontext gc, pDevDesc dev) ;

static void PPTX_Polyline(int n, double *x, double *y, const pGEcontext gc,
		pDevDesc dev) ;

static void PPTX_Polygon(int n, double *x, double *y, const pGEcontext gc,
		pDevDesc dev) ;

static void PPTX_Rect(double x0, double y0, double x1, double y1,
		const pGEcontext gc, pDevDesc dev) ;

static void PPTX_Text(double x, double y, const char *str, double rot,
		double hadj, const pGEcontext gc, pDevDesc dev);

static void PPTX_NewPage(const pGEcontext gc, pDevDesc dev) ;
static void PPTX_Close(pDevDesc dev) ;
static void PPTX_Clip(double x0, double x1, double y0, double y1, pDevDesc dev);

static void PPTX_MetricInfo(int c, const pGEcontext gc, double* ascent,
		double* descent, double* width, pDevDesc dev);
static void PPTX_Size(double *left, double *right, double *bottom, double *top,
		pDevDesc dev);

static double PPTX_StrWidth(const char *str, const pGEcontext gc, pDevDesc dev);

//SEXP setDimensions(SEXP devNumber, SEXP ext, SEXP off);

SEXP R_PPTX_Device(SEXP filename, SEXP width, SEXP height, SEXP offx,
		SEXP offy, SEXP pointsize, SEXP fontfamily, SEXP start_id, SEXP is_editable);
};

