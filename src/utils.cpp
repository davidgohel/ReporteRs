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




void closeFile( FILE *file){
	BEGIN_SUSPEND_INTERRUPTS;
	fflush(file);
	fclose(file);
	END_SUSPEND_INTERRUPTS;
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


