\name{set_of_paragraphs}
\alias{set_of_paragraphs}
\title{Set of paragraphs of text}
\usage{
set_of_paragraphs(...)
}
\arguments{
  \item{...}{pot objects, one per paragraph.}
}
\description{
Create a container of paragraphs of text (\code{pot}
objects).
}
\details{
each pot are representing a paragraph. A paragraph consists
of one or more pieces of text and ends with an end of line.
Objects of class \code{set_of_paragraphs} are to be used
with \code{\link{addParagraph}}.
}
\examples{
#START_TAG_TEST
pot1 = pot("My tailor", textProperties(color="red") ) + " is " + pot("rich"
	, textProperties(font.weight="bold") )
pot2 = pot("Cats", textProperties(color="red") ) + " and " + pot("Dogs"
	, textProperties(color="blue") )
my.pars = set_of_paragraphs( pot1, pot2 )
#STOP_TAG_TEST
}
\seealso{
\code{\link{addParagraph}},
\code{\link{addParagraph.docx}},
\code{\link{addParagraph.pptx}},
\code{\link{addParagraph.html}}
}

