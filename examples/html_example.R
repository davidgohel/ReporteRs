require( ggplot2 )

# Word document to write
html_directory = "html_example"

# set default font size to 10
options( "ReporteRs-fontsize" = 10 )

# Create a new document
doc = html( title = "document title" )

# add a page 
doc = addPage( doc, title = "HTML demo" )


################ TEXT DEMO ################

# add a title
doc = addTitle( doc, "Text demo", level = 1 )
texts = c( "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
		, "In sit amet ipsum tellus. Vivamus dignissim arcu sit amet faucibus auctor."
		, "Quisque dictum tristique ligula."
)

# add simple text
doc = addParagraph( doc, value = texts  )

# Add "My tailor is rich" and "Cats and Dogs"
# format some of the pieces of text
pot1 = pot("My tailor"
				, textProperties(color="red" ) ) + " is " + pot("rich"
				, textProperties(font.weight="bold") )
pot2 = pot("Cats"
				, textProperties(color="red" )
		) + " and " + pot("Dogs"
				, textProperties(color="blue" ) )
doc = addParagraph(doc, set_of_paragraphs( pot1, pot2 ) )

################ PLOT DEMO ################
doc = addTitle( doc, "Plot demo", level = 1 )

myplot = qplot(Sepal.Length, Petal.Length
		, data = iris, color = Species
		, size = Petal.Width, alpha = I(0.7)
)
# Add titles and then 'myplot'
doc = addPlot( doc, function( ) print( myplot ) )

################ TABLE DEMO ################
doc = addTitle( doc, "Table example", level = 1 )

# add iris sample
doc = addTable( doc, data = iris[25:33, ] )

################ FLEXTABLE DEMO ################
doc = addTitle( doc, "FlexTable example", level = 1 )


# Create a FlexTable with data.frame mtcars, display rownames
# use different formatting properties for header and body cells
MyFTable = FlexTable( data = mtcars, add.rownames = TRUE
		, body.cell.props = cellProperties( border.color = "#EDBD3E")
		, header.cell.props = cellProperties( background.color = "#5B7778" )
)
# zebra stripes - alternate colored backgrounds on table rows
MyFTable = setZebraStyle( MyFTable, odd = "#D1E6E7", even = "#93A8A9" )
MyFTable = setFlexTableWidths( MyFTable, widths = c(2,rep(.7,11)))

# applies a border grid on table
MyFTable = setFlexTableBorders(MyFTable
		, inner.vertical = borderProperties( color="#EDBD3E", style="dotted" )
		, inner.horizontal = borderProperties( color = "#EDBD3E", style = "none" )
		, outer.vertical = borderProperties( color = "#EDBD3E", style = "solid" )
		, outer.horizontal = borderProperties( color = "#EDBD3E", style = "solid" )
)

# add MyFTable into document 
doc = addFlexTable( doc, MyFTable )

# Write the object
writeDoc( doc, directory = html_directory )

