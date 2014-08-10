\name{addParagraph.pptx}
\alias{addParagraph.pptx}
\title{Insert a paragraph into a pptx object}
\usage{
\method{addParagraph}{pptx}(doc, value, offx, offy, width, height,
  par.properties = parProperties(), ...)
}
\arguments{
  \item{doc}{\code{\link{pptx}} object where paragraph has
  to be added}

  \item{value}{text to add to the document as paragraphs:
  an object of class \code{\link{pot}} or
  \code{\link{set_of_paragraphs}} or a character vector.}

  \item{offx}{optional, x position of the shape (top left
  position of the bounding box) in inch. See details.}

  \item{offy}{optional, y position of the shape (top left
  position of the bounding box) in inch. See details.}

  \item{width}{optional, width of the shape in inch. See
  details.}

  \item{height}{optional, height of the shape in inch. See
  details.}

  \item{par.properties}{a parProperties object}

  \item{...}{further arguments, not used.}
}
\value{
an object of class \code{"pptx"}.
}
\description{
Insert paragraph(s) of text into a \code{pptx} object
}
\details{
If arguments offx, offy, width, height are missing,
position and dimensions will be defined by the width and
height of the next available shape of the slide. This
dimensions can be defined in the layout of the PowerPoint
template used to create the \code{pptx} object.

If arguments offx, offy, width, height are provided, they
become position and dimensions of the new shape.
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

# Add my.pars into the document doc
doc = addParagraph(doc, my.pars, offx = 3, offy = 3, width = 2, height = 0.5
	, par.properties=parProperties(text.align="center", padding=0) )

# add a slide with layout "Title and Content"
doc = addSlide( doc, slide.layout = "Title and Content" )


doc = addTitle( doc, "Title example 3", level = 1 )

# "My tailor is rich" with formatting on some words
pot1 = pot("My tailor", textProperties(color = "red" ) 
  ) + " is " + pot("rich", textProperties( font.weight = "bold" ) )

# "Cats and dogs" with formatting on some words
pot2 = pot("Cats", textProperties(color = "red" ) 
  ) + " and " + pot("dogs", textProperties( color = "blue" ) )

# create a set of paragraphs made of pot1 and pot2
my.pars = set_of_paragraphs( pot1, pot2 )

# Add my.pars into the document doc
doc = addParagraph(doc, my.pars
		, par.properties=parProperties(text.align="center", padding=24) )

# Write the object
writeDoc( doc, file = doc.filename )
#STOP_TAG_TEST
}
\seealso{
\code{\link{pptx}}, \code{\link{addParagraph}}
}

