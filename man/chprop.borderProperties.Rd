\name{chprop.borderProperties}
\alias{chprop.borderProperties}
\title{Modify border formatting properties}
\usage{
\method{chprop}{borderProperties}(object, color, style, width, ...)
}
\arguments{
  \item{object}{\code{\link{borderProperties}} object to
  modify}

  \item{...}{further arguments - not used}

  \item{color}{border color - single character value (e.g.
  "#000000" or "black")}

  \item{style}{border style - single character value :
  "none" or "solid" or "dotted" or "dashed"}

  \item{width}{border width - an integer value : 0>= value}
}
\value{
a \code{\link{borderProperties}} object
}
\description{
Modify an object of class \code{\link{borderProperties}}.
}
\examples{
x = borderProperties()
chprop(x, color="orange", style="dashed", width=1)
chprop(x, width=5)
}
\seealso{
\code{\link{borderProperties}}
}

