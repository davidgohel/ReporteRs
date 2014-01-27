#include <string.h>
#include <stdio.h>
#include <math.h>

#define R_USE_PROTOTYPES 1


#include "datastruct.h"
#include "utils.h"
#include "common.h"
#include "DOCX.h"

static char docx_elt_tag_start[] = "<wps:wsp>";
static char docx_elt_tag_end[] = "</wps:wsp>";
static char docx_lock_properties[] = "<wps:cNvSpPr><a:spLocks noSelect=\"1\" noResize=\"1\" noEditPoints=\"1\" noTextEdit=\"1\" noMove=\"1\" noRot=\"1\" noChangeShapeType=\"1\"/></wps:cNvSpPr><wps:nvPr />";
static char docx_unlock_properties[] = "<wps:cNvSpPr /><wps:nvPr />";


void DOCX_setRunProperties(pDevDesc dev, R_GE_gcontext *gc, double fontsize){
	DOCDesc *pd = (DOCDesc *) dev->deviceSpecific;
	int alpha =  (int) ((255-R_ALPHA(gc->col))/255.0 * 100000);//n importe quoi
	int fontface = gc->fontface;
	fprintf(pd->dmlFilePointer, "<w:rPr>" );
	fprintf(pd->dmlFilePointer, "<w:rFonts w:ascii=\"%s\" w:hAnsi=\"%s\" w:cs=\"%s\" />", pd->fi->fontname, pd->fi->fontname, pd->fi->fontname );
	if ( fontface == 2 || fontface == 4 ) {
		fprintf(pd->dmlFilePointer, "<w:b />");
	}
	if (fontface == 3 || fontface == 4) {
		fprintf(pd->dmlFilePointer, "<w:i />");
	}
	fprintf(pd->dmlFilePointer, "<w:color w:val=\"%s\" />", RGBHexValue(gc->col) );
	fprintf(pd->dmlFilePointer, "<w:sz w:val=\"%.0f\" />", fontsize * 2 );
	fprintf(pd->dmlFilePointer, "<w:szCs w:val=\"%.0f\" />", fontsize * 2 );

	if (alpha > 0) {
		fprintf(pd->dmlFilePointer, "<w14:textFill>" );
		fprintf(pd->dmlFilePointer, "<w14:solidFill>" );
		fprintf(pd->dmlFilePointer, "<w14:srgbClr w14:val=\"%s\">", RGBHexValue(gc->col) );
		fprintf(pd->dmlFilePointer, "<w14:alpha w14:val=\"%d\" />", alpha);
		fprintf(pd->dmlFilePointer, "</w14:srgbClr>");
		fprintf(pd->dmlFilePointer, "</w14:solidFill>" );
		fprintf(pd->dmlFilePointer, "</w14:textFill>" );
	}


	fprintf(pd->dmlFilePointer, "</w:rPr>" );

}


static Rboolean DOCXDeviceDriver(pDevDesc dev, const char* filename, double* width,
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
	dev->activate = DOCX_activate;
	dev->close = DOCX_Close;
	dev->size = DOCX_Size;
	dev->newPage = DOCX_NewPage;
	dev->clip = DOCX_Clip;
	dev->strWidth = DOCX_StrWidth;
	dev->text = DOCX_Text;
	dev->rect = DOCX_Rect;
	dev->circle = DOCX_Circle;
	dev->line = DOCX_Line;
	dev->polyline = DOCX_Polyline;
	dev->polygon = DOCX_Polygon;
	dev->metricInfo = DOCX_MetricInfo;
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


void GE_DOCXDevice(const char* filename, double* width, double* height, double* offx,
		double* offy, double ps, int nbplots, const char* fontfamily, SEXP env) {
	pDevDesc dev = NULL;
	pGEDevDesc dd;
	R_GE_checkVersionOrDie (R_GE_version);
	R_CheckDeviceAvailable();

	if (!(dev = (pDevDesc) calloc(1, sizeof(DevDesc))))
		Rf_error("unable to start DOCX device");
	if (!DOCXDeviceDriver(dev, filename, width, height, offx, offy, ps, nbplots,
			fontfamily, env)) {
		free(dev);
		Rf_error("unable to start DOCX device");
	}

	dd = GEcreateDevDesc(dev);
	GEaddDevice2(dd, "DOCX");

}

static void DOCX_activate(pDevDesc dev) {

}

static void DOCX_Circle(double x, double y, double r, const pGEcontext gc,
		pDevDesc dev) {
	DOCDesc *pd = (DOCDesc *) dev->deviceSpecific;
	int idx = get_idx(dev);

	fprintf(pd->dmlFilePointer, docx_elt_tag_start);
	if( pd->editable > 0 )
		fprintf(pd->dmlFilePointer,	"<wps:cNvPr id=\"%d\" name=\"Point %d\" />%s", idx,	idx, docx_unlock_properties);
	else fprintf(pd->dmlFilePointer,	"<wps:cNvPr id=\"%d\" name=\"Point %d\" />%s", idx,	idx, docx_lock_properties);
	fprintf(pd->dmlFilePointer, "<wps:spPr>");
	fprintf(pd->dmlFilePointer, "<a:xfrm>");
	fprintf(pd->dmlFilePointer, "<a:off x=\"%.0f\" y=\"%.0f\"/>",
			p2e_(pd->offx + x - r), p2e_(pd->offy + y - r));
	fprintf(pd->dmlFilePointer, "<a:ext cx=\"%.0f\" cy=\"%.0f\"/>", p2e_(r * 2),
			p2e_(r * 2));
	fprintf(pd->dmlFilePointer, "</a:xfrm>");
	fprintf(pd->dmlFilePointer,
			"<a:prstGeom prst=\"ellipse\"><a:avLst /></a:prstGeom>");
	SetFillColor(dev, gc);
	SetLineSpec(dev, gc);
	fprintf(pd->dmlFilePointer, "</wps:spPr>");

	fprintf(pd->dmlFilePointer, "<wps:bodyPr />");
	fprintf(pd->dmlFilePointer, docx_elt_tag_end);
	fprintf(pd->dmlFilePointer, "\n");
	fflush(pd->dmlFilePointer);
}

static void DOCX_Line(double x1, double y1, double x2, double y2,
		const pGEcontext gc, pDevDesc dev) {

	double maxx = 0, maxy = 0;
	double minx = 0, miny = 0;
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

//	Rprintf("line x{from %.3f to %.3f} y{from %.3f to %.3f}\n", x1, x2, y1, y2);
	DOCDesc *pd = (DOCDesc *) dev->deviceSpecific;
	int idx = get_idx(dev);

	fprintf(pd->dmlFilePointer, docx_elt_tag_start);
	if( pd->editable > 0 )
		fprintf(pd->dmlFilePointer,
			"<wps:cNvPr id=\"%d\" name=\"Line %d\" />%s", idx,	idx, docx_unlock_properties);
	else fprintf(pd->dmlFilePointer,
			"<wps:cNvPr id=\"%d\" name=\"Line %d\" />%s", idx,	idx, docx_lock_properties);
	fprintf(pd->dmlFilePointer, "<wps:spPr>");
		fprintf(pd->dmlFilePointer, "<a:xfrm>");
			fprintf(pd->dmlFilePointer, "<a:off x=\"%.0f\" y=\"%.0f\"/>"
					, p2e_(pd->offx + minx), p2e_(pd->offy + miny));
			fprintf(pd->dmlFilePointer, "<a:ext cx=\"%.0f\" cy=\"%.0f\"/>"
					, p2e_(maxx-minx), p2e_(maxy-miny));

//	Rprintf("\toff {%.0f ; %.0f} ext{%.0f ; %.0f}\n", p2e_(pd->offx + x1), p2e_(pd->offy + y1), p2e_(maxx-minx), p2e_(maxy-miny));

		fprintf(pd->dmlFilePointer, "</a:xfrm>");
		fprintf(pd->dmlFilePointer, "<a:custGeom>");
		fprintf(pd->dmlFilePointer, "<a:pathLst>");
			fprintf(pd->dmlFilePointer, "<a:path w=\"%.0f\" h=\"%.0f\">", p2e_(maxx-minx), p2e_(maxy-miny));


				fprintf(pd->dmlFilePointer,
						"<a:moveTo><a:pt x=\"%.0f\" y=\"%.0f\" /></a:moveTo>", p2e_(x1 - minx), p2e_(y1 - miny));
				fprintf(pd->dmlFilePointer,
						"<a:lnTo><a:pt x=\"%.0f\" y=\"%.0f\" /></a:lnTo>", p2e_(x2 - minx),
						p2e_(y2 - miny));
			fprintf(pd->dmlFilePointer, "</a:path>");
		fprintf(pd->dmlFilePointer, "</a:pathLst>");

	fprintf(pd->dmlFilePointer, "</a:custGeom><a:noFill />");
	SetLineSpec(dev, gc);
	fprintf(pd->dmlFilePointer, "</wps:spPr>");

	fprintf(pd->dmlFilePointer,
			"<wps:bodyPr />");
	fprintf(pd->dmlFilePointer, docx_elt_tag_end);
	fprintf(pd->dmlFilePointer, "\n");

	fflush(pd->dmlFilePointer);

	//return;
}

static void DOCX_Polyline(int n, double *x, double *y, const pGEcontext gc,
		pDevDesc dev) {
//	Rprintf("DOCX_Polyline\n");

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
//
	fprintf(pd->dmlFilePointer, docx_elt_tag_start);
	if( pd->editable < 1 )
		fprintf(pd->dmlFilePointer,
			"<wps:cNvPr id=\"%d\" name=\"Polyline %d\" />%s", idx,	idx, docx_lock_properties);
	else fprintf(pd->dmlFilePointer,
			"<wps:cNvPr id=\"%d\" name=\"Polyline %d\" />%s", idx,	idx, docx_unlock_properties);

	fprintf(pd->dmlFilePointer, "<wps:spPr>");
	fprintf(pd->dmlFilePointer, "<a:xfrm>");
	fprintf(pd->dmlFilePointer, "<a:off x=\"%.0f\" y=\"%.0f\"/>",
			p2e_(pd->offx + minx), p2e_(pd->offy + miny));
	fprintf(pd->dmlFilePointer, "<a:ext cx=\"%.0f\" cy=\"%.0f\"/>",
			p2e_(maxx - minx), p2e_(maxy - miny));
	fprintf(pd->dmlFilePointer, "</a:xfrm>");
	fprintf(pd->dmlFilePointer, "<a:custGeom>");

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
	//fprintf(pd->dmlFilePointer, "<a:close/>");

	fprintf(pd->dmlFilePointer, "</a:path>");
	fprintf(pd->dmlFilePointer, "</a:pathLst>");
	fprintf(pd->dmlFilePointer, "</a:custGeom>");
	//SetFillColor(dev, gc);
	SetLineSpec(dev, gc);
	fprintf(pd->dmlFilePointer, "</wps:spPr>");

	fprintf(pd->dmlFilePointer, "<wps:bodyPr />");
	fprintf(pd->dmlFilePointer, docx_elt_tag_end);
	fprintf(pd->dmlFilePointer, "\n");
	fflush(pd->dmlFilePointer);

	//return;

}

static void DOCX_Polygon(int n, double *x, double *y, const pGEcontext gc,
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
//
	fprintf(pd->dmlFilePointer, docx_elt_tag_start);
	if( pd->editable < 1 )
		fprintf(pd->dmlFilePointer,
			"<wps:cNvPr id=\"%d\" name=\"Polygon %d\" />%s", idx,	idx, docx_lock_properties);
	else fprintf(pd->dmlFilePointer,
			"<wps:cNvPr id=\"%d\" name=\"Polygon %d\" />%s", idx,	idx, docx_unlock_properties);

	fprintf(pd->dmlFilePointer, "<wps:spPr>");
	fprintf(pd->dmlFilePointer, "<a:xfrm>");
	fprintf(pd->dmlFilePointer, "<a:off x=\"%.0f\" y=\"%.0f\"/>",
			p2e_(pd->offx + minx), p2e_(pd->offy + miny));
	fprintf(pd->dmlFilePointer, "<a:ext cx=\"%.0f\" cy=\"%.0f\"/>",
			p2e_(maxx - minx), p2e_(maxy - miny));
	fprintf(pd->dmlFilePointer, "</a:xfrm>");
	fprintf(pd->dmlFilePointer, "<a:custGeom>");
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
	fprintf(pd->dmlFilePointer, "<a:close/>");

	fprintf(pd->dmlFilePointer, "</a:path>");
	fprintf(pd->dmlFilePointer, "</a:pathLst>");
	fprintf(pd->dmlFilePointer, "</a:custGeom>");
	SetFillColor(dev, gc);
	SetLineSpec(dev, gc);
	fprintf(pd->dmlFilePointer, "</wps:spPr>");

	fprintf(pd->dmlFilePointer, "<wps:bodyPr />");
	fprintf(pd->dmlFilePointer, docx_elt_tag_end);
	fprintf(pd->dmlFilePointer, "\n");
	fflush(pd->dmlFilePointer);

	//return;

}

static void DOCX_Rect(double x0, double y0, double x1, double y1,
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
//
	fprintf(pd->dmlFilePointer, docx_elt_tag_start);
	if( pd->editable < 1 )
		fprintf(pd->dmlFilePointer,
			"<wps:cNvPr id=\"%d\" name=\"Rectangle %d\" />%s", idx,	idx, docx_lock_properties);
	else fprintf(pd->dmlFilePointer,
			"<wps:cNvPr id=\"%d\" name=\"Rectangle %d\" />%s", idx,	idx, docx_unlock_properties);
	fprintf(pd->dmlFilePointer, "<wps:spPr>");
	fprintf(pd->dmlFilePointer, "<a:xfrm>");
	fprintf(pd->dmlFilePointer, "<a:off x=\"%.0f\" y=\"%.0f\"/>",
			p2e_(pd->offx + x0), p2e_(pd->offy + y0));
	fprintf(pd->dmlFilePointer, "<a:ext cx=\"%.0f\" cy=\"%.0f\"/>",
			p2e_(x1 - x0), p2e_(y1 - y0));
	fprintf(pd->dmlFilePointer, "</a:xfrm>");
	fprintf(pd->dmlFilePointer,
			"<a:prstGeom prst=\"rect\"><a:avLst /></a:prstGeom>");
	SetFillColor(dev, gc);
	SetLineSpec(dev, gc);
	fprintf(pd->dmlFilePointer, "</wps:spPr>");

	fprintf(pd->dmlFilePointer, "<wps:bodyPr />");
	fprintf(pd->dmlFilePointer, docx_elt_tag_end);
	fprintf(pd->dmlFilePointer, "\n");
	fflush(pd->dmlFilePointer);

	//return;

}


static void DOCX_Text(double x, double y, const char *str, double rot,
		double hadj, const pGEcontext gc, pDevDesc dev) {

	DOCDesc *pd = (DOCDesc *) dev->deviceSpecific;
	double pi = 3.141592653589793115997963468544185161590576171875;
	int idx = get_idx(dev);

	double w = DOCX_StrWidth(str, gc, dev);
	if( strlen(str) < 3 ) w+= 1 * w / strlen(str);
	else w += 3 * w / strlen(str);
	double h = getFontSize(gc->cex, gc->ps, gc->lineheight) * 1.0;
	if( h < 1.0 ) return;
	double fontsize = h;

//	/* translate and rotate ops */
	double alpha = -rot * pi / 180;
	double height = h;
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
	if( rot < 0.05 || rot > 0.05 ) rot = -rot;
	else rot = 0.0;

	fprintf(pd->dmlFilePointer, docx_elt_tag_start);
	if( pd->editable < 1 )
		fprintf(pd->dmlFilePointer, "<wps:cNvPr id=\"%d\" name=\"Text %d\" />%s", idx,	idx, docx_lock_properties);
	else fprintf(pd->dmlFilePointer, "<wps:cNvPr id=\"%d\" name=\"Text %d\" />%s", idx,	idx, docx_unlock_properties);
	fprintf(pd->dmlFilePointer, "<wps:spPr>");
	fprintf(pd->dmlFilePointer, "<a:xfrm rot=\"%.0f\">", rot * 60000);
	fprintf(pd->dmlFilePointer, "<a:off x=\"%.0f\" y=\"%.0f\"/>", p2e_(pd->offx + corrected_offx), p2e_(pd->offy + corrected_offy));
	fprintf(pd->dmlFilePointer, "<a:ext cx=\"%.0f\" cy=\"%.0f\"/>", p2e_(w), p2e_(h));
	fprintf(pd->dmlFilePointer, "</a:xfrm>");
	fprintf(pd->dmlFilePointer, "<a:prstGeom prst=\"rect\"><a:avLst /></a:prstGeom>");
	fprintf(pd->dmlFilePointer, "<a:noFill />");
	fprintf(pd->dmlFilePointer, "</wps:spPr>");
	fprintf(pd->dmlFilePointer, "<wps:txbx>");
	fprintf(pd->dmlFilePointer, "<w:txbxContent>");
	fprintf(pd->dmlFilePointer, "<w:p>");
	fprintf(pd->dmlFilePointer, "<w:pPr>");
	if (hadj < 0.25)
		fprintf(pd->dmlFilePointer, "<w:jc w:val=\"left\" />");
	else if (hadj < 0.75)
		fprintf(pd->dmlFilePointer, "<w:jc w:val=\"center\" />");
	else
		fprintf(pd->dmlFilePointer, "<w:jc w:val=\"right\" />");

	fprintf(pd->dmlFilePointer, "<w:spacing w:after=\"0\" w:before=\"0\" w:line=\"%.0f\" w:lineRule=\"exact\" />", height*20);
	DOCX_setRunProperties( dev, gc, fontsize);
	fprintf(pd->dmlFilePointer, "</w:pPr>");
	fprintf(pd->dmlFilePointer, "<w:r>");
	DOCX_setRunProperties( dev, gc, fontsize);
	fprintf(pd->dmlFilePointer, "<w:t>%s</w:t></w:r></w:p>", str);
	fprintf(pd->dmlFilePointer, "</w:txbxContent>");
	fprintf(pd->dmlFilePointer, "</wps:txbx>");
	fprintf(pd->dmlFilePointer, "<wps:bodyPr lIns=\"0\" tIns=\"0\" rIns=\"0\" bIns=\"0\"");
	fprintf(pd->dmlFilePointer, " anchor=\"b\">");
	fprintf(pd->dmlFilePointer, "<a:spAutoFit />");
	fprintf(pd->dmlFilePointer, "</wps:bodyPr>");
	fprintf(pd->dmlFilePointer, docx_elt_tag_end);
	fprintf(pd->dmlFilePointer, "\n");
	fflush(pd->dmlFilePointer);

	//return;
}

static void DOCX_NewPage(const pGEcontext gc, pDevDesc dev) {
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
static void DOCX_Close(pDevDesc dev) {
	DOCDesc *pd = (DOCDesc *) dev->deviceSpecific;
	update_start_id(dev);
	closeFile(pd->dmlFilePointer);
	free(pd);
}

static void DOCX_Clip(double x0, double x1, double y0, double y1, pDevDesc dev) {
}

static void DOCX_MetricInfo(int c, const pGEcontext gc, double* ascent,
		double* descent, double* width, pDevDesc dev) {
	DOC_MetricInfo(c, gc, ascent, descent, width, dev);
}

static void DOCX_Size(double *left, double *right, double *bottom, double *top,
		pDevDesc dev) {
	*left = dev->left;
	*right = dev->right;
	*bottom = dev->bottom;
	*top = dev->top;
}


static double DOCX_StrWidth(const char *str, const pGEcontext gc, pDevDesc dev) {
	return DOC_StrWidth(str, gc, dev);
}

//SEXP setDimensions(SEXP devNumber, SEXP ext, SEXP off){
	/*
static void javaGDresize_(int dev) {
    int ds = NumDevices();
    int i = 0;
    if (dev >= 0 && dev < ds) {
	i = dev;
	ds = dev + 1;
    }
    while (i < ds) {
        GEDevDesc *gd = GEgetDevice(i);
        if (gd) {
            NewDevDesc *dd = gd->dev;
#ifdef JGD_DEBUG
            printf("javaGDresize: device=%d, dd=%lx\n", i, (unsigned long)dd);
#endif
            if (dd) {
#ifdef JGD_DEBUG
                printf("dd->size=%lx\n", (unsigned long)dd->size);
#endif
                dd->size(&(dd->left), &(dd->right), &(dd->bottom), &(dd->top), dd);
                GEplayDisplayList(gd);
            }
        }
        i++;
    }
}
	 */
//	return R_NilValue;
//}

SEXP R_DOCX_Device(SEXP filename
		, SEXP width, SEXP height, SEXP offx,
		SEXP offy, SEXP pointsize, SEXP fontfamily, SEXP env) {

	double* w = REAL(width);
	double* h = REAL(height);

	double* x = REAL(offx);
	double* y = REAL(offy);
	int nx = length(width);

	double ps = asReal(pointsize);

	BEGIN_SUSPEND_INTERRUPTS;
	GE_DOCXDevice(CHAR(STRING_ELT(filename, 0)), w, h, x, y, ps, nx, CHAR(STRING_ELT(fontfamily, 0)), env);
	END_SUSPEND_INTERRUPTS;
	return R_NilValue;
}
