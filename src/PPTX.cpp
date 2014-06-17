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

#define R_USE_PROTOTYPES 1

#include "datastruct.h"
#include "dml_utils.h"
#include "common.h"
#include "PPTX.h"
#include "utils.h"

static char pptx_elt_tag_start[] = "<p:sp>";
static char pptx_elt_tag_end[] = "</p:sp>";

static char pptx_lock_properties[] = "<p:cNvSpPr><a:spLocks noSelect=\"1\" noResize=\"1\" noEditPoints=\"1\" noTextEdit=\"1\" noMove=\"1\" noRot=\"1\" noChangeShapeType=\"1\"/></p:cNvSpPr><p:nvPr />";
static char pptx_unlock_properties[] = "<p:cNvSpPr/><p:nvPr />";


/* Draw To */

static void PicTeX_ClipLine(double x0, double y0, double x1, double y1,
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
//		Rprintf("%%\tClipping Left 1\n");
		ptd->clippedy0 = ((ptd->clippedy1-ptd->clippedy0) /
				(ptd->clippedx1-ptd->clippedx0) *
				(dev->clipLeft-ptd->clippedx0)) +
						ptd->clippedy0;
		ptd->clippedx0 = dev->clipLeft;
	}
	if (ptd->clippedx1 <= dev->clipLeft && ptd->clippedx0 > dev->clipLeft) {
//		Rprintf("%%\tClipping Left 2\n");
		ptd->clippedy1 = ((ptd->clippedy1-ptd->clippedy0) /
				(ptd->clippedx1-ptd->clippedx0) *
				(dev->clipLeft-ptd->clippedx0)) +
						ptd->clippedy0;
		ptd->clippedx1 = dev->clipLeft;
	}
	/* Clipping Right */
	if (ptd->clippedx1 >= dev->clipRight &&
			ptd->clippedx0 < dev->clipRight) {
//		Rprintf("%%\tClipping Right 1\n");
		ptd->clippedy1 = ((ptd->clippedy1-ptd->clippedy0) /
				(ptd->clippedx1-ptd->clippedx0) *
				(dev->clipRight-ptd->clippedx0)) +
						ptd->clippedy0;
		ptd->clippedx1 = dev->clipRight;
	}
	if (ptd->clippedx1 <= dev->clipRight &&
			ptd->clippedx0 > dev->clipRight) {
//		Rprintf("%%\tClipping Right 2\n");
		ptd->clippedy0 = ((ptd->clippedy1-ptd->clippedy0) /
				(ptd->clippedx1-ptd->clippedx0) *
				(dev->clipRight-ptd->clippedx0)) +
						ptd->clippedy0;
		ptd->clippedx0 = dev->clipRight;
	}
	/*Clipping Bottom */
	if (ptd->clippedy1 >= dev->clipBottom  &&
			ptd->clippedy0 < dev->clipBottom ) {
//		Rprintf("%%\tClipping Bottom 1\n");
		ptd->clippedx0 = ((ptd->clippedx1-ptd->clippedx0) /
				(ptd->clippedy1-ptd->clippedy0) *
				(dev->clipBottom -ptd->clippedy0)) +
						ptd->clippedx0;
		ptd->clippedy0 = dev->clipBottom ;
	}
	if (ptd->clippedy1 <= dev->clipBottom &&
			ptd->clippedy0 > dev->clipBottom ) {
//		Rprintf("%%\tClipping Bottom 2\n");
		ptd->clippedx1 = ((ptd->clippedx1-ptd->clippedx0) /
				(ptd->clippedy1-ptd->clippedy0) *
				(dev->clipBottom -ptd->clippedy0)) +
						ptd->clippedx0;
		ptd->clippedy1 = dev->clipBottom ;
	}
	/*Clipping Top */
	if (ptd->clippedy1 >= dev->clipTop  && ptd->clippedy0 < dev->clipTop ) {
//		Rprintf("%%\tClipping Top 1\n");
		ptd->clippedx1 = ((ptd->clippedx1-ptd->clippedx0) /
				(ptd->clippedy1-ptd->clippedy0) *
				(dev->clipTop -ptd->clippedy0)) +
						ptd->clippedx0;
		ptd->clippedy1 = dev->clipTop ;
	}
	if (ptd->clippedy1 <= dev->clipTop && ptd->clippedy0 > dev->clipTop ) {
//		Rprintf("%%\tClipping Top 2\n");
		ptd->clippedx0 = ((ptd->clippedx1-ptd->clippedx0) /
				(ptd->clippedy1-ptd->clippedy0) *
				(dev->clipTop -ptd->clippedy0)) +
						ptd->clippedx0;
		ptd->clippedy0 = dev->clipTop ;
	}
}

static Rboolean PPTXDeviceDriver(pDevDesc dev, const char* filename, double* width,
		double* height, double* offx, double* offy, double ps, int nbplots,
		const char* fontname, int id_init_value, int editable) {


	DOCDesc *rd;
	rd = (DOCDesc *) malloc(sizeof(DOCDesc));

	FontInfo *fi = (FontInfo *) malloc(sizeof(FontInfo));
	fi->isinit=0;
	fi->fontsize=(int) ps;
	rd->fi = fi;
	rd->filename = strdup(filename);
	rd->fontname = strdup(fontname);


	rd->id = id_init_value;
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



//	rd->env=env;
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

	dev->clipLeft = 0;
	dev->clipRight = width[0];
	dev->clipBottom = height[0];
	dev->clipTop = 0;

	rd->clippedx0 = dev->clipLeft;
	rd->clippedy0 = dev->clipTop;
	rd->clippedx1 = dev->clipRight;
	rd->clippedy1 = dev->clipBottom;

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
	dev->canClip = (Rboolean) TRUE;
	dev->canHAdj = 2;//canHadj – integer: can the device do horizontal adjustment of text via the text callback, and if so, how precisely? 0 = no adjustment, 1 = {0, 0.5, 1} (left, centre, right justification) or 2 = continuously variable (in [0,1]) between left and right justification.
	dev->canChangeGamma = (Rboolean) FALSE;	//canChangeGamma – Rboolean: can the display gamma be adjusted? This is now ignored, as gamma support has been removed.
	dev->displayListOn = (Rboolean) FALSE;

	dev->haveTransparency = 2;
	dev->haveTransparentBg = 3;

	rd->editable = editable;


	return (Rboolean) TRUE;
}


void GE_PPTXDevice(const char* filename, double* width, double* height, double* offx,
		double* offy, double ps, int nbplots, const char* fontfamily, int id_init_value, int editable) {
	pDevDesc dev = NULL;
	pGEDevDesc dd;
	R_GE_checkVersionOrDie (R_GE_version);
	R_CheckDeviceAvailable();

	if (!(dev = (pDevDesc) calloc(1, sizeof(DevDesc))))
		Rf_error("unable to start PPTX device");
	if (!PPTXDeviceDriver(dev, filename, width, height, offx, offy, ps, nbplots,
			fontfamily, id_init_value, editable)) {
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
	int idx = get_and_increment_idx(dev);

	fputs(pptx_elt_tag_start, pd->dmlFilePointer );
	if( pd->editable < 1 )
		fprintf(pd->dmlFilePointer,
			"<p:nvSpPr><p:cNvPr id=\"%d\" name=\"Point %d\" />%s</p:nvSpPr>", idx, idx, pptx_lock_properties);
	else fprintf(pd->dmlFilePointer,
			"<p:nvSpPr><p:cNvPr id=\"%d\" name=\"Point %d\" />%s</p:nvSpPr>", idx, idx, pptx_unlock_properties);
	fputs("<p:spPr><a:xfrm>", pd->dmlFilePointer );
	fprintf(pd->dmlFilePointer, "<a:off x=\"%.0f\" y=\"%.0f\"/>",
			p2e_(pd->offx + x - r), p2e_(pd->offy + y - r));
	fprintf(pd->dmlFilePointer, "<a:ext cx=\"%.0f\" cy=\"%.0f\"/>", p2e_(r * 2),
			p2e_(r * 2));
	fputs( "</a:xfrm><a:prstGeom prst=\"ellipse\"><a:avLst /></a:prstGeom>", pd->dmlFilePointer );

	DML_SetLineSpec(dev, gc);
	DML_SetFillColor(dev, gc);
	fputs( "</p:spPr>", pd->dmlFilePointer );

	fputs( "<p:txBody><a:bodyPr /><a:lstStyle /><a:p/></p:txBody>", pd->dmlFilePointer );
	fputs(pptx_elt_tag_end, pd->dmlFilePointer );

	fflush(pd->dmlFilePointer);
}

static void PPTX_Line(double x1, double y1, double x2, double y2,
		const pGEcontext gc, pDevDesc dev) {
	DOCDesc *pd = (DOCDesc *) dev->deviceSpecific;
	int idx = get_and_increment_idx(dev);

	double maxx = 0, maxy = 0;
	double minx = 0, miny = 0;

	PicTeX_ClipLine(x1, y1, x2, y2, dev);
	x1 = pd->clippedx0;
	y1 = pd->clippedy0;

	x2 = pd->clippedx1;
	y2 = pd->clippedy1;

	if (x2 > x1) {
		maxx = x2;
		minx = x1;
	} else {
		maxx = x1;
		minx = x2;
	}
	if (y2 > y1) {
		maxy = y2;
		miny = y1;
	} else {
		maxy = y1;
		miny = y2;
	}
	fputs(pptx_elt_tag_start, pd->dmlFilePointer );
	if( pd->editable < 1 )
		fprintf(pd->dmlFilePointer,
			"<p:nvSpPr><p:cNvPr id=\"%d\" name=\"Line %d\" />%s</p:nvSpPr>", idx, idx, pptx_lock_properties);
	else fprintf(pd->dmlFilePointer,
		"<p:nvSpPr><p:cNvPr id=\"%d\" name=\"Line %d\" />%s</p:nvSpPr>", idx, idx, pptx_unlock_properties);

	fputs( "<p:spPr><a:xfrm>", pd->dmlFilePointer );
	fprintf(pd->dmlFilePointer, "<a:off x=\"%.0f\" y=\"%.0f\"/>"
			, p2e_(pd->offx + minx), p2e_(pd->offy + miny));
	fprintf(pd->dmlFilePointer, "<a:ext cx=\"%.0f\" cy=\"%.0f\"/>", p2e_(maxx-minx), p2e_(maxy-miny));

	fputs( "</a:xfrm><a:custGeom><a:avLst />", pd->dmlFilePointer );
	fputs( "<a:pathLst>", pd->dmlFilePointer );
	fprintf(pd->dmlFilePointer, "<a:path w=\"%.0f\" h=\"%.0f\">", p2e_(maxx-minx), p2e_(maxy-miny));
	fprintf(pd->dmlFilePointer,
			"<a:moveTo><a:pt x=\"%.0f\" y=\"%.0f\" /></a:moveTo>", p2e_(x1 - minx), p2e_(y1 - miny) );
	fprintf(pd->dmlFilePointer,
			"<a:lnTo><a:pt x=\"%.0f\" y=\"%.0f\" /></a:lnTo>", p2e_(x2 - minx), p2e_(y2 - miny));
	fputs( "</a:path></a:pathLst>", pd->dmlFilePointer );
	fputs( "</a:custGeom>", pd->dmlFilePointer );
	DML_SetLineSpec(dev, gc);
	fputs( "</p:spPr>", pd->dmlFilePointer );

	fputs( "<p:txBody><a:bodyPr /><a:lstStyle /><a:p/></p:txBody>", pd->dmlFilePointer );
	fputs(pptx_elt_tag_end, pd->dmlFilePointer );
//	fprintf(pd->dmlFilePointer, "\n");

	fflush(pd->dmlFilePointer);

	//return;
}

static void PPTX_Polyline(int n, double *x, double *y, const pGEcontext gc,
		pDevDesc dev) {

	DOCDesc *pd = (DOCDesc *) dev->deviceSpecific;
	int idx = get_and_increment_idx(dev);
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

	PicTeX_ClipLine(minx, miny, maxx, maxy, dev);

	minx = pd->clippedx0;
	miny = pd->clippedy0;

	maxx = pd->clippedx1;
	maxy = pd->clippedy1;

	for (i = 1; i < n; i++) {
		PicTeX_ClipLine(x[i-1], y[i-1], x[i], y[i], dev);

		x[i-1] = pd->clippedx0;
		y[i-1] = pd->clippedy0;

		x[i] = pd->clippedx1;
		y[i] = pd->clippedy1;
	}


	fputs(pptx_elt_tag_start, pd->dmlFilePointer );
	if( pd->editable < 1 )
		fprintf(pd->dmlFilePointer,
			"<p:nvSpPr><p:cNvPr id=\"%d\" name=\"Polyline form %d\" />%s</p:nvSpPr>", idx, idx, pptx_lock_properties);
	else fprintf(pd->dmlFilePointer,
			"<p:nvSpPr><p:cNvPr id=\"%d\" name=\"Polyline form %d\" />%s</p:nvSpPr>", idx, idx, pptx_unlock_properties);

	fputs( "<p:spPr><a:xfrm>", pd->dmlFilePointer );
	fprintf(pd->dmlFilePointer, "<a:off x=\"%.0f\" y=\"%.0f\"/>",
			p2e_(pd->offx + minx), p2e_(pd->offy + miny));
	fprintf(pd->dmlFilePointer, "<a:ext cx=\"%.0f\" cy=\"%.0f\"/>", p2e_(maxx-minx), p2e_(maxy-miny));
	fputs( "</a:xfrm><a:custGeom><a:avLst />", pd->dmlFilePointer );
	//fprintf(pd->dmlFilePointer, "<a:pathLst><a:path w=\"%ld\" h=\"%ld\">", pd->extx, pd->exty);
	fputs( "<a:pathLst>", pd->dmlFilePointer );
	fprintf(pd->dmlFilePointer, "<a:path w=\"%.0f\" h=\"%.0f\">", p2e_(maxx-minx), p2e_(maxy-miny));


	fprintf(pd->dmlFilePointer,
			"<a:moveTo><a:pt x=\"%.0f\" y=\"%.0f\" /></a:moveTo>",
			p2e_(x[0] - minx), p2e_(y[0] - miny));
	for (i = 1; i < n; i++) {
		fprintf(pd->dmlFilePointer,
				"<a:lnTo><a:pt x=\"%.0f\" y=\"%.0f\" /></a:lnTo>",
				p2e_(x[i] - minx), p2e_(y[i] - miny));
	}
	fputs( "</a:path></a:pathLst>", pd->dmlFilePointer );
	fputs( "</a:custGeom>", pd->dmlFilePointer );
	DML_SetLineSpec(dev, gc);
	fputs( "</p:spPr>", pd->dmlFilePointer );
	fputs( "<p:txBody><a:bodyPr /><a:lstStyle /><a:p/></p:txBody>", pd->dmlFilePointer );

	fputs(pptx_elt_tag_end, pd->dmlFilePointer );
	fflush(pd->dmlFilePointer);

}

static void PPTX_Polygon(int n, double *x, double *y, const pGEcontext gc,
		pDevDesc dev) {

	DOCDesc *pd = (DOCDesc *) dev->deviceSpecific;
	int idx = get_and_increment_idx(dev);
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
	PicTeX_ClipLine(minx, miny, maxx, maxy, dev);

	minx = pd->clippedx0;
	miny = pd->clippedy0;

	maxx = pd->clippedx1;
	maxy = pd->clippedy1;

	for (i = 1; i < n; i++) {
		PicTeX_ClipLine(x[i-1], y[i-1], x[i], y[i], dev);

		x[i-1] = pd->clippedx0;
		y[i-1] = pd->clippedy0;

		x[i] = pd->clippedx1;
		y[i] = pd->clippedy1;
	}


	fputs(pptx_elt_tag_start, pd->dmlFilePointer );

	if( pd->editable < 1 )
		fprintf(pd->dmlFilePointer,
			"<p:nvSpPr><p:cNvPr id=\"%d\" name=\"Polygon form %d\" />%s</p:nvSpPr>", idx, idx, pptx_lock_properties);
	else fprintf(pd->dmlFilePointer,
			"<p:nvSpPr><p:cNvPr id=\"%d\" name=\"Polygon form %d\" />%s</p:nvSpPr>", idx, idx, pptx_unlock_properties);
	
	fputs("<p:spPr><a:xfrm>", pd->dmlFilePointer );
	fprintf(pd->dmlFilePointer, "<a:off x=\"%.0f\" y=\"%.0f\"/>",
			p2e_(pd->offx + minx), p2e_(pd->offy + miny));
	fprintf(pd->dmlFilePointer, "<a:ext cx=\"%.0f\" cy=\"%.0f\"/>", p2e_(maxx-minx), p2e_(maxy-miny));
	fputs("</a:xfrm><a:custGeom><a:avLst />", pd->dmlFilePointer );
	fputs("<a:pathLst>", pd->dmlFilePointer );
	fprintf(pd->dmlFilePointer, "<a:path w=\"%.0f\" h=\"%.0f\">", p2e_(maxx-minx), p2e_(maxy-miny));
	fprintf(pd->dmlFilePointer,
			"<a:moveTo><a:pt x=\"%.0f\" y=\"%.0f\" /></a:moveTo>",
			p2e_(x[0] - minx), p2e_(y[0] - miny));
	for (i = 1; i < n; i++) {
		fprintf(pd->dmlFilePointer,
				"<a:lnTo><a:pt x=\"%.0f\" y=\"%.0f\" /></a:lnTo>",
				p2e_(x[i] - minx), p2e_(y[i] - miny));
	}
	fputs("<a:close/></a:path></a:pathLst>", pd->dmlFilePointer );
	fputs("</a:custGeom>", pd->dmlFilePointer );
	DML_SetFillColor(dev, gc);
	DML_SetLineSpec(dev, gc);
	fputs("</p:spPr>", pd->dmlFilePointer );

	fprintf(pd->dmlFilePointer,
			"<p:txBody><a:bodyPr /><a:lstStyle /><a:p/></p:txBody>");
	fputs(pptx_elt_tag_end, pd->dmlFilePointer );
	fprintf(pd->dmlFilePointer, "\n");
	fflush(pd->dmlFilePointer);

}

static void PPTX_Rect(double x0, double y0, double x1, double y1,
		const pGEcontext gc, pDevDesc dev) {

	double tmp;
	DOCDesc *pd = (DOCDesc *) dev->deviceSpecific;
	int idx = get_and_increment_idx(dev);

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
	PicTeX_ClipLine(x0, y0, x1, y1, dev);

	x0 = pd->clippedx0;
	y0 = pd->clippedy0;

	x1 = pd->clippedx1;
	y1 = pd->clippedy1;

	fputs(pptx_elt_tag_start, pd->dmlFilePointer );

	if( pd->editable < 1 )
		fprintf(pd->dmlFilePointer,
			"<p:nvSpPr><p:cNvPr id=\"%d\" name=\"Rectangle %d\" />%s</p:nvSpPr>", idx, idx, pptx_lock_properties);
	else fprintf(pd->dmlFilePointer,
			"<p:nvSpPr><p:cNvPr id=\"%d\" name=\"Rectangle %d\" />%s</p:nvSpPr>", idx, idx, pptx_unlock_properties);
	fputs("<p:spPr><a:xfrm>", pd->dmlFilePointer );

	fprintf(pd->dmlFilePointer, "<a:off x=\"%.0f\" y=\"%.0f\"/>",
			p2e_(pd->offx + x0), p2e_(pd->offy + y0));
	fprintf(pd->dmlFilePointer, "<a:ext cx=\"%.0f\" cy=\"%.0f\"/>",
			p2e_(x1 - x0), p2e_(y1 - y0));
	fputs("</a:xfrm><a:prstGeom prst=\"rect\"><a:avLst /></a:prstGeom>", pd->dmlFilePointer );
	DML_SetFillColor(dev, gc);
	DML_SetLineSpec(dev, gc);
	fputs("</p:spPr>", pd->dmlFilePointer );
	fputs("<p:txBody><a:bodyPr /><a:lstStyle /><a:p/></p:txBody>", pd->dmlFilePointer );

	fputs(pptx_elt_tag_end, pd->dmlFilePointer );
//	fprintf(pd->dmlFilePointer, "\n");
	fflush(pd->dmlFilePointer);

}


static void PPTX_Text(double x, double y, const char *str, double rot,
		double hadj, const pGEcontext gc, pDevDesc dev) {

	DOCDesc *pd = (DOCDesc *) dev->deviceSpecific;
	int idx = get_and_increment_idx(dev);

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

	fputs(pptx_elt_tag_start, pd->dmlFilePointer );

	if( pd->editable < 1 )
		fprintf(pd->dmlFilePointer,
			"<p:nvSpPr><p:cNvPr id=\"%d\" name=\"Text %d\" />%s</p:nvSpPr>", idx, idx, pptx_lock_properties);
	else fprintf(pd->dmlFilePointer,
				"<p:nvSpPr><p:cNvPr id=\"%d\" name=\"Text %d\" />%s</p:nvSpPr>", idx, idx, pptx_unlock_properties);
	fputs("<p:spPr>", pd->dmlFilePointer );
	fprintf(pd->dmlFilePointer, "<a:xfrm rot=\"%.0f\">", (-rot) * 60000);
	fprintf(pd->dmlFilePointer, "<a:off x=\"%.0f\" y=\"%.0f\"/>",
			p2e_(pd->offx + corrected_offx), p2e_(pd->offy + corrected_offy));
	fprintf(pd->dmlFilePointer, "<a:ext cx=\"%.0f\" cy=\"%.0f\"/>",
			p2e_(w), p2e_(h));
	fputs("</a:xfrm>", pd->dmlFilePointer );
	fputs("<a:prstGeom prst=\"rect\"><a:avLst /></a:prstGeom>", pd->dmlFilePointer );
	fputs("<a:noFill />", pd->dmlFilePointer );
	fputs("</p:spPr>", pd->dmlFilePointer );

	fputs("<p:txBody>", pd->dmlFilePointer );
	fputs("<a:bodyPr lIns=\"0\" tIns=\"0\" rIns=\"0\" bIns=\"0\" anchor=\"b\">", pd->dmlFilePointer );
	fputs("<a:spAutoFit />", pd->dmlFilePointer );
	fputs("</a:bodyPr><a:lstStyle /><a:p>", pd->dmlFilePointer );
	fputs("<a:pPr", pd->dmlFilePointer );

	if (hadj < 0.25)
		fputs(" algn=\"l\"", pd->dmlFilePointer );
	else if (hadj < 0.75)
		fputs(" algn=\"ctr\"", pd->dmlFilePointer );
	else
		fputs(" algn=\"r\"", pd->dmlFilePointer );
	fputs(" marL=\"0\" marR=\"0\" indent=\"0\" >", pd->dmlFilePointer );
	fprintf(pd->dmlFilePointer, "<a:lnSpc><a:spcPts val=\"%.0f\"/></a:lnSpc>",fontsize);
	fputs("<a:spcBef><a:spcPts val=\"0\"/></a:spcBef>", pd->dmlFilePointer );
	fputs("<a:spcAft><a:spcPts val=\"0\"/></a:spcAft>", pd->dmlFilePointer );

	fputs("</a:pPr>", pd->dmlFilePointer );
	fputs("<a:r>", pd->dmlFilePointer );
	fprintf(pd->dmlFilePointer, "<a:rPr sz=\"%.0f\"", fontsize);
	if (gc->fontface == 2) {
		fputs(" b=\"1\"", pd->dmlFilePointer );
	} else if (gc->fontface == 3) {
		fputs(" i=\"1\"", pd->dmlFilePointer );
	} else if (gc->fontface == 4) {
		fputs(" b=\"1\" i=\"1\"", pd->dmlFilePointer );
	}

	fputs(">", pd->dmlFilePointer );
	DML_SetFontColor(dev, gc);

	fprintf(pd->dmlFilePointer,
				"<a:latin typeface=\"%s\"/><a:cs typeface=\"%s\"/>",
				pd->fi->fontname, pd->fi->fontname);

	fputs("</a:rPr>", pd->dmlFilePointer );

	fprintf(pd->dmlFilePointer, "<a:t>%s</a:t></a:r></a:p></p:txBody>", str);
	fputs(pptx_elt_tag_end, pd->dmlFilePointer );
	//fprintf(pd->dmlFilePointer, "\n");

	fflush(pd->dmlFilePointer);
}

static void PPTX_NewPage(const pGEcontext gc, pDevDesc dev) {
	DOCDesc *pd = (DOCDesc *) dev->deviceSpecific;
	if (pd->pageNumber > 0) {
		closeFile(pd->dmlFilePointer);
	}

	int which = pd->pageNumber % pd->maxplot;
	pd->pageNumber++;

	//update_start_id(dev);

	dev->right = pd->width[which];
	dev->bottom = pd->height[which];
	dev->left = 0;
	dev->top = 0;

	dev->clipLeft = 0;
	dev->clipRight = dev->right;
	dev->clipBottom = dev->bottom;
	dev->clipTop = 0;

	pd->clippedx0 = dev->clipLeft;
	pd->clippedy0 = dev->clipTop;
	pd->clippedx1 = dev->clipRight;
	pd->clippedy1 = dev->clipBottom;



	pd->offx = pd->x[which];
	pd->offy = pd->y[which];
	pd->extx = pd->width[which];
	pd->exty = pd->height[which];

	char *str={0};
	str = get_dml_filename(pd->filename, pd->pageNumber);
	pd->dmlFilePointer = (FILE *) fopen(str, "w");

	if (pd->dmlFilePointer == NULL) {
		Rf_error("error while opening %s\n", str);
	}
	updateFontInfo(dev, gc);
	free(str);
}
static void PPTX_Close(pDevDesc dev) {
	DOCDesc *pd = (DOCDesc *) dev->deviceSpecific;
	//update_start_id(dev);
	closeFile(pd->dmlFilePointer);
	free(pd);
}


static void PPTX_Clip(double x0, double x1, double y0, double y1, pDevDesc dev) {
//	Rprintf("%% Setting Clip Region to %.2f %.2f %.2f %.2f\n", x0, y0, x1, y1);
	dev->clipLeft = x0;
	dev->clipRight = x1;
	dev->clipBottom = y1;
	dev->clipTop = y0;

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
		, SEXP width, SEXP height, SEXP offx
		, SEXP offy, SEXP pointsize, SEXP fontfamily
		, SEXP start_id, SEXP is_editable
		) {

	double* w = REAL(width);
	double* h = REAL(height);

	double* x = REAL(offx);
	double* y = REAL(offy);
	int nx = length(width);

	double ps = asReal(pointsize);
	int id_init_value = INTEGER(start_id)[0];
	int editable = INTEGER(is_editable)[0];

	BEGIN_SUSPEND_INTERRUPTS;
	GE_PPTXDevice(CHAR(STRING_ELT(filename, 0))
			, w, h, x, y, ps, nx, CHAR(STRING_ELT(fontfamily, 0))
			, id_init_value, editable
			);
	END_SUSPEND_INTERRUPTS;
	return R_NilValue;
}


