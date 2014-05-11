\name{cellProperties}
\alias{cellProperties}
\title{Cell formatting properties}
\usage{
cellProperties(border.bottom.color = "black", border.bottom.style = "solid",
  border.bottom.width = 1, border.left.color = "black",
  border.left.style = "solid", border.left.width = 1,
  border.top.color = "black", border.top.style = "solid",
  border.top.width = 1, border.right.color = "black",
  border.right.style = "solid", border.right.width = 1,
  vertical.align = "middle", padding.bottom = 1, padding.top = 1,
  padding.left = 1, padding.right = 1, background.color = "white",
  padding, border.width, border.style, border.color)
}
\arguments{
  \item{padding}{cell padding - 0 or positive integer
  value. Argument \code{padding} overwrites arguments
  \code{padding.bottom}, \code{padding.top},
  \code{padding.left}, \code{padding.right}.}

  \item{border.width}{border width - 0 or positive integer
  value. Argument \code{border.width} overwrites arguments
  \code{border.bottom.width}, \code{border.top.width} ,
  \code{border.left.width}, \code{border.right.width}.}

  \item{border.style}{border style - a single character
  value, expected value is one of "none" , "solid",
  "dotted", "dashed". Argument \code{border.style}
  overwrites arguments \code{border.bottom.style},
  \code{border.top.style}, \code{border.left.style} ,
  \code{border.right.style}.}

  \item{border.color}{border color - a single character
  value specifying a valid color (e.g. "#000000" or
  "black").  Argument \code{border.color} overwrites
  arguments \code{border.bottom.color} ,
  \code{border.top.color}, \code{border.left.color},
  \code{border.right.color}.}

  \item{border.bottom.color}{border bottom color - a single
  character value specifying a valid color (e.g. "#000000"
  or "black").}

  \item{border.bottom.style}{border bottom style - a single
  character value, expected value is one of "none",
  "solid", "dotted", "dashed".}

  \item{border.bottom.width}{border bottom width - 0 or
  positive integer value}

  \item{border.left.color}{border left color - a single
  character value specifying a valid color (e.g. "#000000"
  or "black").}

  \item{border.left.style}{border left style - a single
  character value, expected value is one of "none",
  "solid", "dotted", "dashed".}

  \item{border.left.width}{border left width - 0 or
  positive integer value}

  \item{border.top.color}{border top color - a single
  character value specifying a valid color (e.g. "#000000"
  or "black").}

  \item{border.top.style}{border top style - a single
  character value, expected value is one of "none",
  "solid", "dotted", "dashed".}

  \item{border.top.width}{border top width - 0 or positive
  integer value}

  \item{border.right.color}{border right color - a single
  character value specifying a valid color (e.g. "#000000"
  or "black").}

  \item{border.right.style}{border right style - a single
  character value, expected value is one of "none",
  "solid", "dotted", "dashed".}

  \item{border.right.width}{border right width - 0 or
  positive integer value}

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
}
\description{
Create a \code{cellProperties} object that describes cell
formatting properties. This objects are used by
\code{\link{tableProperties}}, \code{\link{FlexTable}}.
}
\details{
Default values are: \itemize{ \item
\code{border.bottom.color} "black" \item
\code{border.bottom.style} "solid" \item
\code{border.bottom.width} 1 \item \code{border.left.color}
"black" \item \code{border.left.style} "solid" \item
\code{border.left.width} 1 \item \code{border.top.color}
"black" \item \code{border.top.style} "solid" \item
\code{border.top.width} 1 \item \code{border.right.color}
"black" \item \code{border.right.style} "solid" \item
\code{border.right.width} 1 \item \code{vertical.align}
"middle" \item \code{padding.bottom} 1 \item
\code{padding.top} 1 \item \code{padding.left} 1 \item
\code{padding.right} 1 \item \code{background.color}
"white" }
}
\examples{
#START_TAG_TEST
cellProp01 = cellProperties( border.color = "gray", border.width = 2 )
cellProp02 = cellProperties(border.left.width = 0, border.right.width = 0
  , border.bottom.width = 2, border.top.width = 0
  , padding.bottom = 2, padding.top = 2
  , padding.left = 2, padding.right = 2 )
#STOP_TAG_TEST
}
\seealso{
\code{\link{cellProperties}}, \code{\link{parProperties}},
\code{\link{textProperties}} ,
\code{\link{chprop.cellProperties}},
\code{\link{chprop.parProperties}},
\code{\link{chprop.textProperties}} ,
\code{\link{FlexTable}}, \code{\link{tableProperties}},
\code{\link{addTable}}
}

