library( ReporteRs )


toto = FlexTable( data= iris[1:5,], cell_format=dataCellProps, par_format=parProperties(padding=0)
		, text_format = textProperties(color="blue")
)

headerparProps = parProperties(padding=0, text.align="center")
headerCellProps = cellProperties( padding=0, border.bottom.width=1, border.left.width=0, border.top.width=0, border.right.width=0 )
headerRow = FlexRow()
headerRow[1] = FlexCell( "coco", parProp = headerparProps, cellProp=headerCellProps)
headerRow[2] = FlexCell( "cici", parProp = headerparProps, cellProp=headerCellProps)
headerRow[3] = FlexCell( "cucu", parProp = headerparProps, cellProp=headerCellProps)
headerRow[4] = FlexCell( "toto", parProp = headerparProps, cellProp=headerCellProps)
headerRow[5] = FlexCell( "titi", parProp = headerparProps, cellProp=headerCellProps)

toto[-1] = headerRow

headerRow = FlexRow()
headerRow[1] = FlexCell( "Yo baby", parProp = headerparProps, cellProp=headerCellProps, colspan=3)
headerRow[2] = FlexCell( "toto", parProp = headerparProps, cellProp=headerCellProps)
headerRow[3] = FlexCell( "titi", parProp = headerparProps, cellProp=headerCellProps)
toto[-2] = headerRow
toto[1,2] = 
		
		toto = update( toto, 1:2, 2:3, cellProperties( background.color="red"))




# PowerPoint document to write
docx.file <- "~/document.docx"


# Create a new document
doc = docx( title = "title" )
# display layouts names
styles( doc )

doc = addFlexTable( doc, toto )


# write the doc
writeDoc( doc, docx.file)
browseURL( docx.file )