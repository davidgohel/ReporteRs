\name{print.html}
\alias{print.html}
\title{print informations about an object of class \code{"html"}.}
\usage{
  \method{print}{html} (x, ...)
}
\arguments{
  \item{x}{an object of class \code{"html"}}

  \item{...}{further arguments, not used.}
}
\description{
  print informations about an object of class
  \code{"html"}.
}
\examples{
#START_TAG_TEST
# Create a new document
doc <- html( title = "title" )
print( doc )
#STOP_TAG_TEST
}
\seealso{
  \code{\link{html}}, \code{\link{print}}
}

