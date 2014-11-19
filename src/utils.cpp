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

#include "utils.h"
#include "datastruct.h"


void set_tracer_on(int *dn) {
	pGEDevDesc dev= GEgetDevice(*dn);
	if (dev) {
		DOCDesc *pd = (DOCDesc *) dev->dev->deviceSpecific;
		pd->elt_tracer->on = 1;
		pd->elt_tracer->isinit = 0;
		pd->elt_tracer->first_elt = -1;
		pd->elt_tracer->last_elt = -1;
	}
}


void set_tracer_off(int *dn) {
	pGEDevDesc dev= GEgetDevice(*dn);
	if (dev) {
		DOCDesc *pd = (DOCDesc *) dev->dev->deviceSpecific;
		pd->elt_tracer->on = 0;
		pd->elt_tracer->isinit = 0;
		pd->elt_tracer->first_elt = -1;
		pd->elt_tracer->last_elt = -1;
	}
}

void collect_id(int *dn, int *res) {
	pGEDevDesc dev= GEgetDevice(*dn);
	if (dev) {
		DOCDesc *pd = (DOCDesc *) dev->dev->deviceSpecific;

		res[0] = pd->elt_tracer->first_elt;
		res[1] = pd->elt_tracer->last_elt;
	}
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


void add_popup(int *dn, int *id, char **str, int *l){
	int nb_elts = *l;
	int i;
	pGEDevDesc dev= GEgetDevice(*dn);
	if (!dev) return;

	DOCDesc *pd = (DOCDesc *) dev->dev->deviceSpecific;
	
	for( i = 0 ; i < nb_elts ; i++ ){
		fprintf(pd->dmlFilePointer, "var box_%d = elt_%d.getBBox();\n", id[i], id[i] );
		fprintf(pd->dmlFilePointer, "var popup_%d = %s.popup(box_%d.x + box_%d.width / 2, box_%d.y + box_%d.height / 2 - 3, \"%s\").hide();\n"
			, id[i], pd->objectname, id[i], id[i], id[i], id[i], str[i] );
		fprintf(pd->dmlFilePointer, "elt_%d.mouseover(function(){popup_%d.show();});\n", id[i], id[i] );
		fprintf(pd->dmlFilePointer, "elt_%d.mouseout(function(){popup_%d.hide();});\n", id[i], id[i] );
	}

}

void add_click(int *dn, int *id, char **str, int *l){
	int nb_elts = *l;
	int i;
	pGEDevDesc dev= GEgetDevice(*dn);
	if (!dev) return;

	DOCDesc *pd = (DOCDesc *) dev->dev->deviceSpecific;

	for( i = 0 ; i < nb_elts ; i++ ){
		fprintf(pd->dmlFilePointer, "elt_%d.click(function(){%s});\n", id[i], str[i] );
	}

}
void add_dblclick(int *dn, int *id, char **str, int *l){
	int nb_elts = *l;
	int i;
	pGEDevDesc dev= GEgetDevice(*dn);
	if (!dev) return;

	DOCDesc *pd = (DOCDesc *) dev->dev->deviceSpecific;

	for( i = 0 ; i < nb_elts ; i++ ){
		fprintf(pd->dmlFilePointer, "elt_%d.dblclick(function(){%s});\n", id[i], str[i] );
	}

}

void add_post_commands( int *dn, int *id, char **str, int *l) {
	int nb_elts = *l;
	int i;

	pGEDevDesc dev= GEgetDevice(*dn);
	if (!dev) return;

	if (dev) {//addPostCommand
		DOCDesc *pd = (DOCDesc *) dev->dev->deviceSpecific;
		SEXP cmdSexp = PROTECT(allocVector(STRSXP, nb_elts));
		for( i = 0 ; i < nb_elts ; i++ ){
			SET_STRING_ELT(cmdSexp, i, mkChar(str[i]));
		}
		SEXP cmdSexp2 = PROTECT(allocVector(INTSXP, nb_elts));
		for( i = 0 ; i < nb_elts ; i++ ){
			INTEGER(cmdSexp2)[i] = id[i];
		}

		eval( lang4(install("addPostCommand")
							, cmdSexp, cmdSexp2, pd->env
							), R_GlobalEnv);
	    UNPROTECT(2);

	};
}

void trigger_last_post_commands( int *dn ) {

	pGEDevDesc dev= GEgetDevice(*dn);
	if (!dev) return;

	if (dev) {
		DOCDesc *pd = (DOCDesc *) dev->dev->deviceSpecific;
		eval( lang2(install("triggerPostCommand"), pd->env), R_GlobalEnv);
	};
}

