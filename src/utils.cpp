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


