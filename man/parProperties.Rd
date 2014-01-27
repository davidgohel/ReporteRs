\name{parProperties}
\alias{parProperties}
\title{Paragraph formating properties}
\usage{
  parProperties(text.align = "left", padding.bottom = 1,
    padding.top = 1, padding.left = 1, padding.right = 1,
    padding)
}
\arguments{
  \item{text.align}{text alignment - one of the following
  value : 'left', 'right', 'center', 'justify'.}

  \item{padding.bottom}{an integer value, bottom padding in
  pixels.}

  \item{padding.top}{an integer value, top padding in
  pixels.}

  \item{padding.left}{an integer value, left padding in
  pixels.}

  \item{padding.right}{an integer value, right padding in
  pixels.}

  \item{padding}{an integer value, paddings in pixels, this
  value overwrite all padding.* values.}
}
\description{
  Create an object that describes paragraph formating
  properties.
}
\details{
  parProperties is used to control paragraph properties. It
  is used when creating a tableProperties and when adding
  plots into a docx object.
}
\examples{
parProperties( text.align = "center", padding = 5)
parProperties( text.align = "center", padding.top = 5, padding.bottom = 0, padding.left = 2, padding.right = 0)
}
\seealso{
  \code{\link{addTable}}, \code{\link{addPlot.docx}}
}

