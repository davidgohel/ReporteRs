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

#include <string.h>
#include <stdio.h>
#include <math.h>

#define R_USE_PROTOTYPES 1


#include "datastruct.h"
#include "utils.h"
#include "common.h"
#include "PPTX.h"

static char pptx_elt_tag_start[] = "<p:sp>";
static char pptx_elt_tag_end[] = "</p:sp>";

static char pptx_lock_properties[] = "<p:cNvSpPr><a:spLocks noSelect=\"1\" noResize=\"1\" noEditPoints=\"1\" noTextEdit=\"1\" noMove=\"1\" noRot=\"1\" noChangeShapeType=\"1\"/></p:cNvSpPr><p:nvPr />";
static char pptx_unlock_properties[] = "<p:cNvSpPr/><p:nvPr />";



static Rboolean PPTXDeviceDriver(pDevDesc dev, const char* filename, double* width,
		double* height, double* offx, double* offy, double ps, int nbplots,
		const char* fontname, SEXP env) {


	DOCDesc *rd;
	rd = (DOCDesc *) malloc(sizeof(DOCDesc));

	FontInfo *fi = (FontInfo *) malloc(sizeof(FontInfo));
	fi->isinit=0;
	fi->fontsize=(int) ps;
	rd->fi = fi;

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
	dev->activate = PPTX_activate;
	dev->close = PPTX_Close;
	dev->size = PPTX_Size;
	dev->newPage = PPTX_NewPage;
	dev->clip = PPTX_Clip;
	dev->strWidth = PPTX_StrWidth;
	dev->text = PPTX_Text;
	dev->rect = PPTX_Rect;
	dev->circle = PPTX_Circle;
	dev->line = PPTX_Line;
	dev->polyline = PPTX_Polyline;
	dev->polygon = PPTX_Polygon;
	dev->metricInfo = PPTX_MetricInfo;
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

	rd->editable = getEditable(dev);

	return (Rboolean) TRUE;
}


void GE_PPTXDevice(const char* filename, double* width, double* height, double* offx,
		double* offy, double ps, int nbplots, const char* fontfamily, SEXP env) {
	pDevDesc dev = NULL;
	pGEDevDesc dd;
	R_GE_checkVersionOrDie (R_GE_version);
	R_CheckDeviceAvailable();

	if (!(dev = (pDevDesc) calloc(1, sizeof(DevDesc))))
		Rf_error("unable to start PPTX device");
	if (!PPTXDeviceDriver(dev, filename, width, height, offx, offy, ps, nbplots,
			fontfamily, env)) {
		free(dev);
		Rf_error("unable to start PPTX device");
	}

	dd = GEcreateDevDesc(dev);
	GEaddDevice2(dd, "PPTX");

}

static void PPTX_activate(pDevDesc dev) {

}

static void PPTX_Circle(double x, double y, double r, const pGEcontext gc,
		pDevDesc dev) {
	DOCDesc *pd = (DOCDesc *) dev->deviceSpecific;
	int idx = get_idx(dev);

	fprintf(pd->dmlFilePointer, pptx_elt_tag_start);
	if( pd->editable < 1 )
		fprintf(pd->dmlFilePointer,
			"<p:nvSpPr><p:cNvPr id=\"%d\" name=\"Point %d\" />%s</p:nvSpPr>", idx, idx, pptx_lock_properties);
	else fprintf(pd->dmlFilePointer,
			"<p:nvSpPr><p:cNvPr id=\"%d\" name=\"Point %d\" />%s</p:nvSpPr>", idx, idx, pptx_unlock_properties);
	fprintf(pd->dmlFilePointer, "<p:spPr><a:xfrm>");
	fprintf(pd->dmlFilePointer, "<a:off x=\"%.0f\" y=\"%.0f\"/>",
			p2e_(pd->offx + x - r), p2e_(pd->offy + y - r));
	fprintf(pd->dmlFilePointer, "<a:ext cx=\"%.0f\" cy=\"%.0f\"/>", p2e_(r * 2),
			p2e_(r * 2));
	fprintf(pd->dmlFilePointer,
			"</a:xfrm><a:prstGeom prst=\"ellipse\"><a:avLst /></a:prstGeom>");
	SetLineSpec(dev, gc);
	SetFillColor(dev, gc);
	fprintf(pd->dmlFilePointer, "</p:spPr>");

	fprintf(pd->dmlFilePointer,
			"<p:txBody><a:bodyPr /><a:lstStyle /><a:p/></p:txBody>");
	fprintf(pd->dmlFilePointer, pptx_elt_tag_end);

	fflush(pd->dmlFilePointer);
}

static void PPTX_Line(double x1, double y1, double x2, double y2,
		const pGEcontext gc, pDevDesc dev) {
	DOCDesc *pd = (DOCDesc *) dev->deviceSpecific;
	int idx = get_idx(dev);

	double temp;
	if( y1 > y2 ){
		temp = y1;
		y1 = y2;
		y2 = temp;
	}
	if( x1 > x2 ){
		temp = x1;
		x1 = x2;
		x2 = temp;
	}
	fprintf(pd->dmlFilePointer, pptx_elt_tag_start);
	if( pd->editable < 1 )
		fprintf(pd->dmlFilePointer,
			"<p:nvSpPr><p:cNvPr id=\"%d\" name=\"Line %d\" />%s</p:nvSpPr>", idx, idx, pptx_lock_properties);
	else fprintf(pd->dmlFilePointer,
		"<p:nvSpPr><p:cNvPr id=\"%d\" name=\"Line %d\" />%s</p:nvSpPr>", idx, idx, pptx_unlock_properties);

	fprintf(pd->dmlFilePointer, "<p:spPr><a:xfrm>");
	fprintf(pd->dmlFilePointer, "<a:off x=\"%.0f\" y=\"%.0f\"/>",
			p2e_(pd->offx + x1), p2e_(pd->offy + y1));
	fprintf(pd->dmlFilePointer, "<a:ext cx=\"%.0f\" cy=\"%.0f\"/>", p2e_(x2-x1), p2e_(y2-y1));

	fprintf(pd->dmlFilePointer, "</a:xfrm><a:custGeom><a:avLst />");
	fprintf(pd->dmlFilePointer, "<a:pathLst>");
	fprintf(pd->dmlFilePointer, "<a:path w=\"%.0f\" h=\"%.0f\">", p2e_(x2 - x1), p2e_(y2 - y1));
	fprintf(pd->dmlFilePointer,
			"<a:moveTo><a:pt x=\"%.0f\" y=\"%.0f\" /></a:moveTo>", 0.0, 0.0);
	fprintf(pd->dmlFilePointer,
			"<a:lnTo><a:pt x=\"%.0f\" y=\"%.0f\" /></a:lnTo>", p2e_(x2 - x1),
			p2e_(y2 - y1));
	fprintf(pd->dmlFilePointer, "</a:path></a:pathLst>");

	fprintf(pd->dmlFilePointer, "</a:custGeom>");
	SetLineSpec(dev, gc);
	fprintf(pd->dmlFilePointer, "</p:spPr>");

	fprintf(pd->dmlFilePointer,
			"<p:txBody><a:bodyPr /><a:lstStyle /><a:p/></p:txBody>");
	fprintf(pd->dmlFilePointer, pptx_elt_tag_end);
	fprintf(pd->dmlFilePointer, "\n");

	fflush(pd->dmlFilePointer);

	//return;
}

static void PPTX_Polyline(int n, double *x, double *y, const pGEcontext gc,
		pDevDesc dev) {
//	Rprintf("PPTX_Polyline\n");

	DOCDesc *pd = (DOCDesc *) dev->deviceSpecific;
	int idx = get_idx(dev);
	int i;
	double maxx = 0, maxy = 0;
	for (i = 0; i < n; i++) {
		if (x[i] > maxx)
			maxx = x[i];
		if (y[i] > maxy)
			maxy = y[i];
	}
	double minx = maxx, miny = maxy;

	for (i = 0; i < n; i++) {
		if (x[i] < minx)
			minx = x[i];
		if (y[i] < miny)
			miny = y[i];
	}

	fprintf(pd->dmlFilePointer, pptx_elt_tag_start);
	if( pd->editable < 1 )
		fprintf(pd->dmlFilePointer,
			"<p:nvSpPr><p:cNvPr id=\"%d\" name=\"Polyline form %d\" />%s</p:nvSpPr>", idx, idx, pptx_lock_properties);
	else fprintf(pd->dmlFilePointer,
			"<p:nvSpPr><p:cNvPr id=\"%d\" name=\"Polyline form %d\" />%s</p:nvSpPr>", idx, idx, pptx_unlock_properties);

	fprintf(pd->dmlFilePointer, "<p:spPr><a:xfrm>");
	fprintf(pd->dmlFilePointer, "<a:off x=\"%.0f\" y=\"%.0f\"/>",
			p2e_(pd->offx + minx), p2e_(pd->offy + miny));
	fprintf(pd->dmlFilePointer, "<a:ext cx=\"%.0f\" cy=\"%.0f\"/>", p2e_(maxx-minx), p2e_(maxy-miny));
	fprintf(pd->dmlFilePointer, "</a:xfrm><a:custGeom><a:avLst />");
	//fprintf(pd->dmlFilePointer, "<a:pathLst><a:path w=\"%ld\" h=\"%ld\">", pd->extx, pd->exty);
	fprintf(pd->dmlFilePointer, "<a:pathLst>");
	fprintf(pd->dmlFilePointer, "<a:path w=\"%.0f\" h=\"%.0f\">", p2e_(maxx-minx), p2e_(maxy-miny));
	fprintf(pd->dmlFilePointer,
			"<a:moveTo><a:pt x=\"%.0f\" y=\"%.0f\" /></a:moveTo>",
			p2e_(x[0] - minx), p2e_(y[0] - miny));
	for (i = 1; i < n; i++) {
		fprintf(pd->dmlFilePointer,
				"<a:lnTo><a:pt x=\"%.0f\" y=\"%.0f\" /></a:lnTo>",
				p2e_(x[i] - minx), p2e_(y[i] - miny));
	}
	//fprintf(pd->dmlFilePointer, "<a:close/></a:path></a:pathLst>");
	fprintf(pd->dmlFilePointer, "</a:path></a:pathLst>");
	fprintf(pd->dmlFilePointer, "</a:custGeom>");
	//SetFillColor(dev, gc);
	SetLineSpec(dev, gc);
	fprintf(pd->dmlFilePointer, "</p:spPr>");

	fprintf(pd->dmlFilePointer,
			"<p:txBody><a:bodyPr /><a:lstStyle /><a:p/></p:txBody>");
	fprintf(pd->dmlFilePointer, pptx_elt_tag_end);
	fprintf(pd->dmlFilePointer, "\n");
	fflush(pd->dmlFilePointer);

}

static void PPTX_Polygon(int n, double *x, double *y, const pGEcontext gc,
		pDevDesc dev) {

	DOCDesc *pd = (DOCDesc *) dev->deviceSpecific;
	int idx = get_idx(dev);
	int i;
	double maxx = 0, maxy = 0;
	for (i = 0; i < n; i++) {
		if (x[i] > maxx)
			maxx = x[i];
		if (y[i] > maxy)
			maxy = y[i];
	}
	double minx = maxx, miny = maxy;

	for (i = 0; i < n; i++) {
		if (x[i] < minx)
			minx = x[i];
		if (y[i] < miny)
			miny = y[i];
	}

	fprintf(pd->dmlFilePointer, pptx_elt_tag_start);

	if( pd->editable < 1 )
		fprintf(pd->dmlFilePointer,
			"<p:nvSpPr><p:cNvPr id=\"%d\" name=\"Polygon form %d\" />%s</p:nvSpPr>", idx, idx, pptx_lock_properties);
	else fprintf(pd->dmlFilePointer,
			"<p:nvSpPr><p:cNvPr id=\"%d\" name=\"Polygon form %d\" />%s</p:nvSpPr>", idx, idx, pptx_unlock_properties);
	fprintf(pd->dmlFilePointer, "<p:spPr><a:xfrm>");
	fprintf(pd->dmlFilePointer, "<a:off x=\"%.0f\" y=\"%.0f\"/>",
			p2e_(pd->offx + minx), p2e_(pd->offy + miny));
	fprintf(pd->dmlFilePointer, "<a:ext cx=\"%.0f\" cy=\"%.0f\"/>", p2e_(maxx-minx), p2e_(maxy-miny));
	fprintf(pd->dmlFilePointer, "</a:xfrm><a:custGeom><a:avLst />");
	//fprintf(pd->dmlFilePointer, "<a:pathLst><a:path w=\"%ld\" h=\"%ld\">", pd->extx, pd->exty);
	fprintf(pd->dmlFilePointer, "<a:pathLst>");
	fprintf(pd->dmlFilePointer, "<a:path w=\"%.0f\" h=\"%.0f\">", p2e_(maxx-minx), p2e_(maxy-miny));
	fprintf(pd->dmlFilePointer,
			"<a:moveTo><a:pt x=\"%.0f\" y=\"%.0f\" /></a:moveTo>",
			p2e_(x[0] - minx), p2e_(y[0] - miny));
	for (i = 1; i < n; i++) {
		fprintf(pd->dmlFilePointer,
				"<a:lnTo><a:pt x=\"%.0f\" y=\"%.0f\" /></a:lnTo>",
				p2e_(x[i] - minx), p2e_(y[i] - miny));
	}
	fprintf(pd->dmlFilePointer, "<a:close/></a:path></a:pathLst>");

	fprintf(pd->dmlFilePointer, "</a:custGeom>");
	SetFillColor(dev, gc);
	SetLineSpec(dev, gc);
	fprintf(pd->dmlFilePointer, "</p:spPr>");

	fprintf(pd->dmlFilePointer,
			"<p:txBody><a:bodyPr /><a:lstStyle /><a:p/></p:txBody>");
	fprintf(pd->dmlFilePointer, pptx_elt_tag_end);
	fprintf(pd->dmlFilePointer, "\n");
	fflush(pd->dmlFilePointer);

}

static void PPTX_Rect(double x0, double y0, double x1, double y1,
		const pGEcontext gc, pDevDesc dev) {
	double tmp;
	DOCDesc *pd = (DOCDesc *) dev->deviceSpecific;
	int idx = get_idx(dev);

	if (x0 >= x1) {
		tmp = x0;
		x0 = x1;
		x1 = tmp;
	}

	if (y0 >= y1) {
		tmp = y0;
		y0 = y1;
		y1 = tmp;
	}

	fprintf(pd->dmlFilePointer, pptx_elt_tag_start);

	if( pd->editable < 1 )
		fprintf(pd->dmlFilePointer,
			"<p:nvSpPr><p:cNvPr id=\"%d\" name=\"Rectangle %d\" />%s</p:nvSpPr>", idx, idx, pptx_lock_properties);
	else fprintf(pd->dmlFilePointer,
			"<p:nvSpPr><p:cNvPr id=\"%d\" name=\"Rectangle %d\" />%s</p:nvSpPr>", idx, idx, pptx_unlock_properties);
	fprintf(pd->dmlFilePointer, "<p:spPr><a:xfrm>");
	fprintf(pd->dmlFilePointer, "<a:off x=\"%.0f\" y=\"%.0f\"/>",
			p2e_(pd->offx + x0), p2e_(pd->offy + y0));
	fprintf(pd->dmlFilePointer, "<a:ext cx=\"%.0f\" cy=\"%.0f\"/>",
			p2e_(x1 - x0), p2e_(y1 - y0));
	fprintf(pd->dmlFilePointer,
			"</a:xfrm><a:prstGeom prst=\"rect\"><a:avLst /></a:prstGeom>");
	SetFillColor(dev, gc);
	SetLineSpec(dev, gc);
	fprintf(pd->dmlFilePointer, "</p:spPr>");

	fprintf(pd->dmlFilePointer,
			"<p:txBody><a:bodyPr /><a:lstStyle /><a:p/></p:txBody>");
	fprintf(pd->dmlFilePointer, pptx_elt_tag_end);
	fprintf(pd->dmlFilePointer, "\n");
	fflush(pd->dmlFilePointer);

}


static void PPTX_Text(double x, double y, const char *str, double rot,
		double hadj, const pGEcontext gc, pDevDesc dev) {

	DOCDesc *pd = (DOCDesc *) dev->deviceSpecific;
	int idx = get_idx(dev);

	double pi = 3.141592653589793115997963468544185161590576171875;
	double w = PPTX_StrWidth(str, gc, dev);
	if( strlen(str) < 3 ) w+= 1 * w / strlen(str);
	else w += 3 * w / strlen(str);
	double h = getFontSize(gc->cex, gc->ps, gc->lineheight);
	if( h < 1.0 ) return;

	double fontsize = h * 100;

	/* translate and rotate ops */
	//http://www.win.tue.nl/~vanwijk/2IV60/2IV60_3_2D_transformations.pdf
	//http://www.youtube.com/watch?v=otCpCn0l4Wo
	double alpha = -rot * pi / 180;
	double height = h ;
	double Qx = x;
	double Qy = y ;
	double Px = x + (0.5-hadj) * w;
	double Py = y - 0.5 * height;
	double _cos = cos( alpha );
	double _sin = sin( alpha );

	double Ppx = Qx + (Px-Qx) * _cos - (Py-Qy) * _sin ;
	double Ppy = Qy + (Px-Qx) * _sin + (Py-Qy) * _cos;

	double corrected_offx = Ppx - 0.5 * w;
	double corrected_offy = Ppy - 0.5 * h;
	//////////////

	fprintf(pd->dmlFilePointer, pptx_elt_tag_start);

	if( pd->editable < 1 )
		fprintf(pd->dmlFilePointer,
			"<p:nvSpPr><p:cNvPr id=\"%d\" name=\"Text %d\" />%s</p:nvSpPr>", idx, idx, pptx_lock_properties);
	else fprintf(pd->dmlFilePointer,
				"<p:nvSpPr><p:cNvPr id=\"%d\" name=\"Text %d\" />%s</p:nvSpPr>", idx, idx, pptx_unlock_properties);
	fprintf(pd->dmlFilePointer, "<p:spPr>");
	fprintf(pd->dmlFilePointer, "<a:xfrm rot=\"%.0f\">", (-rot) * 60000);
	fprintf(pd->dmlFilePointer, "<a:off x=\"%.0f\" y=\"%.0f\"/>",
			p2e_(pd->offx + corrected_offx), p2e_(pd->offy + corrected_offy));
	fprintf(pd->dmlFilePointer, "<a:ext cx=\"%.0f\" cy=\"%.0f\"/>",
			p2e_(w), p2e_(h));
	fprintf(pd->dmlFilePointer, "</a:xfrm>");
	fprintf(pd->dmlFilePointer,
			"<a:prstGeom prst=\"rect\"><a:avLst /></a:prstGeom>");
	fprintf(pd->dmlFilePointer, "<a:noFill />");
	fprintf(pd->dmlFilePointer, "</p:spPr>");

	fprintf(pd->dmlFilePointer, "<p:txBody>");
	fprintf(pd->dmlFilePointer,
			"<a:bodyPr lIns=\"0\" tIns=\"0\" rIns=\"0\" bIns=\"0\"");
	fprintf(pd->dmlFilePointer, " anchor=\"b\">");
	fprintf(pd->dmlFilePointer, "<a:spAutoFit />");
	fprintf(pd->dmlFilePointer, "</a:bodyPr><a:lstStyle /><a:p>");
	fprintf(pd->dmlFilePointer, "<a:pPr");

	if (hadj < 0.25)
		fprintf(pd->dmlFilePointer, " algn=\"l\"");
	else if (hadj < 0.75)
		fprintf(pd->dmlFilePointer, " algn=\"ctr\"");
	else
		fprintf(pd->dmlFilePointer, " algn=\"r\"");
	fprintf(pd->dmlFilePointer, " marL=\"0\" marR=\"0\" indent=\"0\" >");
	fprintf(pd->dmlFilePointer, "<a:lnSpc><a:spcPts val=\"%.0f\"/></a:lnSpc>",fontsize);
	fprintf(pd->dmlFilePointer, "<a:spcBef><a:spcPts val=\"0\"/></a:spcBef>");
	fprintf(pd->dmlFilePointer, "<a:spcAft><a:spcPts val=\"0\"/></a:spcAft>");

	fprintf(pd->dmlFilePointer, "</a:pPr>");
	fprintf(pd->dmlFilePointer, "<a:r>");
	fprintf(pd->dmlFilePointer, "<a:rPr sz=\"%.0f\"", fontsize);
	if (gc->fontface == 2) {
		fprintf(pd->dmlFilePointer, " b=\"1\"");
	} else if (gc->fontface == 3) {
		fprintf(pd->dmlFilePointer, " i=\"1\"");
	} else if (gc->fontface == 4) {
		fprintf(pd->dmlFilePointer, " b=\"1\" i=\"1\"");
	}

	fprintf(pd->dmlFilePointer, ">");
	SetFontColor(dev, gc);

	fprintf(pd->dmlFilePointer,
				"<a:latin typeface=\"%s\"/><a:cs typeface=\"%s\"/>",
				pd->fi->fontname, pd->fi->fontname);

	fprintf(pd->dmlFilePointer, "</a:rPr>");

	fprintf(pd->dmlFilePointer, "<a:t>%s</a:t></a:r></a:p></p:txBody>", str);
	fprintf(pd->dmlFilePointer, pptx_elt_tag_end);
	fprintf(pd->dmlFilePointer, "\n");

	fflush(pd->dmlFilePointer);
}

static void PPTX_NewPage(const pGEcontext gc, pDevDesc dev) {
	DOCDesc *pd = (DOCDesc *) dev->deviceSpecific;
	if (pd->pageNumber > 0) {
		closeFile(pd->dmlFilePointer);
	}

	int which = pd->pageNumber % pd->maxplot;
	pd->pageNumber++;

	update_start_id(dev);

	dev->right = pd->width[which];
	dev->bottom = pd->height[which];
	pd->offx = pd->x[which];
	pd->offy = pd->y[which];
	pd->extx = pd->width[which];
	pd->exty = pd->height[which];

	char *str={0};
	str = getFilename(pd->filename, pd->pageNumber);
	pd->dmlFilePointer = (FILE *) fopen(str, "w");

	if (pd->dmlFilePointer == NULL) {
		Rf_error("error while opening %s\n", str);
	}
	updateFontInfo(dev, gc);
	free(str);
}
static void PPTX_Close(pDevDesc dev) {
	DOCDesc *pd = (DOCDesc *) dev->deviceSpecific;
	update_start_id(dev);
	closeFile(pd->dmlFilePointer);
	free(pd);
}

static void PPTX_Clip(double x0, double x1, double y0, double y1, pDevDesc dev) {
}

static void PPTX_MetricInfo(int c, const pGEcontext gc, double* ascent,
		double* descent, double* width, pDevDesc dev) {
	DOC_MetricInfo(c, gc, ascent, descent, width, dev);
}

static void PPTX_Size(double *left, double *right, double *bottom, double *top,
		pDevDesc dev) {
	*left = dev->left;
	*right = dev->right;
	*bottom = dev->bottom;
	*top = dev->top;
}


static double PPTX_StrWidth(const char *str, const pGEcontext gc, pDevDesc dev) {
	return DOC_StrWidth(str, gc, dev);
}



SEXP R_PPTX_Device(SEXP filename
		, SEXP width, SEXP height, SEXP offx,
		SEXP offy, SEXP pointsize, SEXP fontfamily, SEXP env) {

	double* w = REAL(width);
	double* h = REAL(height);

	double* x = REAL(offx);
	double* y = REAL(offy);
	int nx = length(width);

	double ps = asReal(pointsize);

	BEGIN_SUSPEND_INTERRUPTS;
	GE_PPTXDevice(CHAR(STRING_ELT(filename, 0)), w, h, x, y, ps, nx, CHAR(STRING_ELT(fontfamily, 0)), env);
	END_SUSPEND_INTERRUPTS;
	return R_NilValue;
}
