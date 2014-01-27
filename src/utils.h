#include <stdio.h>
#include <Rinternals.h>
#include <R.h>

#include <R_ext/GraphicsEngine.h>
#include <R_ext/GraphicsDevice.h>

extern "C" {

double p2e_(double x);
double p2t(double x);
int getFontface( int ff );
double getFontSize(double cex, double fontsize, double lineheight);


void closeFile( FILE *file);

char* getFilename(char* filename, int index);
char* getRaphaelFilename(char* filename, int index);
char* getObjectName(char* filename, int index);
char* getCanvasName( int index);
void update_canvas_id(pDevDesc dev);
char *RGBHexValue(unsigned int col);

void updateFontInfo(pDevDesc dev, R_GE_gcontext *gc);
void update_start_id(pDevDesc dev);
int getEditable(pDevDesc dev);
int get_idx(pDevDesc dev);
void SetFillColor(pDevDesc dev, R_GE_gcontext *gc);
void SetFontColor(pDevDesc dev, R_GE_gcontext *gc);
void SetLineSpec(pDevDesc dev, R_GE_gcontext *gc);
void RAPHAEL_SetLineSpec(pDevDesc dev, R_GE_gcontext *gc, int idx);
void RAPHAEL_SetFillColor(pDevDesc dev, R_GE_gcontext *gc, int idx);
void RAPHAEL_SetFontSpec(pDevDesc dev, R_GE_gcontext *gc, int idx);
}
