\name{+.pot}
\alias{+.pot}
\title{pot concatenation}
\usage{
\method{+}{pot}(e1, e2)
}
\arguments{
  \item{e1}{a \code{pot} object or a character (vector of
  length 1).}

  \item{e2}{a \code{pot} object or a character (vector of
  length 1).}
}
\description{
"+" function is to be used for concatenation of
\code{\link{pot}} elements. Concatenation of 2 \code{pot}
objects returns a pot (of length 2).
}
\details{
at least one of the two objects must be a \code{pot}
object. If one of the 2 parameters is a simple string, it
is converted as a \code{pot} object with no associated
format ; therefore, document default document style will be
used (see \code{\link{addParagraph}}).
}
\examples{
pot("My tailor", textProperties(color="red") ) + " is " + pot("rich"
	, textProperties(font.weight="bold") )
}
\seealso{
\code{\link{addParagraph}}
}

