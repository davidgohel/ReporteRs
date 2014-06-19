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

#include "datastruct.h"

char* get_raphael_filename(char* filename, int index){
	char *buf;
	int len = snprintf(NULL, 0, "%s_%03d.js", filename,index);
	buf = (char*)malloc( (len + 1) * sizeof(char) );
	sprintf(buf, "%s_%03d.js", filename,index);
	return buf;
}

char* get_raphael_canvasname( int index){

	char *buf;
	int len = snprintf(NULL, 0, "canvas_%03d", index);
	buf = (char*)malloc( (len + 1) * sizeof(char) );
	sprintf(buf, "canvas_%03d", index);
	return buf;
}
char* get_raphael_jsobject_name(char* filename, int index){
	char *buf;
	int len = snprintf(NULL, 0, "paper%03d", index);
	buf = (char*)malloc( (len + 1) * sizeof(char) );
	sprintf(buf, "paper%03d", index);
	return buf;
}

void raphael_text(const char *str, DOCDesc *pd){
    for( ; *str ; str++)
	switch(*str) {
	case '"':
		fprintf(pd->dmlFilePointer, "\\\"");
	    break;

	case '\n':
		fprintf(pd->dmlFilePointer, "\\\n");
	    break;

	default:
	    fputc(*str, pd->dmlFilePointer);
	    break;
	}
}
