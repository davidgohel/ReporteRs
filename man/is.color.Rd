\name{is.color}
\alias{is.color}
\title{color checking}
\usage{
  is.color(x)
}
\arguments{
  \item{x}{value(s) to be tested}
}
\description{
  Check if character string is a valid color representation
}
\details{
  see
  http://stackoverflow.com/questions/13289009/check-if-character-string-is-a-valid-color-representation/13290832#13290832
}
\examples{
is.color( c(NA, "black", "blackk", "1", "#00", "#000000") )
}
\seealso{
  \code{\link{pptx}}, \code{\link{docx}}
}

