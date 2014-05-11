\name{dim.docx}
\alias{dim.docx}
\title{Get page layout dimensions of a Word document}
\usage{
\method{dim}{docx}(x)
}
\arguments{
  \item{x}{Object of class \code{docx}}
}
\description{
Returns page width and height and page margins of a
\code{docx} object.
}
\examples{
#START_TAG_TEST
doc = docx( title = "title" )
dim( doc )
#STOP_TAG_TEST
}
\seealso{
\code{\link{docx}}, \code{\link{dim.pptx}}
}

