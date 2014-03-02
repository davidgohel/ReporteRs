\name{html}
\alias{html}
\title{Create an HTML document object representation}
\usage{
html(title = "untitled")
}
\arguments{
  \item{title}{\code{"character"} value: title of the
  document (in the doc properties).}
}
\value{
an object of class \code{"html"}.
}
\description{
Create a \code{"html"} object
}
\details{
\code{html} objects are experimental ; codes and api will
probably change later.

To send R output in an html document, a page (see
\code{\link{addPage.html}} have to be added to the object
first (because output is beeing written in pages).

Several methods can used to send R output into an object of
class \code{"html"}.

\itemize{ \item \code{\link{addTitle.html}} add titles
\item \code{\link{addImage.html}} add external images \item
\code{\link{addParagraph.html}} add texts \item
\code{\link{addPlot.html}} add plots \item
\code{\link{addTable.html}} add tables \item
\code{\link{addFlexTable.docx}} add \code{\link{FlexTable}}
\item \code{\link{addRScript.html}} add R Script } Once
object has content, user can write the htmls pages into a
directory, see \code{\link{writeDoc.html}}.
}
\examples{
#START_TAG_TEST
# Create a new document
require( ggplot2 )

# Web pages directory
html.directory <- "document_example"

# Create a new document
doc = html( title = "document title" )

# add a page with title "Page 1"
doc = addPage( doc, title = "Page 1" )


myplot = qplot(Sepal.Length, Petal.Length
             , data = iris, color = Species
             , size = Petal.Width, alpha = I(0.7)
)
# Add myplot
doc = addTitle( doc, "Plot example 1", level = 1 )
doc = addPlot( doc, function( ) print( myplot ) )

doc = addTitle( doc, "Texts demo", level = 1 )
texts = c( "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
, "In sit amet ipsum tellus. Vivamus dignissim arcu sit amet faucibus auctor."
, "Quisque dictum tristique ligula."
)
# add simple text
doc = addParagraph( doc, value = texts )

# Add "My tailor is rich" and "Cats and Dogs"
# format some of the pieces of text
pot1 = pot("My tailor"
     , textProperties(color="red", font.size = 12 ) ) + " is " + pot("rich"
             , textProperties(font.weight="bold") )
pot2 = pot("Cats", textProperties(color="red", font.size = 12)
             ) + " and " + pot("Dogs", textProperties(color="blue", font.size = 12) )
doc <- addParagraph(doc, set_of_paragraphs( pot1, pot2 ) )

# add a page with title "Page 2"
doc = addPage( doc, title = "Page 2" )

# Add title and then a sample of iris
doc = addTitle( doc, "Table example", level = 1 )
doc = addTable( doc, data = iris[25:33, ] )

# generate html pages within html.directory
html.files = writeDoc( doc, directory = html.directory )
print(html.files) # return produced html files
#STOP_TAG_TEST
}
\seealso{
\code{\link{docx}}, \code{\link{pptx}}
}

