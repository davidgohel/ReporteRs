\name{pptx}
\alias{pptx}
\title{Create Microsoft PowerPoint document object representation}
\usage{
pptx(title, template)
}
\arguments{
  \item{title}{\code{"character"} value: title of the
  document (in the doc properties).}

  \item{template}{\code{"character"} value, it represents
  the filename of the pptx file used as a template.}
}
\value{
an object of class \code{\link{pptx}}.
}
\description{
Create a \code{\link{pptx}} object
}
\details{
To send R output in a pptx document, a slide (see
\code{\link{addSlide.pptx}} have to be added to the object
first (because output is beeing written in slides).

Several methods can used to send R output into an object of
class \code{\link{pptx}}.

\itemize{ \item \code{\link{addTitle.pptx}} add titles
\item \code{\link{addParagraph.pptx}} add text \item
\code{\link{addPlot.pptx}} add plots \item
\code{\link{addTable.pptx}} add tables \item
\code{\link{addFlexTable.pptx}} add \code{\link{FlexTable}}
\item \code{\link{addDate.pptx}} add a date (most often in
the bottom left area of the slide) \item
\code{\link{addFooter.pptx}} add a comment in the footer
(most often in the bottom center area of the slide) \item
\code{\link{addPageNumber.pptx}} add a page number (most
often in the bottom right area of the slide) \item
\code{\link{addImage.pptx}} add external images } Once
object has content, user can write the pptx into a ".pptx"
file, see \code{\link{writeDoc}}.
}
\note{
Power Point 2007-2013 (*.pptx) file formats are the only
supported files.

Document are manipulated in-memory ; a \code{pptx}'s
document is not written to the disk unless the
\code{\link{writeDoc}} method has been called on the
object.
}
\examples{
#START_TAG_TEST
require( ggplot2 )

# Word document to write
pptx.file = "presentation_example.pptx"

# set default font size to 26
options( "ReporteRs-fontsize" = 26 )

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
doc = addSlide( doc, slide.layout = "Title and Content" )
doc = addTitle( doc, "Plot examples" )

myplot = qplot(Sepal.Length, Petal.Length
		, data = iris, color = Species
		, size = Petal.Width, alpha = I(0.7)
)
# Add titles and then 'myplot'
doc = addPlot( doc, function( ) print( myplot ) )

################ TABLE DEMO ################
doc = addSlide( doc, slide.layout = "Title and Content" )
doc = addTitle( doc, "Table example" )

# add iris sample
doc = addTable( doc, data = iris[25:33, ] )

################ FLEXTABLE DEMO ################
doc = addSlide( doc, slide.layout = "Title and Content" )
doc = addTitle( doc, "FlexTable example" )

# set default font size to 10
options( "ReporteRs-fontsize" = 10 )

# Create a FlexTable with data.frame mtcars, display rownames
# use different formatting properties for header and body cells
MyFTable = FlexTable( data = mtcars[1:15,], add.rownames = TRUE
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

# write the doc
writeDoc( doc, file = pptx.file )
#STOP_TAG_TEST
}
\references{
Wikipedia: Office Open
XML\cr\url{http://en.wikipedia.org/wiki/Office_Open_XML}
}
\seealso{
\code{\link{addTitle.pptx}}, \code{\link{addImage.pptx}} ,
\code{\link{addParagraph.pptx}},
\code{\link{addPlot.pptx}}, \code{\link{addTable.pptx}} ,
\code{\link{slide.layouts.pptx}}, \code{\link{dim.pptx}},
\code{\link{writeDoc.pptx}}
}

