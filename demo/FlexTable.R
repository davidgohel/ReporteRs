library( ReporteRs )
data( gforge_datacopy )


datamatrix = t(as.matrix(gforge_datacopy))
row.names( datamatrix ) = c("Gender", "Male", "Female", "Age"
		, "Mean (SD)", "Ulceration" ,"Absent", "Present"
		, "Thickness", "Mean (SD)")

myFlexTable = FlexTable( data = datamatrix, header.columns=FALSE, add.rownames=T
		, body.cell.props = cellProperties(border.width=0, padding=0)
		, body.par.props = parProperties(padding=0)
		, body.text.props = textProperties()
)
myFlexTable

cp01 = cellProperties(border.bottom.width=0, border.left.width=0, border.right.width=0, border.top.width=2)
cp02 = cellProperties(border.bottom.width=1, border.left.width=0, border.right.width=0, border.top.width=2)

headerRow = FlexRow()
headerRow[1] = FlexCell( ""
		, par.properties = parProperties()
		, cell.properties = cp01, colspan = 3 )
headerRow[2] = FlexCell( pot("Death", format=textProperties(font.weight="bold") )
		, par.properties = parProperties(text.align="center")
		, cell.properties = cp02
		, colspan = 2 )
myFlexTable = addHeaderRow( myFlexTable, headerRow )


cp1 = cellProperties(border.bottom.width=1, border.left.width=0
		, border.right.width=0, border.top.width=0)
cp2 = cellProperties(border.bottom.width=1, border.left.width=0
		, border.right.width=0, border.top.width=1)

headerRow = FlexRow()
headerRow[1] = FlexCell( "", par.properties = parProperties(text.align="center"), cell.properties = cp1 )
headerRow[2] = FlexCell( "Total", par.properties = parProperties(text.align="center"), cell.properties=cp1)
headerRow[3] = FlexCell( "Alive", par.properties = parProperties(text.align="center"), cell.properties=cp1)
headerRow[4] = FlexCell( "Melanoma", par.properties = parProperties(text.align="center"), cell.properties=cp2)
headerRow[5] = FlexCell("Non Melanoma", par.properties = parProperties(text.align="center"), cell.properties=cp2)

myFlexTable = addHeaderRow( myFlexTable, headerRow )

myFlexTable[ c(1,4,6,9), ] = textProperties( font.weight="bold" )
myFlexTable[ c(1,4,6,9), ] = parProperties(text.align="left", padding = 0)
myFlexTable[ c(2,3,5,7,8,10), ] = parProperties(text.align="right")
myFlexTable[ c(2,3,5,7,8,10), 3] = cellProperties( background.color="#EBEBEB", border.width=0 )

myFlexTable[9, 1, text.properties = textProperties(font.weight="bold", vertical.align="superscript")] = "a"
footerRow = FlexRow()
footerRow[1] = FlexCell( pot("a", format=textProperties(font.weight="bold", vertical.align="superscript") ) + pot(" Also known as Breslow thickness", format=textProperties(color="gray") )
		, par.properties = parProperties(text.align="left")
		, cell.properties = cellProperties(border.bottom.width=0, border.left.width=0, border.right.width=0, border.top.width=1) 
		, colspan=5
)
myFlexTable = addFooterRow( myFlexTable, footerRow )
