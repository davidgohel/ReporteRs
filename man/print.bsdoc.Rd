\name{print.bsdoc}
\alias{print.bsdoc}
\title{print informations about an object of class \code{\link{bsdoc}}.}
\usage{
\method{print}{bsdoc}(x, ...)
}
\arguments{
  \item{x}{an object of class \code{\link{bsdoc}}}

  \item{...}{further arguments, not used.}
}
\description{
print informations about an object of class
\code{\link{bsdoc}}.
}
\examples{
#START_TAG_TEST
# Create a new document
doc = bsdoc( )
print( doc )
#STOP_TAG_TEST
}
\seealso{
\code{\link{bsdoc}}, \code{\link{print}}
}

