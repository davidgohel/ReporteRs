library( ReporteRs )

data(pbc_summary)

# create an empty FlexTable with nrow(pbc_summary) rows and 5 columns
MyFTable = FlexTable( numrow= nrow(pbc_summary), numcol=5 )
# add 3 first columns of pbc_summary in the corresponding 
# columns of the FlexTable
MyFTable[,1:3, text.properties = textProperties(font.style="italic" )] = pbc_summary[,1:3]
MyFTable[,1:3] = parProperties( text.align = "center")


MyFTable[,4] = sprintf( "%0.2f ", pbc_summary$chol_mean )
MyFTable[,4] = sprintf( "(%0.2f)", pbc_summary$chol_sd )
MyFTable[,5, text.properties = textProperties(color="#666666")] = sprintf( "%d ", pbc_summary$counts )
MyFTable[,5, text.properties = textProperties(color="#666666")] = sprintf( "(%.2f%s)", 100*pbc_summary$missing/pbc_summary$counts, "%" )

MyFTable = spanFlexTableRows( MyFTable, j=1, runs = as.character( pbc_summary$trt ) )
MyFTable = spanFlexTableRows( MyFTable, j=2, runs = as.character( pbc_summary$sex ) )

MyFTable[,4:5] = parProperties( text.align = "right")

# on ajouter 2 lignes d'entetes
MyFTable = addHeaderRow( MyFTable, par.properties = parProperties( text.align = "center")
		, text.properties = textProperties( font.weight="bold")
		, value=c("", "Serum cholesterol (mg/dl)"), colspan=c(3,2)
)
MyFTable = addHeaderRow( MyFTable
		, text.properties = textProperties(font.weight="bold"), par.properties = parProperties( text.align = "center")
		, value=c("Treatment", "Sex", "Status", "Mean (SD)", "Counts (missing obs %)")
)


# definition d'une grille sur le tableau
MyFTable = setFlexTableBorders(MyFTable
		, inner.vertical = borderProperties( style="dotted" )
		, inner.horizontal = borderProperties( style = "dotted" )
		, outer.vertical = borderProperties( style = "solid" )
		, outer.horizontal = borderProperties( style = "solid" )
)

doc = docx( title = "title" )
doc = addFlexTable( doc, MyFTable )
writeDoc( doc, "FlexTable/addFlexTable_example.docx")
#browseURL("FlexTable/addFlexTable_example.docx")
