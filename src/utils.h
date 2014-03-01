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
char* getJSVariableName(char* filename, int index);
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
