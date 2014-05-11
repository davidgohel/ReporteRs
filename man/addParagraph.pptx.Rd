\name{addParagraph.pptx}
\alias{addParagraph.pptx}
\title{Insert a paragraph into a pptx object}
\usage{
\method{addParagraph}{pptx}(doc, value, ...)
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
doc.filename = "addParagraph_example.pptx"

# set default font size to 24
options( "ReporteRs-fontsize" = 24 )

doc = pptx( title = "title" )

# add a slide with layout "Title and Content"
doc = addSlide( doc, slide.layout = "Title and Content" )

doc = addTitle( doc, "Title example 1", level = 1 )

# Add "Hello World" into the document doc
doc = addParagraph(doc, "Hello Word" )

# add a slide with layout "Title and Content"
doc = addSlide( doc, slide.layout = "Title and Content" )

doc = addTitle( doc, "Title example 2", level = 1 )
# "My tailor is rich" with formatting on some words
pot1 = pot("My tailor", textProperties(color = "red" ) 
  ) + " is " + pot("rich", textProperties( font.weight = "bold" ) )
# "Cats and dogs" with formatting on some words
pot2 = pot("Cats", textProperties(color = "red" ) 
  ) + " and " + pot("dogs", textProperties( color = "blue" ) )

# create a set of paragraphs made of pot1 and pot2
my.pars = set_of_paragraphs( pot1, pot2 )

# Add my.pars into the document doc
doc = addParagraph(doc, my.pars )

# Write the object
writeDoc( doc, file = doc.filename )
#STOP_TAG_TEST
}
\seealso{
\code{\link{pptx}}, \code{\link{addParagraph}}
}

