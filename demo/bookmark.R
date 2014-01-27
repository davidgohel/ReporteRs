require( ReporteRs )

# Word document to write
docx.file = "document.docx"

# Remove file if it already exists
if(file.exists( docx.file )) 
	file.remove( docx.file )

# Word document to use as base document or a template
template.file = file.path( find.package("ReporteRs"), "templates/bookmark_example.docx", fsep = "/" )

# create document
doc = docx( title = "My example", template = template.file )


# replace bookmarks 'AUTHOR' and 'REVIEWER' located in 'ttest_example.docx' by dummy values
doc = addParagraph( doc
		, value = c( "James Sonny Crockett", "Ricardo Rico Tubbs" )	
		, stylename = "Normal"
		, bookmark = "AUTHOR" )
doc = addParagraph( doc
		, value = c( "Martin Marty Castillo" )	
		, stylename = "Normal"
		, bookmark = "REVIEWER" )



# replace bookmarks 'DATA' and 'CONFINT' located in 'ttest_example.docx' by data.frame objects 'data' and 'conf.int'
doc = addTable( doc
		, iris[5:10,]
		, bookmark = "DATA" )


## replace bookmark 'PLOT' by a plot
doc = addPlot( doc
		, fun = plot
		, x = rnorm( 100 )
		, y = rnorm (100 )
		, main = "base plot main title"
		, bookmark = "PLOT")


doc = addParagraph( doc, value = c( "Header 1" ), stylename = "NAMESTYLE", bookmark = "COLNAME1" )
doc = addParagraph( doc, value = c( "Header 2" ), stylename = "NAMESTYLE", bookmark = "COLNAME2" )
doc = addParagraph( doc, value = c( "Header 3" ), stylename = "NAMESTYLE", bookmark = "COLNAME3" )
doc = addParagraph( doc, value = c( "Row name 1" ), stylename = "NAMESTYLE", bookmark = "ROWNAME1" )
doc = addParagraph( doc, value = c( "Row name 2" ), stylename = "NAMESTYLE", bookmark = "ROWNAME2" )
doc = addParagraph( doc, value = c( "Hello World" ), stylename = "DATASTYLE", bookmark = "ANYDATA" )

writeDoc( doc, docx.file )
