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

#include "datastruct.h"
#include <stdio.h>
#include <Rinternals.h>
#include <R.h>
#include <string.h>

#include <R_ext/GraphicsEngine.h>
#include <R_ext/GraphicsDevice.h>

double getFontSize(double cex, double fontsize, double lineheight) {

	double size = (cex * fontsize * 1.0 );
	/* from GraphicsEngine, it says: Line height (multiply by font size) */
	/* Where should I do that? Not here */
	if( size < 1.0 ) size = 0.0;
	return size;
}



void updateFontInfo(pDevDesc dev, R_GE_gcontext *gc) {
	DOCDesc *pd = (DOCDesc *) dev->deviceSpecific;
	SEXP out;
	char *fontname;

	if( gc->fontface == 5 ) {
		fontname = strdup("Symbol");
	} else if( strlen( gc->fontfamily ) > 0 ) {
		fontname = strdup(gc->fontfamily);
	} else if( pd->fi->isinit > 0 ) {
		fontname = strdup(pd->fi->fontname);
	} else {
		fontname = strdup(pd->fontname);
	}

	int fonsize = (int)getFontSize(gc->cex, gc->ps, gc->lineheight);

	if (pd->fi->isinit < 1 || strcmp(pd->fi->fontname, fontname) != 0 || pd->fi->fontsize != fonsize) {
		pd->fi->fontsize = fonsize;
		pd->fi->fontname = fontname;
		pd->fi->isinit = 1;
		out = eval(
				lang3(install("FontMetric"), mkString(fontname),
						ScalarInteger(pd->fi->fontsize)), R_GlobalEnv);

		int *fm = INTEGER(VECTOR_ELT(out, 0));
		int *widthstemp = INTEGER(VECTOR_ELT(out, 1));
		int f = 0;
		int i = 0;

		for (f = 0; f < 4; f++) {
			pd->fi->ascent[f] = fm[f * 3 + 0];
			pd->fi->descent[f] = fm[f * 3 + 1];
			pd->fi->height[f] = fm[f * 3 + 2];
		}

		for (i = 0; i < 1024; i++)
			pd->fi->widths[i] = widthstemp[i];

	}
}


int getFontface( int ff ){
	int fontface = ff;
	if( fontface > 4 ) fontface = 0;
	else if( fontface < 1 ) fontface = 0;
	else fontface = fontface -1 ;
	return fontface;
}

//http://cran.r-project.org/doc/manuals/R-ints.html#Handling-text

void DOC_MetricInfo(int c, const pGEcontext gc, double* ascent,
		double* descent, double* width, pDevDesc dev) {
	DOCDesc *pd = (DOCDesc *) dev->deviceSpecific;

	updateFontInfo(dev, gc);

	int fontface = getFontface(gc->fontface);
	//if( c < 0 ) c = -c;//"fig-leaf" utf8 issue
	*ascent = pd->fi->ascent[fontface]*gc->lineheight;
	*descent = pd->fi->descent[fontface]*gc->lineheight;
	*width = pd->fi->widths[(fontface * 256) + c];
}


double DOC_StrWidth(const char *str, const pGEcontext gc, pDevDesc dev) {
	double sum;
	DOCDesc *pd = (DOCDesc *) dev->deviceSpecific;
	updateFontInfo(dev, gc);
	int fontface = getFontface(gc->fontface);

	const unsigned char *c = (const unsigned char*) str;
	int unicode_dec;
	sum = 0.0;
	while (*c) {
		unicode_dec = *c;
		if( unicode_dec > 255 ) unicode_dec = 77;
		if( unicode_dec < 0 ) unicode_dec = 77;
		sum += pd->fi->widths[(fontface * 256) + unicode_dec];
		c++;
	}

	return sum;
}

int get_and_increment_idx(pDevDesc dev) {
	DOCDesc *pd = (DOCDesc *) dev->deviceSpecific;
	int id = pd->id;
	pd->id++;
	return id;
}


void register_element(pDevDesc dev) {
	DOCDesc *pd = (DOCDesc *) dev->deviceSpecific;
	int id = pd->id - 1;

	if( pd->elt_tracer->on ){
		if( pd->elt_tracer->isinit < 1 ){
			pd->elt_tracer->first_elt = id;
			pd->elt_tracer->last_elt = id;

			pd->elt_tracer->isinit = 1;
		} else {
			pd->elt_tracer->last_elt = id;
		}
	}
}


void closeFile( FILE *file){
	BEGIN_SUSPEND_INTERRUPTS;
	fflush(file);
	fclose(file);
	END_SUSPEND_INTERRUPTS;
}


