\name{chprop.cellProperties}
\alias{chprop.cellProperties}
\title{Modify a cell formatting properties object}
\usage{
\method{chprop}{cellProperties}(object, border.bottom, border.left, border.top,
  border.right, padding, vertical.align, padding.bottom, padding.top,
  padding.left, padding.right, background.color, ...)
}
\arguments{
  \item{object}{\code{cellProperties} object to modify}

  \item{border.bottom}{\code{borderProperties} for bottom
  border}

  \item{border.left}{\code{borderProperties} for left
  border}

  \item{border.top}{\code{borderProperties} for top border}

  \item{border.right}{\code{borderProperties} for right
  border}

  \item{padding}{cell padding - 0 or positive integer
  value. Argument \code{padding} overwrites arguments
  \code{padding.bottom}, \code{padding.top},
  \code{padding.left}, \code{padding.right}.}

  \item{vertical.align}{cell content vertical alignment - a
  single character value , expected value is one of
  "center" or "top" or "bottom"}

  \item{padding.bottom}{cell bottom padding - 0 or positive
  integer value.}

  \item{padding.top}{cell top padding - 0 or positive
  integer value.}

  \item{padding.left}{cell left padding - 0 or positive
  integer value.}

  \item{padding.right}{cell right padding - 0 or positive
  integer value.}

  \item{background.color}{cell background color - a single
  character value specifying a valid color (e.g. "#000000"
  or "black").}

  \item{...}{further arguments - not used}
}
\value{
a \code{cellProperties} object
}
\description{
Modify an object of class \code{cellProperties}.
}
\examples{
#START_TAG_TEST
cellProp = cellProperties()

cellProp01 = chprop( cellProp, border.bottom.color = "#8A949B" )
cellProp02 = chprop( cellProp, border.right.color = "#8A949B" )
cellProp03 = chprop( cellProp, border.left.color = "#8A949B" )
cellProp04 = chprop( cellProp, border.top.color = "#8A949B" )
cellProp05 = chprop( cellProp, border.color = "#8A949B" )

cellProp06 = chprop( cellProp, border.bottom.width = 2 )
cellProp07 = chprop( cellProp, border.left.width = 2 )
cellProp08 = chprop( cellProp, border.top.width = 2 )
cellProp09 = chprop( cellProp, border.right.width = 2 )
cellProp10 = chprop( cellProp, border.width = 2 )

cellProp11 = chprop( cellProp, padding.bottom = 5 )
cellProp12 = chprop( cellProp, padding.top = 5 )
cellProp13 = chprop( cellProp, padding.left = 5 )
cellProp14 = chprop( cellProp, padding.right = 5 )
cellProp15 = chprop( cellProp, padding = 5 )

cellProp16 = chprop( cellProp, border.bottom.style = "dotted" )
cellProp17 = chprop( cellProp, border.left.style = "dotted" )
cellProp18 = chprop( cellProp, border.top.style = "dotted" )
cellProp19 = chprop( cellProp, border.right.style = "dotted" )
cellProp20 = chprop( cellProp, border.style = "dotted" )

cellProp21 = chprop( cellProp, vertical.align = "middle" )
cellProp22 = chprop( cellProp, background.color = "#517281" )

cellProp23 = chprop( cellProp, background.color = "#517281"
  , border.color = "#F37257", border.width = 2  )
#STOP_TAG_TEST
}
\seealso{
\code{\link{cellProperties}}, \code{\link{parProperties}},
\code{\link{textProperties}} ,
\code{\link{chprop.parProperties}},
\code{\link{chprop.textProperties}} ,
\code{\link{FlexTable}}, \code{\link{tableProperties}},
\code{\link{addTable}}
}

