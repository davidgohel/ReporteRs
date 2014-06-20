require( ReporteRs )

# Word document to write
docx.file = "document_new.docx"

# create document
doc = docx( title = "My example"
  , template = file.path( find.package("ReporteRs"), "templates/bookmark_example.docx")
  )

# replace bookmarks 'AUTHOR' and 'REVIEWER'
# located in 'ttest_example.docx' by dummy values
doc = addParagraph( doc
	, value = c( "James Sonny Crockett", "Ricardo Rico Tubbs" )	
	, stylename = "Normal"
	, bookmark = "AUTHOR" )
doc = addParagraph( doc
	, value = c( "Martin Marty Castillo" )	
	, stylename = "Normal"
	, bookmark = "REVIEWER" )



MyFTable = FlexTable( data = mtcars[1:10, ]
	, add.rownames=TRUE
)

# replace bookmarks 'DATA' and 'CONFINT' located in 'ttest_example.docx'
# by data.frame objects 'data' and 'conf.int'
doc = addFlexTable( doc
	, MyFTable
	, bookmark = "DATA1" )

# replace bookmarks 'DATA' and 'CONFINT' located in 'ttest_example.docx' 
# by data.frame objects 'data' and 'conf.int'
doc = addTable( doc
	, head( iris )
	, bookmark = "DATA2" )

doc = addPlot( doc, vector.graphic = TRUE
	, fun = function(){
		require(stats)
		sale5 <- c(6, 4, 9, 7, 6, 12, 8, 10, 9, 13)
		plot(sale5)
		abline(lsfit(1:10, sale5))
		abline(lsfit(1:10, sale5, intercept = FALSE), col = 4) 
	}
	, bookmark = "PLOT")


doc = addParagraph( doc, value = c( "Header 1" )
	, stylename = "NAMESTYLE", bookmark = "COLNAME1" )

doc = addParagraph( doc, value = c( "Header 2" )
	, stylename = "NAMESTYLE", bookmark = "COLNAME2" )

doc = addParagraph( doc, value = c( "Header 3" )
	, stylename = "NAMESTYLE", bookmark = "COLNAME3" )

doc = addParagraph( doc, value = c( "Row name 1" )
	, stylename = "NAMESTYLE", bookmark = "ROWNAME1" )

doc = addParagraph( doc, value = c( "Row name 2" )
	, stylename = "NAMESTYLE", bookmark = "ROWNAME2" )

doc = addParagraph( doc, value = c( "Hello World" )
	, stylename = "DATASTYLE", bookmark = "ANYDATA" )

writeDoc( doc, docx.file )

