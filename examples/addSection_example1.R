doc = addSection(doc, landscape = TRUE, ncol = 2 ) 
doc = addPlot( doc = doc, fun = function() {
		barplot( 1:8, col = 1:8 )
	}, width = 3, height = 3, pointsize = 5)

doc = addColumnBreak(doc ) 
doc = addFlexTable(doc, FlexTable( iris[1:10,] ) )

doc = addSection(doc, ncol = 2 ) 
doc = addParagraph( doc = doc, "Text 1.", "Normal" )
doc = addColumnBreak(doc ) 
doc = addParagraph( doc = doc, "Text 2.", "Normal" )


doc = addSection(doc, ncol = 2, columns.only = TRUE ) 
doc = addFlexTable(doc, FlexTable(iris[1:10,] ) )
doc = addColumnBreak(doc ) 
doc = addParagraph( doc = doc, "Text 3.", "Normal" )


doc = addSection( doc ) 
doc = addFlexTable(doc, FlexTable(mtcars, add.rownames = TRUE) )
doc = addParagraph( doc = doc, "Text 4.", "Normal" )
