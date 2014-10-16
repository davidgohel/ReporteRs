\name{chprop.parProperties}
\alias{chprop.parProperties}
\title{Modify paragraph formatting properties}
\usage{
\method{chprop}{parProperties}(object, text.align, padding.bottom, padding.top,
  padding.left, padding.right, padding, list.style, level, ...)
}
\arguments{
  \item{object}{\code{parProperties} object to modify}

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

  \item{list.style}{list style - a single character value,
  expected value is one of 'none' (default), 'unordered',
  'ordered'.}

  \item{level}{list level if argument \code{list} is not
  'none'.}

  \item{...}{further arguments - not used}
}
\value{
a \code{parProperties} object
}
\description{
Modify an object of class \code{parProperties}.
}
\examples{
#START_TAG_TEST
parProp = parProperties()

parProp01 = chprop( parProp, text.align = "center" )
parProp02 = chprop( parProp, padding.bottom = 2 )
parProp03 = chprop( parProp, padding.top = 2 )
parProp04 = chprop( parProp, padding.left = 2 )
parProp05 = chprop( parProp, padding = 2 )

parProp06 = chprop( parProp, padding = 2, text.align = "center" )
#STOP_TAG_TEST
}
\seealso{
\code{\link{cellProperties}}, \code{\link{parProperties}},
\code{\link{textProperties}} ,
\code{\link{chprop.cellProperties}},
\code{\link{chprop.textProperties}} ,
\code{\link{FlexTable}}, \code{\link{tableProperties}}
}

