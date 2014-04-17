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

#include "utils.h"
#include "datastruct.h"
#include <locale.h>


double p2e_(double x) {
	double y = x * 12700;
	return y;
}
double p2t(double x) {
	double y = x * 20;
	return y;
}

int getFontface( int ff ){
	int fontface = ff;
	if( fontface > 4 ) fontface = 0;
	else if( fontface < 1 ) fontface = 0;
	else fontface = fontface -1 ;
	return fontface;
}

double getFontSize(double cex, double fontsize, double lineheight) {

	double size = (cex * fontsize * 1.0 );
	/* from GraphicsEngine, it says: Line height (multiply by font size) */
	/* Where should I do that? Not here */
	if( size < 1.0 ) size = 0.0;
	return size;
}


void closeFile( FILE *file){
	BEGIN_SUSPEND_INTERRUPTS;
	fflush(file);
	fclose(file);
	END_SUSPEND_INTERRUPTS;
}

char* getFilename(char* filename, int index){
	char *buf;
	int len = snprintf(NULL, 0, "%s_%03d.dml", filename, index);
	buf = (char*)malloc( (len + 1) * sizeof(char) );
	sprintf(buf, "%s_%03d.dml", filename, index);

	return buf;
}

char* getRaphaelFilename(char* filename, int index){
	char *buf;
	int len = snprintf(NULL, 0, "%s_%03d.js", filename,index);
	buf = (char*)malloc( (len + 1) * sizeof(char) );
	sprintf(buf, "%s_%03d.js", filename,index);
	return buf;
}

char* getCanvasName( int index){

	char *buf;
	int len = snprintf(NULL, 0, "canvas_%03d", index);
	buf = (char*)malloc( (len + 1) * sizeof(char) );
	sprintf(buf, "canvas_%03d", index);
	return buf;
}
char* getJSVariableName(char* filename, int index){
	char *buf;
	int len = snprintf(NULL, 0, "paper%03d", index);
	buf = (char*)malloc( (len + 1) * sizeof(char) );
	sprintf(buf, "paper%03d", index);
	return buf;
}

static char color_value[7];
static char HexReferenceTable[] = "0123456789ABCDEF";

char *RGBHexValue(unsigned int col) {
	color_value[0] = HexReferenceTable[(col >> 4) & 15];
	color_value[1] = HexReferenceTable[(col) & 15];
	color_value[2] = HexReferenceTable[(col >> 12) & 15];
	color_value[3] = HexReferenceTable[(col >> 8) & 15];
	color_value[4] = HexReferenceTable[(col >> 20) & 15];
	color_value[5] = HexReferenceTable[(col >> 16) & 15];
	color_value[6] = '\0';
	return &color_value[0];
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

void get_current_canvas_id(int *dn, int *res) {
	pGEDevDesc dev= GEgetDevice(*dn);
	if (dev) {
		DOCDesc *pd = (DOCDesc *) dev->dev->deviceSpecific;
		*res = pd->canvas_id;
	} else *res = -1;
}

void get_current_element_id(int *dn, int *res) {
	pGEDevDesc dev= GEgetDevice(*dn);
	if (dev) {
		DOCDesc *pd = (DOCDesc *) dev->dev->deviceSpecific;
		*res = pd->id;
	} else *res = -1;
}
//current_id = .C("get_current_idx", (dev.cur()-1L), 0L)[[2]]
void get_current_idx(int *dn, int *res) {
	pGEDevDesc dev= GEgetDevice(*dn);
	if (dev) {
		DOCDesc *pd = (DOCDesc *) dev->dev->deviceSpecific;
		*res = pd->id;
	} else *res = -1;
}

int get_and_increment_idx(pDevDesc dev) {
	DOCDesc *pd = (DOCDesc *) dev->deviceSpecific;
	int id = pd->id;
	pd->id++;
	return id;
}

void SetFillColor(pDevDesc dev, R_GE_gcontext *gc) {
	DOCDesc *xd = (DOCDesc *) dev->deviceSpecific;
	int alpha =  (int) (R_ALPHA(gc->fill)/255.0 * 100000);
	if (alpha > 0) {
		fprintf(xd->dmlFilePointer,
			"<a:solidFill><a:srgbClr val=\"%s\"><a:alpha val=\"%d\" /></a:srgbClr></a:solidFill>",
			RGBHexValue(gc->fill), alpha);
	}
}

void SetFontColor(pDevDesc dev, R_GE_gcontext *gc) {
	DOCDesc *xd = (DOCDesc *) dev->deviceSpecific;

	int alpha =  (int) (R_ALPHA(gc->col)/255.0 * 100000);

	if (alpha > 0) {
		fprintf(xd->dmlFilePointer,
			"<a:solidFill><a:srgbClr val=\"%s\"><a:alpha val=\"%d\" /></a:srgbClr></a:solidFill>",
			RGBHexValue(gc->col), alpha);
	}
}

void SetLineSpec(pDevDesc dev, R_GE_gcontext *gc) {
	DOCDesc *xd = (DOCDesc *) dev->deviceSpecific;

	int alpha =  (int) (R_ALPHA(gc->col)/255.0 * 100000);

	if (gc->lty > -1 && gc->lwd > 0.0 && alpha > 0) {
		fprintf(xd->dmlFilePointer, "<a:ln w=\"%.0f\">", p2e_(gc->lwd * 72 / 96));

		fprintf(xd->dmlFilePointer,
				"<a:solidFill><a:srgbClr val=\"%s\"><a:alpha val=\"%d\" /></a:srgbClr></a:solidFill>",
				RGBHexValue(gc->col), alpha);

		switch (gc->lty) {
		case LTY_BLANK:
			break;
		case LTY_SOLID:
			fprintf(xd->dmlFilePointer, "<a:prstDash val=\"solid\" />");
			break;
		case LTY_DOTTED:
			fprintf(xd->dmlFilePointer, "<a:prstDash val=\"dot\" />");
			break;
		case LTY_DASHED:
			fprintf(xd->dmlFilePointer, "<a:prstDash val=\"dash\" />");
			break;
		case LTY_LONGDASH:
			fprintf(xd->dmlFilePointer, "<a:prstDash val=\"lgDash\" />");
			break;
		case LTY_DOTDASH:
			fprintf(xd->dmlFilePointer, "<a:prstDash val=\"dashDot\" />");
			break;
		case LTY_TWODASH:
			fprintf(xd->dmlFilePointer, "<a:prstDash val=\"lgDash\" />");
			break;
		default:
			fprintf(xd->dmlFilePointer, "<a:prstDash val=\"solid\" />");
			break;
		}

		switch (gc->ljoin) {
		case GE_ROUND_JOIN: //round
			fprintf(xd->dmlFilePointer, "<a:round />");
			break;
		case GE_MITRE_JOIN: //mitre
			fprintf(xd->dmlFilePointer, "<a:miter/>");
			break;
		case GE_BEVEL_JOIN: //bevel
			fprintf(xd->dmlFilePointer, "<a:bevel />");
			break;
		default:
			fprintf(xd->dmlFilePointer, "<a:round />");
			break;
		}
		fprintf(xd->dmlFilePointer, "</a:ln>");
	}
}



void RAPHAEL_SetLineSpec(pDevDesc dev, R_GE_gcontext *gc, int idx) {
	DOCDesc *xd = (DOCDesc *) dev->deviceSpecific;
	char *saved_locale;
	saved_locale = setlocale(LC_NUMERIC, "C");

	float alpha =  R_ALPHA(gc->col)/255.0;
	fprintf(xd->dmlFilePointer, "elt_%d.attr({", idx);

	if (gc->lty > -1 && gc->lwd > 0.0 && alpha > 0) {
		fprintf(xd->dmlFilePointer, "'stroke': \"#%s\"", RGBHexValue(gc->col) );
		fprintf(xd->dmlFilePointer, ", 'stroke-opacity': \"%.3f\"", alpha );

		fprintf(xd->dmlFilePointer, ", 'stroke-width': %.3f", gc->lwd );

		switch (gc->lty) {
		case LTY_BLANK:
			break;
		case LTY_SOLID:
			break;
		case LTY_DOTTED:
			fprintf(xd->dmlFilePointer, ", 'stroke-dasharray': \".\"" );
			break;
		case LTY_DASHED:
			fprintf(xd->dmlFilePointer, ", 'stroke-dasharray': \"-\"" );
			break;
		case LTY_LONGDASH:
			fprintf(xd->dmlFilePointer, ", 'stroke-dasharray': \"--\"" );
			break;
		case LTY_DOTDASH:
			fprintf(xd->dmlFilePointer, ", 'stroke-dasharray': \"-.\"" );
			break;
		case LTY_TWODASH:
			fprintf(xd->dmlFilePointer, ", 'stroke-dasharray': \"--\"" );
			break;
		default:
			break;
		}

		switch (gc->ljoin) {
		case GE_ROUND_JOIN: //round
			fprintf(xd->dmlFilePointer, ", 'stroke-linejoin': \"round\"" );
			break;
		case GE_MITRE_JOIN: //mitre
			fprintf(xd->dmlFilePointer, ", 'stroke-linejoin': \"miter\"" );
			break;
		case GE_BEVEL_JOIN: //bevel
			fprintf(xd->dmlFilePointer, ", 'stroke-linejoin': \"bevel\"" );
			break;
		default:
			fprintf(xd->dmlFilePointer, ", 'stroke-linejoin': \"round\"" );
			break;
		}
	} else {
		fprintf(xd->dmlFilePointer, "'stroke-width': 0" );
	}
	fprintf(xd->dmlFilePointer, "});\n");
	setlocale(LC_NUMERIC, saved_locale);

}

void RAPHAEL_SetFillColor(pDevDesc dev, R_GE_gcontext *gc, int idx) {
	DOCDesc *xd = (DOCDesc *) dev->deviceSpecific;
	char *saved_locale;
	saved_locale = setlocale(LC_NUMERIC, "C");
	fprintf(xd->dmlFilePointer, "elt_%d.attr({", idx);

	float alpha =  R_ALPHA(gc->fill)/255.0;
	if (alpha > 0) {
		fprintf(xd->dmlFilePointer, "'fill': \"#%s\"", RGBHexValue(gc->fill) );
		fprintf(xd->dmlFilePointer, ",'fill-opacity': \"%.3f\"", alpha );
	}
	fprintf(xd->dmlFilePointer, "});\n");
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
			fprintf(pd->dmlFilePointer, ", 'font-weight': \"bold\"");
		} else if (gc->fontface == 3) {
			fprintf(pd->dmlFilePointer, ", 'font-style'=\"italic\"");
		} else if (gc->fontface == 4) {
			fprintf(pd->dmlFilePointer, ", 'font-weight': \"bold\", 'font-style'=\"italic\"");
		}
		fprintf(pd->dmlFilePointer, "});\n");


	}

	setlocale(LC_NUMERIC, saved_locale);

}

