\name{print.docx}
\alias{print.docx}
\title{print informations about an object of class \code{"docx"}.}
\usage{
  \method{print}{docx} (x, ...)
}
\arguments{
  \item{x}{an object of class \code{"docx"}}

  \item{...}{further arguments, not used.}
}
\description{
  print informations about an object of class
  \code{"docx"}.
}
\examples{
#START_TAG_TEST
# Create a new document
doc <- docx( title = "title" )
print( doc )
#STOP_TAG_TEST
}
\seealso{
  \code{\link{docx}}, \code{\link{print}}
}

