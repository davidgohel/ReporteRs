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

