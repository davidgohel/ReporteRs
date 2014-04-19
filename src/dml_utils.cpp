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


double p2e_(double x) {
	double y = x * 12700;
	return y;
}

char* getFilename(char* filename, int index){
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



