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

#include <stdio.h>
#include <Rinternals.h>
#include <R.h>

#include <R_ext/GraphicsEngine.h>
#include <R_ext/GraphicsDevice.h>

#include "datastruct.h"
#include "colors.h"

double p2e_(double x) {
	double y = x * 12700;
	return y;
}

char* get_dml_filename(char* filename, int index){
	char *buf;
	int len = snprintf(NULL, 0, "%s_%03d.dml", filename, index);
	buf = (char*)malloc( (len + 1) * sizeof(char) );
	sprintf(buf, "%s_%03d.dml", filename, index);

	return buf;
}


void DML_SetFillColor(pDevDesc dev, R_GE_gcontext *gc) {
	DOCDesc *pd = (DOCDesc *) dev->deviceSpecific;
	int alpha =  (int) (R_ALPHA(gc->fill)/255.0 * 100000);
	if (alpha > 0) {
		fprintf(pd->dmlFilePointer,
			"<a:solidFill><a:srgbClr val=\"%s\"><a:alpha val=\"%d\" /></a:srgbClr></a:solidFill>",
			RGBHexValue(gc->fill), alpha);
	}
}

void DML_SetFontColor(pDevDesc dev, R_GE_gcontext *gc) {
	DOCDesc *pd = (DOCDesc *) dev->deviceSpecific;

	int alpha =  (int) (R_ALPHA(gc->col)/255.0 * 100000);

	if (alpha > 0) {
		fprintf(pd->dmlFilePointer,
			"<a:solidFill><a:srgbClr val=\"%s\"><a:alpha val=\"%d\" /></a:srgbClr></a:solidFill>",
			RGBHexValue(gc->col), alpha);
	}
}

void DML_SetLineSpec(pDevDesc dev, R_GE_gcontext *gc) {
	DOCDesc *pd = (DOCDesc *) dev->deviceSpecific;

	int alpha =  (int) (R_ALPHA(gc->col)/255.0 * 100000);

	if (gc->lty > -1 && gc->lwd > 0.0 && alpha > 0) {
		fprintf(pd->dmlFilePointer, "<a:ln w=\"%.0f\">", p2e_(gc->lwd * 72 / 96));

		fprintf(pd->dmlFilePointer,
				"<a:solidFill><a:srgbClr val=\"%s\"><a:alpha val=\"%d\" /></a:srgbClr></a:solidFill>",
				RGBHexValue(gc->col), alpha);

		switch (gc->lty) {
		case LTY_BLANK:
			break;
		case LTY_SOLID:
			fputs("<a:prstDash val=\"solid\" />", pd->dmlFilePointer );
			break;
		case LTY_DOTTED:
			fputs("<a:prstDash val=\"dot\" />", pd->dmlFilePointer );
			break;
		case LTY_DASHED:
			fputs("<a:prstDash val=\"dash\" />", pd->dmlFilePointer );
			break;
		case LTY_LONGDASH:
			fputs("<a:prstDash val=\"lgDash\" />", pd->dmlFilePointer );
			break;
		case LTY_DOTDASH:
			fputs("<a:prstDash val=\"dashDot\" />", pd->dmlFilePointer );
			break;
		case LTY_TWODASH:
			fputs("<a:prstDash val=\"lgDash\" />", pd->dmlFilePointer );
			break;
		default:
			fputs("<a:prstDash val=\"solid\" />", pd->dmlFilePointer );
			break;
		}

		switch (gc->ljoin) {
		case GE_ROUND_JOIN: //round
			fputs("<a:round />", pd->dmlFilePointer );
			break;
		case GE_MITRE_JOIN: //mitre
			fputs("<a:miter/>", pd->dmlFilePointer );
			break;
		case GE_BEVEL_JOIN: //bevel
			fputs("<a:bevel />", pd->dmlFilePointer );
			break;
		default:
			fputs("<a:round />", pd->dmlFilePointer );
			break;
		}
		fputs("</a:ln>", pd->dmlFilePointer );
	}
}

void dml_text(const char *str, DOCDesc *pd){
    for( ; *str ; str++)
	switch(*str) {
	case '<':
		fprintf(pd->dmlFilePointer, "&lt;");
	    break;
	case '>':
		fprintf(pd->dmlFilePointer, "&gt;");
	    break;
	case '&':
		fprintf(pd->dmlFilePointer, "&amp;");
	    break;
	default:
	    fputc(*str, pd->dmlFilePointer);
	    break;
	}
}

void dml_textUTF8(const char *str, DOCDesc *pd){
	unsigned char *p;
	p = (unsigned char *) str;
	int val, val1, val2, val3, val4;
	while(*p){
		val = *(p++);
		if( val < 128 ){ /* ASCII */
			fprintf(pd->dmlFilePointer, "&#%d;", val);
		} else if( val > 240 ){
			val1 = (val - 240) * 65536;
			val = *(p++);
			val2 = (val - 128) * 4096;
			val = *(p++);
			val3 = (val - 128) * 64;
			val = *(p++);
			val4 = val - 128;
			fprintf(pd->dmlFilePointer, "&#%d;", val1+val2+val3+val4);
		} else {
			if( val >= 224 ){ /* 3 octets : 224 = 128+64+32 */
				val1 = (val - 224) * 4096;
				val = *(p++);
				val2 = (val-128) * 64;
				val = *(p++);
				val3 = (val-128);
				fprintf(pd->dmlFilePointer, "&#%d;", val1 + val2 + val3);
			} else { /* 2 octets : >192 = 128+64 */
				val1 = (val - 192) * 64;
				val = *(p++);
				val2 = val-128;
				fprintf(pd->dmlFilePointer, "&#%d;", val1+val2);
			}

		}
	}
}

double translate_rotate_x(double x, double y, double rot, double height, double width, double hadj) {
	double pi = 3.141592653589793115997963468544185161590576171875;
	double alpha = -rot * pi / 180;

	double Px = x + (0.5-hadj) * width;
	double Py = y - 0.5 * height;

	double _cos = cos( alpha );
	double _sin = sin( alpha );

	return x + (Px-x) * _cos - (Py-y) * _sin;
}
double translate_rotate_y(double x, double y, double rot, double height, double width, double hadj) {
	double pi = 3.141592653589793115997963468544185161590576171875;
	double alpha = -rot * pi / 180;

	double Px = x + (0.5-hadj) * width;
	double Py = y - 0.25 * height;

	double _cos = cos( alpha );
	double _sin = sin( alpha );

	return y + (Px-x) * _sin + (Py-y) * _cos;
}

double getStrWidth(const char *str, double w) {

	if( strlen(str) < 6 ) w+= w / strlen(str);
	else if( strlen(str) < 15 ) w+= 2 * w / strlen(str);
	else if( strlen(str) < 30 ) w+= 4 * w / strlen(str);
	else if( strlen(str) < 45 ) w+= 5 * w / strlen(str);
	else w+= 6 * w / strlen(str);

	return w;
}
