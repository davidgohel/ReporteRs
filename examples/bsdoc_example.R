doc = bsdoc( title = "full example" )


doc = addTitle( doc, "Plot example", level = 1 )
# load ggplot2
require( ggplot2 )

# create a ggplot2 plot
myplot = qplot(Sepal.Length, Petal.Length, data = iris
		, color = Species, size = Petal.Width, alpha = I(0.7) )

# Add myplot into object doc
#   myplot is assigned to argument 'x' because function 'print' on ggplot
#   objects is expecting argument 'x'.
doc = addPlot( doc = doc, fun = print, x = myplot )




doc = addTitle( doc, "Text example", level = 1 )

# "My tailor is rich" with formatting on some words
pot1 = pot("My tailor", textProperties(color = "red" ) 
) + " is " + pot("rich", textProperties(shading.color = "red", font.weight = "bold" ) )

# "Cats and dogs" with formatting on some words
pot2 = pot("Cats", textProperties(color = "red" ) 
) + " and " + pot("dogs", textProperties( color = "blue" ), hyperlink = "http://www.wikipedia.org/" )

# create a set of paragraphs made of pot1 and pot2
my.pars = set_of_paragraphs( pot1, pot2 )

# Add my.pars into the document doc
doc = addParagraph(doc, my.pars )


doc = addTitle( doc, "List example", level = 1 )
# define some text
text1 = "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
text2 = "In sit amet ipsum tellus. Vivamus dignissim arcu sit amet faucibus auctor."
text3 = "Quisque dictum tristique ligula."

# define parProperties with list properties
ordered.list.level1 = parProperties(list.style = "ordered", level = 1 )
ordered.list.level2 = parProperties(list.style = "ordered", level = 2 )

# define parProperties with list properties
unordered.list.level1 = parProperties(list.style = "unordered", level = 1 )
unordered.list.level2 = parProperties(list.style = "unordered", level = 2 )

# add ordered list items 
doc = addParagraph( doc, value = text1, 
		par.properties = ordered.list.level1 )
doc = addParagraph( doc, value = text2, 
		par.properties = ordered.list.level2 )

# add ordered list items without restart renumbering
doc = addParagraph( doc, value = c( text1, text2, text3), 
		par.properties = ordered.list.level1 )

# add ordered list items and restart renumbering
doc = addParagraph( doc, value = c( text1, text2, text3), restart.numbering = TRUE, 
		par.properties = ordered.list.level1 )

# add unordered list items
doc = addParagraph( doc, value = text1, 
		par.properties = unordered.list.level1 )
doc = addParagraph( doc, value = text2, 
		par.properties = unordered.list.level2 )

doc = addTitle( doc, "Table example", level = 1 )
#####################################################################

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


#####################################################################
# add a menu
mymenu = BoostrapMenu( title = "my title")

mydd = DropDownMenu( label = "my menu" )
mydd = addLinkItem( mydd, label = "GitHub", "http://github.com/")
mydd = addLinkItem( mydd, separator.after = TRUE)
mydd = addLinkItem( mydd, label = "Wikipedia", "http://www.wikipedia.fr")

mymenu = addLinkItem( mymenu, label = "ReporteRs", "http://github.com/davidgohel/ReporteRs")
mymenu = addLinkItem( mymenu, dd = mydd )

doc = addBootstrapMenu( doc, mymenu )

#####################################################################
# add a footer
doc = addFooter( doc, pot( "Hello world", 
				format = textProperties(color="gray") ), parCenter( padding = 0 ) )

#####################################################################
# write the doc
pages = writeDoc( doc, file = "bsdoc_example/example.html")
