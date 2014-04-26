\name{cellProperties}
\alias{cellProperties}
\title{Cell formating properties}
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
  \item{padding}{cell padding - integer value : 0>= value -
  overwrite all padding.* values}

  \item{border.width}{border width - an integer value : 0>=
  value - overwrite all border.*.style values}

  \item{border.style}{border style - a string value :
  "none" or "solid" or "dotted" or "dashed" - overwrite all
  border.*.style values}

  \item{border.color}{border color - a string value (e.g.
  "#000000" or "black") - overwrite all border.*.color
  values}

  \item{border.bottom.color}{border bottom color - a string
  value (e.g. "#000000" or "black")}

  \item{border.bottom.style}{border bottom style - a string
  value : "none" or "solid" or "dotted" or "dashed"}

  \item{border.bottom.width}{border bottom width - an
  integer value : 0>= value}

  \item{border.left.color}{border left color - a string
  value (e.g. "#000000" or "black")}

  \item{border.left.style}{border left style - a string
  value : "none" or "solid" or "dotted" or "dashed"}

  \item{border.left.width}{border left width - an integer
  value : 0>= value}

  \item{border.top.color}{border top color - a string value
  (e.g. "#000000" or "black")}

  \item{border.top.style}{border top style - a string value
  : "none" or "solid" or "dotted" or "dashed"}

  \item{border.top.width}{border top width - an integer
  value : 0>= value}

  \item{border.right.color}{border right color - a string
  value (e.g. "#000000" or "black")}

  \item{border.right.style}{border right style - a string
  value : "none" or "solid" or "dotted" or "dashed"}

  \item{border.right.width}{border right width - integer
  value : 0>= value}

  \item{vertical.align}{cell content vertical alignment - a
  string value : "center" or "top" or "bottom"}

  \item{padding.bottom}{cell bottom padding - integer value
  : 0>= value}

  \item{padding.top}{cell top padding - integer value : 0>=
  value}

  \item{padding.left}{cell left padding - integer value :
  0>= value}

  \item{padding.right}{cell right padding - integer value :
  0>= value}

  \item{background.color}{cell background color - a string
  value (e.g. "#000000" or "black")}
}
\description{
Create an object that describes cell formating properties.
This objects are used by \code{\link{tableProperties}}.
}
\examples{
cellProperties( border.color = "gray", border.width = 2 )
cellProperties(border.left.width = 0, border.right.width = 0
         , border.bottom.width = 2, border.top.width = 0
         , padding.bottom = 2, padding.top = 2
         , padding.left = 2, padding.right = 2 )
}
\seealso{
\code{\link{tableProperties}}, \code{\link{textProperties}}
, \code{\link{parProperties}}
}

