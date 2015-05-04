/*
 * This file is part of ReporteRs.
 * Copyright (c) 2014, David Gohel All rights reserved.
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

double getFontSize(double cex, double fontsize) {
	double size = cex * fontsize;
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
	} else if( pd->fi->isinit > 0 && strcmp(pd->fi->fontname, "Symbol")!= 0 ) {
		fontname = strdup(pd->fi->fontname);
	} else {
		fontname = strdup(pd->fontname);
	}

	int fonsize = (int)getFontSize(gc->cex, gc->ps);

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

void DOC_MetricInfo(int c, const pGEcontext gc, double* ascent,
		double* descent, double* width, pDevDesc dev) {
	DOCDesc *pd = (DOCDesc *) dev->deviceSpecific;

	if( c < 0 ) c = -c;
	if( c >255 ) c = 77;
	updateFontInfo(dev, gc);

	int fontface = getFontface(gc->fontface);
	*ascent = pd->fi->ascent[fontface];
	*descent = pd->fi->descent[fontface];
	*width = pd->fi->widths[(fontface * 256) + c];
}



double DOC_StrWidthUTF8(const char *str, const pGEcontext gc, pDevDesc dev) {
	DOCDesc *pd = (DOCDesc *) dev->deviceSpecific;
	char *fontname;
	int fontface=gc->fontface;
	if( gc->fontface == 5 ) {
		fontface = 1;
		fontname = strdup("Symbol");
	} else if( strlen( gc->fontfamily ) > 0 ) {
		fontname = strdup(gc->fontfamily);
	} else if( pd->fi->isinit > 0 ) {
		fontname = strdup(pd->fi->fontname);
	} else {
		fontname = strdup(pd->fontname);
	}
	fontface--;
	int fontsize = (int)getFontSize(gc->cex, gc->ps);

	SEXP out;
	out = eval(
			lang5(install("reporters_str_width"),
					mkString(str),
					mkString(fontname),
					ScalarInteger( fontsize ),
					ScalarInteger(fontface)), R_GlobalEnv);

	int *fm = INTEGER(VECTOR_ELT(out, 0));
	return (double) fm[0];
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


/*
 * stolen from PicTeX code
 *
 * */
void DOC_ClipLine(double x0, double y0, double x1, double y1,
		pDevDesc dev)
{
	DOCDesc *ptd = (DOCDesc *) dev->deviceSpecific;
	ptd->clippedx0 = x0;
	ptd->clippedx1 = x1;
	ptd->clippedy0 = y0;
	ptd->clippedy1 = y1;

	if (( ptd->clippedx0 < dev->clipLeft && ptd->clippedx1 < dev->clipLeft ) ||
			(ptd->clippedx0 > dev->clipRight && ptd->clippedx1 > dev->clipRight) ||
			(ptd->clippedy0 < dev->clipBottom && ptd->clippedy1 < dev->clipBottom) ||
			(ptd->clippedy0 > dev->clipTop && ptd->clippedy1 > dev->clipTop)) {

		ptd->clippedx0 = ptd->clippedx1;
		ptd->clippedy0 = ptd->clippedy1;
		return;
	}

	/*Clipping Left */
	if (ptd->clippedx1 >= dev->clipLeft && ptd->clippedx0 < dev->clipLeft) {

		ptd->clippedy0 = ((ptd->clippedy1-ptd->clippedy0) /
				(ptd->clippedx1-ptd->clippedx0) *
				(dev->clipLeft-ptd->clippedx0)) +
						ptd->clippedy0;
		ptd->clippedx0 = dev->clipLeft;
	}
	if (ptd->clippedx1 <= dev->clipLeft && ptd->clippedx0 > dev->clipLeft) {
		ptd->clippedy1 = ((ptd->clippedy1-ptd->clippedy0) /
				(ptd->clippedx1-ptd->clippedx0) *
				(dev->clipLeft-ptd->clippedx0)) +
						ptd->clippedy0;
		ptd->clippedx1 = dev->clipLeft;
	}
	/* Clipping Right */
	if (ptd->clippedx1 >= dev->clipRight &&
			ptd->clippedx0 < dev->clipRight) {

		ptd->clippedy1 = ((ptd->clippedy1-ptd->clippedy0) /
				(ptd->clippedx1-ptd->clippedx0) *
				(dev->clipRight-ptd->clippedx0)) +
						ptd->clippedy0;
		ptd->clippedx1 = dev->clipRight;
	}
	if (ptd->clippedx1 <= dev->clipRight &&
			ptd->clippedx0 > dev->clipRight) {

		ptd->clippedy0 = ((ptd->clippedy1-ptd->clippedy0) /
				(ptd->clippedx1-ptd->clippedx0) *
				(dev->clipRight-ptd->clippedx0)) +
						ptd->clippedy0;
		ptd->clippedx0 = dev->clipRight;
	}
	/*Clipping Bottom */
	if (ptd->clippedy1 >= dev->clipBottom  &&
			ptd->clippedy0 < dev->clipBottom ) {
		ptd->clippedx0 = ((ptd->clippedx1-ptd->clippedx0) /
				(ptd->clippedy1-ptd->clippedy0) *
				(dev->clipBottom -ptd->clippedy0)) +
						ptd->clippedx0;
		ptd->clippedy0 = dev->clipBottom ;
	}
	if (ptd->clippedy1 <= dev->clipBottom &&
			ptd->clippedy0 > dev->clipBottom ) {
		ptd->clippedx1 = ((ptd->clippedx1-ptd->clippedx0) /
				(ptd->clippedy1-ptd->clippedy0) *
				(dev->clipBottom -ptd->clippedy0)) +
						ptd->clippedx0;
		ptd->clippedy1 = dev->clipBottom ;
	}
	/*Clipping Top */
	if (ptd->clippedy1 >= dev->clipTop  && ptd->clippedy0 < dev->clipTop ) {
		ptd->clippedx1 = ((ptd->clippedx1-ptd->clippedx0) /
				(ptd->clippedy1-ptd->clippedy0) *
				(dev->clipTop -ptd->clippedy0)) +
						ptd->clippedx0;
		ptd->clippedy1 = dev->clipTop ;
	}
	if (ptd->clippedy1 <= dev->clipTop && ptd->clippedy0 > dev->clipTop ) {
		ptd->clippedx0 = ((ptd->clippedx1-ptd->clippedx0) /
				(ptd->clippedy1-ptd->clippedy0) *
				(dev->clipTop -ptd->clippedy0)) +
						ptd->clippedx0;
		ptd->clippedy0 = dev->clipTop ;
	}
}

/*
 * stolen from PicTeX code
 *
 * */
void DOC_ClipRect(double x0, double y0, double x1, double y1,
		pDevDesc dev)
{
	DOCDesc *ptd = (DOCDesc *) dev->deviceSpecific;
	ptd->clippedx0 = x0;
	ptd->clippedx1 = x1;
	ptd->clippedy0 = y0;
	ptd->clippedy1 = y1;

	if (( ptd->clippedx0 < dev->clipLeft && ptd->clippedx1 < dev->clipLeft ) ||
			(ptd->clippedx0 > dev->clipRight && ptd->clippedx1 > dev->clipRight) ||
			(ptd->clippedy0 < dev->clipBottom && ptd->clippedy1 < dev->clipBottom) ||
			(ptd->clippedy0 > dev->clipTop && ptd->clippedy1 > dev->clipTop)) {
		ptd->clippedx0 = ptd->clippedx1;
		ptd->clippedy0 = ptd->clippedy1;
		return;
	}

	/*Clipping Left */
	if ( ptd->clippedx0 < dev->clipLeft && ptd->clippedx1 >= dev->clipLeft ) {
		ptd->clippedx0 = dev->clipLeft;
	}
	if ( ptd->clippedx0 > dev->clipLeft && ptd->clippedx1 <= dev->clipLeft ) {
		ptd->clippedx1 = dev->clipLeft;
	}
	/* Clipping Right */
	if ( ptd->clippedx0 < dev->clipRight && ptd->clippedx1 >= dev->clipRight ) {
		ptd->clippedx1 = dev->clipRight;
	}
	if ( ptd->clippedx0 > dev->clipRight && ptd->clippedx1 <= dev->clipRight ) {
		ptd->clippedx0 = dev->clipRight;
	}
	/*Clipping Bottom */
	if ( ptd->clippedy0 < dev->clipBottom && ptd->clippedy1 >= dev->clipBottom ) {
		ptd->clippedy0 = dev->clipBottom ;
	}
	if ( ptd->clippedy0 > dev->clipBottom && ptd->clippedy1 <= dev->clipBottom ) {
		ptd->clippedy1 = dev->clipBottom ;
	}
	/*Clipping Top */
	if ( ptd->clippedy0 < dev->clipTop && ptd->clippedy1 >= dev->clipTop ) {
		ptd->clippedy1 = dev->clipTop ;
	}
	if ( ptd->clippedy0 > dev->clipTop && ptd->clippedy1 <= dev->clipTop ) {
		ptd->clippedy0 = dev->clipTop ;
	}

}

