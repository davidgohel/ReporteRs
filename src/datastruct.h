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

typedef struct {
	char *fontname;
	int fontsize;
	int ascent[4];
	int descent[4];
	int height[4];
	int widths[1024];
	int isinit;
} FontInfo;

typedef struct {
	int first_elt;
	int last_elt;
	int on;
	int isinit;
} ElementTracer;

typedef struct {
	char *filename;
	char *fontname;
	char *objectname;
	int canvas_id;

	int pageNumber; /* page number */
	FILE *dmlFilePointer; /* output file */
	int fontface;
	int fontsize;
	int id;
	int editable;
	double offx;
	double offy;
	double extx;
	double exty;
	
	double* x;
	double* y;
	double* width;
	double* height;
	int maxplot;
	FontInfo *fi;
	ElementTracer *elt_tracer;
	SEXP env;

} DOCDesc;

