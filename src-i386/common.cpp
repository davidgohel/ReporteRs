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
