/*
 * This file is part of ReporteRs.
 * Copyright (c) 2014, David Gohel All rights reserved.
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
#include <wchar.h>

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

void raphael_textUTF8(const char *str, DOCDesc *pd){
	unsigned char *p;
	p = (unsigned char *) str;
	int val, val1, val2, val3, val4;
	while(*p){
		val = *(p++);
		if( val < 128 ){ /* ASCII */
			fprintf(pd->dmlFilePointer, "%c", val);
		} else if( val > 240 ){ /* 4 octets*/
			val1 = (val - 240) * 65536;
			val = *(p++);
			val2 = (val - 128) * 4096;
			val = *(p++);
			val3 = (val - 128) * 64;
			val = *(p++);
			val4 = val - 128;
			val = val1 + val2 + val3 + val4;

			char byte1 = 0xf0 | ((val & 0x1C0000) >> 18);
			char byte2 = 0x80 | ((val & 0x3F000)  >> 12);
			char byte3 = 0x80 | ((val & 0xFC0) >> 6);
			char byte4 = 0x80 | (val & 0x3f);
			fprintf(pd->dmlFilePointer, "%c%c%c%c", byte1, byte2, byte3, byte4);
		} else {
			if( val >= 224 ){ /* 3 octets : 224 = 128+64+32 */
				val1 = (val - 224) * 4096;
				val = *(p++);
				val2 = (val-128) * 64;
				val = *(p++);
				val3 = (val-128);
				val = val1 + val2 + val3;
				char byte1 = 0xe0 | ((val & 0xf000) >> 12);
				char byte2 = 0x80 | ((val & 0xfc0)  >> 6);
				char byte3 = 0x80 | (val & 0x3f);
				fprintf(pd->dmlFilePointer, "%c%c%c", byte1, byte2, byte3);
			} else { /* 2 octets : >192 = 128+64 */
				val1 = (val - 192) * 64;
				val = *(p++);
				val2 = val-128;
				val = val1 + val2;
				char byte1 = 0xc0 | ((val & 0x7c0) >> 6);
				char byte2 = 0x80 | (val & 0x3f);
				fprintf(pd->dmlFilePointer, "%c%c", byte1, byte2);
			}

		}
	}
}

