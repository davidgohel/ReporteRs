\name{pot}
\alias{pot}
\title{Piece of Text (formated text)}
\usage{
pot(value = "", format = textProperties())
}
\arguments{
  \item{value}{text value or a value that has a
  \code{format} method returning character value.}

  \item{format}{formating properties (an object of class
  \code{textProperties}).}
}
\description{
Create an object with a text to display and its formating
properties.
}
\details{
a pot (piece of text) is a convenient way to define a
paragraph of text where some texts are not all formated the
same.
}
\examples{
#START_TAG_TEST
pot("My tailor", textProperties(color="red") ) + " is " + pot("rich"
	, textProperties(font.weight="bold") )
#STOP_TAG_TEST
}
\seealso{
\code{\link{addParagraph}},
\code{\link{addParagraph.docx}},
\code{\link{addParagraph.pptx}},
\code{\link{addParagraph.html}} , \code{\link{pptx}},
\code{\link{docx}}, \code{\link{html}}
}

