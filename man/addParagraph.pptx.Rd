\name{addParagraph.pptx}
\alias{addParagraph.pptx}
\title{Insert a paragraph into a pptx object}
\usage{
  \method{addParagraph}{pptx} (doc, value, ...)
}
\arguments{
  \item{doc}{Object of class \code{"pptx"} where paragraph
  has to be added}

  \item{value}{character vector containing texts to add OR
  an object of class \code{\link{set_of_paragraphs}}.}

  \item{...}{further arguments, not used.}
}
\value{
  an object of class \code{"pptx"}.
}
\description{
  Insert paragraph(s) of text into a \code{pptx} object
}
\examples{
#START_TAG_TEST
# Create a new document
doc <- pptx( )
# Add a slide
doc = addSlide( doc, slide.layout = "Title and Content" )
# Add "Hello World" into the document doc
doc <- addParagraph(doc, "Hello Word!" )

# Add a slide
doc = addSlide( doc, slide.layout = "Title and Content" )
# Add into the document : "My tailor is rich" and "Cats and Dogs"
# format some of the pieces of text
pot1 = pot("My tailor", textProperties(color="red") ) + " is " + pot("rich"
	, textProperties(font.weight="bold") )
pot2 = pot("Cats", textProperties(color="red") ) + " and " + pot("Dogs"
	, textProperties(color="blue") )
my.pars = set_of_paragraphs( pot1, pot2 )
doc <- addParagraph(doc, my.pars )
writeDoc( doc, "addParagraph_example.pptx")
#STOP_TAG_TEST
}
\seealso{
  \code{\link{pptx}}, \code{\link{addParagraph}}
}

