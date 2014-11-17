\name{docx}
\alias{docx}
\title{Create Microsoft Word document object representation}
\usage{
docx(title = "untitled", template,
  list.definition = getOption("ReporteRs-list-definition"))
}
\arguments{
  \item{title}{\code{"character"} value: title of the
  document (in the doc properties).}

  \item{template}{\code{"character"} value, it represents
  the filename of the docx file used as a template.}

  \item{list.definition}{a list definition to specify how
  ordered and unordered lists have to be formated. See
  \code{\link{list.settings}}. Default to
  \code{getOption("ReporteRs-list-definition")}.}
}
\value{
an object of class \code{\link{docx}}.
}
\description{
Create a \code{\link{docx}} object
}
\details{
Several methods can used to send R output into an object of
class \code{\link{docx}}.

\itemize{ \item \code{\link{addTitle.docx}} add titles
\item \code{\link{addParagraph.docx}} add text \item
\code{\link{addPlot.docx}} add plots \item
\code{\link{addFlexTable.docx}} add tables. See
\code{\link{FlexTable}} \item \code{\link{addImage.docx}}
add external images \item \code{\link{addMarkdown.docx}}
add markdown text \item \code{\link{addTOC.docx}} add table
of content \item \code{\link{addPageBreak.docx}} add page
break \item \code{\link{addSection.docx}} add section }

R outputs (tables, plots, paragraphs and images) can be
inserted (and not added at the end) in a document if a
bookmark exists in the template file. See
\code{\link{bookmark}}.

Once object has content, user can write the docx into a
".docx" file, see \code{\link{writeDoc}}.
}
\note{
Word 2007-2013 (*.docx) file formats are the only supported
files.\cr Document are manipulated in-memory ; a
\code{docx}'s document is not written to the disk unless
the \code{\link{writeDoc}} method has been called on the
object.
}
\examples{
#START_TAG_TEST
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
doc = addTitle( doc, "Text demo", level =  1 )


sometext = c( "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
  , "In sit amet ipsum tellus. Vivamus dignissim arcu sit amet faucibus auctor."
  , "Quisque dictum tristique ligula."
)
# add simple text with 'Normal' style
doc = addParagraph( doc, value = sometext, stylename="Normal" )
# add simple text with 'BulletList' style
doc = addParagraph( doc, value = sometext, stylename="BulletList" )

# Add "My tailor is rich" and "Cats and Dogs"
# format some of the pieces of text
pot1 = pot("My tailor"
  , textProperties(color="red", shading.color = "#CCCCCC" ) ) + " is " + pot("rich"
	, textProperties(font.weight="bold") )
pot2 = pot("Cats"
	, textProperties(color="red" )
	) + " and " + pot("Dogs"
	, textProperties(color="blue" ) )
doc = addParagraph(doc, set_of_paragraphs( pot1, pot2 ), stylename="Normal" )

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
writeDoc( doc, file = docx.file)
#STOP_TAG_TEST
}
\references{
Wikipedia: Office Open
XML\cr\url{http://en.wikipedia.org/wiki/Office_Open_XML}
}
\seealso{
\code{\link{bsdoc}}, \code{\link{pptx}},
\code{\link{bookmark}}
}

