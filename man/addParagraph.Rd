\name{addParagraph}
\alias{addParagraph}
\title{Add a paragraph into a document object}
\usage{
  addParagraph(doc, value, ...)
}
\arguments{
  \item{doc}{document object}

  \item{value}{character vector containing texts to add OR
  an object of class \code{\link{set_of_paragraphs}}. A
  set_of_paragraphs object is a container for \code{pot}
  objects.}

  \item{...}{further arguments passed to other methods}
}
\value{
  a document object
}
\description{
  Add a paragraph into a document object
}
\details{
  a paragraph is a set of texts that ends with an end of
  line(\code{'\n'} in C). Read \code{\link{pot}} to see how
  to get different font formats. Trying to insert a
  \code{'\n'} will have no effect. If an end of line is
  required , a new paragraph is required.
}
\examples{
\dontrun{
# Add "Hello World" into the document doc
doc <- addParagraph(doc, "Hello Word!");

# Add into the document : "My tailor is rich" and "Cats and Dogs"
# format some of the pieces of text
pot1 = pot("My tailor", textProperties(color="red") ) + " is " + pot("rich"
	, textProperties(font.weight="bold") )
my.pars = set_of_paragraphs( pot1 )
pot2 = pot("Cats", textProperties(color="red") ) + " and " + pot("Dogs"
	, textProperties(color="blue") )
my.pars = set_of_paragraphs( pot1, pot2 )
doc <- addParagraph(doc, my.pars )
}
}
\seealso{
  \code{\link{docx}}, \code{\link{addParagraph.docx}} ,
  \code{\link{pptx}}, \code{\link{addParagraph.pptx}} ,
  \code{\link{html}}, \code{\link{addParagraph.html}}
}

