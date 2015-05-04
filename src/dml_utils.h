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

#include <stdio.h>
#include <Rinternals.h>
#include <R.h>

#include <R_ext/GraphicsEngine.h>
#include <R_ext/GraphicsDevice.h>

double p2e_(double x);
char* get_dml_filename(char* filename, int index);

void DML_SetFillColor(pDevDesc dev, R_GE_gcontext *gc);
void DML_SetFontColor(pDevDesc dev, R_GE_gcontext *gc);
void DML_SetLineSpec(pDevDesc dev, R_GE_gcontext *gc);
void dml_text_native(const char *str, DOCDesc *pd);
double getStrWidth(const char *str, double w);
int get_and_increment_idx(pDevDesc dev);
