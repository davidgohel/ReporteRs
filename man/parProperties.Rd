\name{parProperties}
\alias{parProperties}
\title{Paragraph formatting properties}
\usage{
parProperties(text.align = "left", padding.bottom = 1, padding.top = 1,
  padding.left = 1, padding.right = 1, padding)
}
\arguments{
  \item{text.align}{text alignment - a single character
  value, expected value is one of 'left', 'right',
  'center', 'justify'.}

  \item{padding.bottom}{paragraph bottom padding - 0 or
  positive integer value.}

  \item{padding.top}{paragraph top padding - 0 or positive
  integer value.}

  \item{padding.left}{paragraph left padding - 0 or
  positive integer value.}

  \item{padding.right}{paragraph right padding - 0 or
  positive integer value.}

  \item{padding}{paragraph padding - 0 or positive integer
  value. Argument \code{padding} overwrites arguments
  \code{padding.bottom}, \code{padding.top},
  \code{padding.left}, \code{padding.right}.}
}
\value{
a \code{parProperties} object
}
\description{
Create a \code{parProperties} object that describes
paragraph formatting properties.
}
\details{
parProperties is used to control paragraph properties. It
is used when creating a tableProperties, when adding plots
into a docx object or when adding content in a FlexTable.

Default values are: \itemize{ \item \code{text.align}
"left" \item \code{padding.bottom} 1 \item
\code{padding.top} 1 \item \code{padding.left} 1 \item
\code{padding.right} 1 }
}
\examples{
#START_TAG_TEST
parProperties( text.align = "center", padding = 5)
parProperties( text.align = "center", padding.top = 5
, padding.bottom = 0, padding.left = 2, padding.right = 0)
#' #STOP_TAG_TEST
}
\seealso{
\code{\link{cellProperties}}, \code{\link{parProperties}},
\code{\link{textProperties}} ,
\code{\link{chprop.parProperties}},
\code{\link{chprop.textProperties}} ,
\code{\link{FlexTable}}, \code{\link{tableProperties}},
\code{\link{addTable}} , \code{\link{addPlot.docx}}
}

