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
# Create a new document
doc <- html( title = "title" )
print( doc )
}
\seealso{
  \code{\link{html}}, \code{\link{print}}
}

