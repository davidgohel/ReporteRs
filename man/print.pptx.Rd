\name{print.pptx}
\alias{print.pptx}
\title{print informations about an object of class \code{"pptx"}.}
\usage{
  \method{print}{pptx} (x, ...)
}
\arguments{
  \item{x}{an object of class \code{"pptx"}}

  \item{...}{further arguments, not used.}
}
\description{
  print informations about an object of class
  \code{"pptx"}.
}
\examples{
# Create a new document
doc = pptx( title = "title" )

print( doc )
}
\seealso{
  \code{\link{pptx}}, \code{\link{print}}
}

