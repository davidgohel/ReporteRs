require( ggplot2 )

# Word document to write
docx.file = "document_example.docx"

# set default font size to 10
options( "ReporteRs-fontsize" = 10 )

# Create a new document
doc = docx( title = "title" )

# display available styles
styles( doc )

# add title
doc = addParagraph( doc, "Document title", stylename = "TitleDoc" )

# add a paragraph
doc = addParagraph( doc , "This document is generated with ReporteRs."
  , stylename="Citationintense")

# add page break
doc = addPageBreak( doc )

# add a title
doc = addTitle( doc, "Table of contents", level =  1 )

################ TOC DEMO ################
# add a table of content
doc = addTOC( doc )

# add page break and then tables of contents for produced plots and tables
doc = addPageBreak( doc )
doc = addTitle( doc, "List of graphics", level =  1 )
doc = addTOC( doc, stylename = "rPlotLegend" )
doc = addTitle( doc, "List of tables", level =  1 )
doc = addTOC( doc, stylename = "rTableLegend" )

# add page break
doc = addPageBreak( doc )

################ TEXT DEMO ################

# add a title
doc = addTitle( doc, "Texts demo", level =  1 )
texts = c( "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
  , "In sit amet ipsum tellus. Vivamus dignissim arcu sit amet faucibus auctor."
  , "Quisque dictum tristique ligula."
)

# add simple text
doc = addParagraph( doc, value = texts, stylename="BulletList" )

# Add "My tailor is rich" and "Cats and Dogs"
# format some of the pieces of text
pot1 = pot("My tailor"
        , textProperties(color="red", font.size = 12 ) ) + " is " + pot("rich"
        , textProperties(font.weight="bold") )
pot2 = pot("Cats"
  , textProperties(color="red", font.size = 12)
  ) + " and " + pot("Dogs"
    , textProperties(color="blue", font.size = 12) )
doc = addParagraph(doc, set_of_paragraphs( pot1, pot2 ), stylename="Normal" )

################ PLOT DEMO ################

myplot = qplot(Sepal.Length, Petal.Length
  , data = iris, color = Species
  , size = Petal.Width, alpha = I(0.7)
)
# Add titles and then 'myplot'
doc = addTitle( doc, "Plot examples", level =  1 )
doc = addPlot( doc, function( ) print( myplot ) )
# Add a legend below the plot
doc = addParagraph( doc, value = "my first plot", stylename = "rPlotLegend")

################ TABLE DEMO ################

# Add a table
doc = addTitle( doc, "Table example", level =  1 )
# add iris sample
doc = addTable( doc, data = iris[25:33, ] )
# Add a legend below the table
doc = addParagraph( doc, value = "my first table", stylename = "rTableLegend")


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

# applies a border grid on table
MyFTable = setFlexTableBorders(MyFTable
  , inner.vertical = borderProperties( color="#EDBD3E", style="dotted" )
  , inner.horizontal = borderProperties( color = "#EDBD3E", style = "none" )
  , outer.vertical = borderProperties( color = "#EDBD3E", style = "solid" )
  , outer.horizontal = borderProperties( color = "#EDBD3E", style = "solid" )
)

# add MyFTable into document 
doc = addFlexTable( doc, MyFTable )

# write the doc
writeDoc( doc, file = docx.file)
