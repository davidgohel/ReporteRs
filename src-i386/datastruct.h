#include <Rinternals.h>
#include <R.h>

typedef struct {
	char *fontname;
	int fontsize;
	int ascent[4];
	int descent[4];
	int height[4];
	int widths[1024];
	int isinit;
} FontInfo;


typedef struct {
	char *filename;
	char *fontname;
	char *objectname;
	int canvas_id;

	int pageNumber; /* page number */
	FILE *dmlFilePointer; /* output file */
	int fontface;
	int fontsize;
	int id;
	int editable;
	double offx;
	double offy;
	double extx;
	double exty;
	
	double* x;
	double* y;
	double* width;
	double* height;
	int maxplot;
	FontInfo *fi;
	SEXP env;

} DOCDesc;
