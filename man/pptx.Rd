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
  an object of class \code{"pptx"}.
}
\description{
  Create a \code{"pptx"} object
}
\details{
  To send R output in a pptx document, a slide (see
  \code{\link{addSlide.pptx}} have to be added to the
  object first (because output is beeing written in
  slides).

  Several methods can used to send R output into an object
  of class \code{"pptx"}.

  \itemize{ \item \code{\link{addTitle.pptx}} add titles
  \item \code{\link{addParagraph.pptx}} add texts \item
  \code{\link{addPlot.pptx}} add plots \item
  \code{\link{addTable.pptx}} add tables \item
  \code{\link{addFlexTable.docx}} add
  \code{\link{FlexTable}} \item \code{\link{addDate.pptx}}
  add a date (most often in the bottom left area of the
  slide) \item \code{\link{addFooter.pptx}} add a comment
  in the footer (most often in the bottom center area of
  the slide) \item \code{\link{addPageNumber.pptx}} add a
  page number (most often in the bottom right area of the
  slide) \item \code{\link{addImage.pptx}} add external
  images } Once object has content, user can write the pptx
  into a ".pptx" file, see \code{\link{writeDoc}}.
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

# PowerPoint document to write
pptx.file <- "document_example.pptx"

# set default font to 28pt
options("ReporteRs-fontsize" = 28)

# Create a new document
doc = pptx( title = "title" )

# display layouts names
slide.layouts( doc )

# add a slide with layout "Title Slide"
doc = addSlide( doc, slide.layout = "Title Slide" )

doc = addTitle( doc, "Presentation title" ) #set the main title
doc = addSubtitle( doc , "This document is generated with ReporteRs.")#set the sub-title

# add a slide with layout "Title and Content" then add content
doc = addSlide( doc, slide.layout = "Two Content" )
doc = addTitle( doc, "Texts demo" ) #set the main title
texts = c( "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
, "In sit amet ipsum tellus. Vivamus dignissim arcu sit amet faucibus auctor."
, "Quisque dictum tristique ligula."
)
# add simple text
doc = addParagraph( doc, value = texts)

# Add "My tailor is rich" and "Cats and Dogs"
# format some of the pieces of text
# Add "My tailor is rich" and "Cats and Dogs"
# format some of the pieces of text
pot1 = pot("My tailor"
     , textProperties(color="red") ) + " is " + pot("rich"
             , textProperties(font.weight="bold") )
pot2 = pot("Cats", textProperties(color="red")
) + " and " + pot("Dogs", textProperties(color="blue") )
doc = addParagraph(doc, set_of_paragraphs( pot1, pot2 ) )


myplot = qplot(Sepal.Length, Petal.Length
     , data = iris, color = Species
     , size = Petal.Width, alpha = I(0.7)
)
doc = addSlide( doc, slide.layout = "Title and Content" )

# Add title and then 'myplot'
doc = addTitle( doc, "Plot example" )
doc = addPlot( doc, function( ) print( myplot ), pointsize = 11 )

doc = addSlide( doc, slide.layout = "Title and Content" )
# Add title and then a sample of iris
doc = addTitle( doc, "Table example" )
doc = addTable( doc, data = iris[25:33, ] )

# write the doc
writeDoc( doc, pptx.file)
#STOP_TAG_TEST
}
\references{
  Wikipedia: Office Open
  XML\cr\url{http://en.wikipedia.org/wiki/Office_Open_XML}
}
\seealso{
  \code{\link{addTitle.pptx}}, \code{\link{addImage.pptx}},
  \code{\link{addParagraph.pptx}} ,
  \code{\link{addPlot.pptx}}, \code{\link{addTable.pptx}} ,
  \code{\link{slide.layouts.pptx}},
  \code{\link{writeDoc.pptx}}
}

