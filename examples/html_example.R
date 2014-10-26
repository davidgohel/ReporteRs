require( ggplot2 )

# directory for html pages
html_directory = "html_example"

# set default font size to 11
options( "ReporteRs-fontsize" = 11 )

# Create a new document
doc = html( title = "document title" )

# add a page 
doc = addPage( doc, title = "HTML demo" )


################ TEXT DEMO ################

# add a title
doc = addTitle( doc, "Text demo", level = 1 )
sometext = c( "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
  	, "In sit amet ipsum tellus. Vivamus dignissim arcu sit amet faucibus auctor."
    , "Quisque dictum tristique ligula."
)

# add simple text
doc = addParagraph( doc, value = sometext )

# Add "My tailor is rich" and "Cats and Dogs"
# format some of the pieces of text
pot1 = pot("My tailor"
	, textProperties(color="red", shading.color = "#CCCCCC" ) ) + " is " + pot("rich"
	, textProperties(font.weight="bold") )
pot2 = pot("Cats"
	, textProperties(color="red" )
	) + " and " + pot("Dogs"
	, textProperties(color="blue" ) )
doc = addParagraph(doc, set_of_paragraphs( pot1, pot2 ) )

doc = addParagraph(doc, "Silentium tractibus per minimis ne excita 
ut temptentur generalibus quam primordiis per clades post delictis 
iuge exitium silentium per et.", 
	par.properties = parProperties( padding.left = 25, padding.right = 25) )


doc = addParagraph(doc, pot("Gallus necem refert singula modum quae 
est quae quorum leo quae non cadaveribus ut quod.", format = textItalic( ) ), 
	par.properties = parProperties(list.style = "blockquote") )


ordered.list.level1 = parProperties(list.style = "ordered", level = 1 )
ordered.list.level2 = parProperties(list.style = "ordered", level = 2 )

doc = addParagraph( doc, value = sometext, par.properties = ordered.list.level1 )
doc = addParagraph( doc, value = sometext, par.properties = ordered.list.level2 )

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
# use different formatting properties for header and body
MyFTable = FlexTable( data = mtcars, add.rownames = TRUE, 
	header.cell.props = cellProperties( background.color = "#00557F" ), 
	header.text.props = textProperties( color = "white", 
		font.size = 11, font.weight = "bold" ), 
	body.text.props = textProperties( font.size = 10 )
)
# zebra stripes - alternate colored backgrounds on table rows
MyFTable = setZebraStyle( MyFTable, odd = "#E1EEf4", even = "white" )

# applies a border grid on table
MyFTable = setFlexTableBorders(MyFTable,
	inner.vertical = borderProperties( color="#0070A8", style="solid" ),
	inner.horizontal = borderNone(),
	outer.vertical = borderProperties( color = "#006699", style = "solid", width = 2 ),
	outer.horizontal = borderProperties( color = "#006699", style = "solid", width = 2 )
)

# add MyFTable into document 
doc = addFlexTable( doc, MyFTable )

# Write the object into a directory
writeDoc( doc, directory = html_directory )
