\name{setFlexTableBackgroundColors}
\alias{setFlexTableBackgroundColors}
\title{applies background colors to cells of a FlexTable}
\usage{
setFlexTableBackgroundColors(object, i, j, colors, to = "body")
}
\arguments{
  \item{object}{a \code{FlexTable} object}

  \item{i}{vector (integer index, row.names values or
  boolean vector) for rows selection.}

  \item{j}{vector (integer index, col.names values or
  boolean vector) for columns selection.}

  \item{colors}{background colors to apply (e.g. "#000000"
  or "black"). a character vector of colors with as many
  elements as defined by the selection.}

  \item{to}{specify on which part of the FlexTable to apply
  colors, must be one of the following values "body"
  (default) or "header" or "footer"}
}
\description{
applies background colors to cells of a FlexTable
}
\examples{
#START_TAG_TEST
#STOP_TAG_TEST
}
\seealso{
\code{\link{FlexTable}}, \code{\link{is.color}}
}

