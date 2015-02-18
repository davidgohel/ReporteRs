# set default font size to 10
options( "ReporteRs-fontsize" = 11 )

# Word document to write
pptx.file = "presentation_example.pptx"

# Create a new document
doc = pptx( title = "title" )

# display layouts names
slide.layouts( doc )

# add a slide with layout "Title Slide"
doc = addSlide( doc, slide.layout = "Title Slide" )

doc = addTitle( doc, "Presentation title" ) #set the main title
doc = addSubtitle( doc , "This document is generated with ReporteRs.")#set the sub-title


################ TEXT DEMO ################

# add a slide with layout "Title and Content" then add content
doc = addSlide( doc, slide.layout = "Two Content" )

# add a title
doc = addTitle( doc, "Text demo" )
sometext = c( "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
	, "In sit amet ipsum tellus. Vivamus dignissim arcu sit amet faucibus auctor."
	, "Quisque dictum tristique ligula."
)

# add simple text
doc = addParagraph( doc, value = sometext )

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
if( requireNamespace("ggplot2", quietly = TRUE) ){
  doc = addSlide( doc, slide.layout = "Title and Content" )
  doc = addTitle( doc, "Plot examples" )

  myplot = ggplot2::qplot(Sepal.Length, Petal.Length
    , data = iris, color = Species
    , size = Petal.Width, alpha = I(0.7)
)
  # Add titles and then 'myplot'
  doc = addPlot( doc, function( ) print( myplot ) )
}

################ FLEXTABLE DEMO ################
doc = addSlide( doc, slide.layout = "Title and Content" )
doc = addTitle( doc, "FlexTable example" )

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

# write the doc
writeDoc( doc, file = pptx.file )
