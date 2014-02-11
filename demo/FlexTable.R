library( ReporteRs )
data( gforge_datacopy )


datamatrix = t(as.matrix(gforge_datacopy))
row.names( datamatrix ) = c("Gender", "Male", "Female", "Age"
	, "Mean (SD)", "Ulceration" ,"Absent", "Present"
	, "Thickness", "Mean (SD)")

myFlexTable = FlexTable( data = datamatrix, header.columns=FALSE, row.names=T
		, cell_format = cellProperties(border.width=0, padding=0)
		, par_format = parProperties(padding=0)
		, text_format = textProperties()
)
myFlexTable

cp01 = cellProperties(border.bottom.width=0, border.left.width=0, border.right.width=0, border.top.width=2)
cp02 = cellProperties(border.bottom.width=1, border.left.width=0, border.right.width=0, border.top.width=2)

headerRow = FlexRow()
headerRow[1] = FlexCell( ""
	, parProp = parProperties()
	, cellProp = cp01, colspan = 3 )
headerRow[2] = FlexCell( pot("Death", format=textProperties(font.weight="bold") )
	, parProp = parProperties(text.align="center")
	, cellProp = cp02
	, colspan = 2 )
myFlexTable = addHeaderRow( myFlexTable, headerRow )


cp1 = cellProperties(border.bottom.width=1, border.left.width=0
	, border.right.width=0, border.top.width=0)
cp2 = cellProperties(border.bottom.width=1, border.left.width=0
	, border.right.width=0, border.top.width=1)

headerRow = FlexRow()
headerRow[1] = FlexCell( "", parProp = parProperties(text.align="center"), cellProp = cp1 )
headerRow[2] = FlexCell( "Total", parProp = parProperties(text.align="center"), cellProp=cp1)
headerRow[3] = FlexCell( "Alive", parProp = parProperties(text.align="center"), cellProp=cp1)
headerRow[4] = FlexCell( "Melanoma", parProp = parProperties(text.align="center"), cellProp=cp2)
headerRow[5] = FlexCell("Non Melanoma", parProp = parProperties(text.align="center"), cellProp=cp2)

myFlexTable = addHeaderRow( myFlexTable, headerRow )

myFlexTable[ c(1,4,6,9), ] = textProperties( font.weight="bold" )
myFlexTable[ c(1,4,6,9), ] = parProperties(text.align="left", padding = 0)
myFlexTable[ c(2,3,5,7,8,10), ] = parProperties(text.align="right")
myFlexTable[ c(2,3,5,7,8,10), 3] = cellProperties( background.color="#EBEBEB", border.width=0 )

myFlexTable = setFlexCellContent( myFlexTable, 9, 1, pot("Thickness", format=textProperties(font.weight="bold") ) + pot("a"
		, format=textProperties(font.weight="bold", vertical.align="superscript") ) )
footerRow = FlexRow()
footerRow[1] = FlexCell( pot("a", format=textProperties(font.weight="bold", vertical.align="superscript") ) + pot(" Also known as Breslow thickness", format=textProperties(color="gray") )
				, parProp = parProperties(text.align="left")
				, cellProp = cellProperties(border.bottom.width=0, border.left.width=0, border.right.width=0, border.top.width=1) 
				, colspan=5
		)
myFlexTable = addFooterRow( myFlexTable, footerRow )
