/* Created by David Gohel
 *
 * ReporteRs, Copyright (c) 2014 David Gohel. All rights reserved. Based on sources of grDevices for
 *  R : A Computer Language for Statistical Data Analysis
 *  Copyright (C) 1995, 1996  Robert Gentleman and Ross Ihaka
 *  Copyright (C) 1998--2013  The R Core Team
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, a copy is available at
 *  http://www.r-project.org/Licenses/
 */

#include "datastruct.h"
#include "utils.h"


//TODO:http://cran.r-project.org/doc/manuals/R-ints.html#Handling-text

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
//	const char *p;
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
