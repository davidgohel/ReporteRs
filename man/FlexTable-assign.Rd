\name{[<-.FlexTable}
\alias{[<-.FlexTable}
\title{modify FlexTable content}
\usage{
\method{[}{FlexTable} (x, i, j) <- value
}
\arguments{
  \item{x}{the \code{FlexTable} object}

  \item{i}{vector (integer index, row.names values or
  boolean vector) for rows.}

  \item{j}{vector (integer index, col.names values or
  boolean vector) for columns.}

  \item{value}{an object of class
  \code{\link{cellProperties}} or an object of class
  \code{\link{parProperties}} or an object of class
  \code{\link{textProperties}}.}

  \item{textProperties}{formating properties (an object of
  class \code{textProperties}).}

  \item{newpar}{logical value specifying wether or not the
  content should be added as a new paragraph}

  \item{byrow}{logical. If FALSE (the default) content is
  added by columns , otherwise content is added by rows.}
}
\description{
add text into a FlexTable object or Format content of a
FlexTable object
}
\examples{
data( data_ReporteRs )
myFlexTable = FlexTable( data = data_ReporteRs
  , header.columns = TRUE
  , add.rownames = FALSE )
myFlexTable[ 1:2, 2:3] = textProperties( color="red" )
myFlexTable[ 3:4, 4:5] = parProperties( text.align="right" )
myFlexTable[ 1:2, 5:6] = cellProperties( background.color="#F2969F")

myFlexTable[1:4, 1:2, textProperties = textProperties( color="red" )
  , newpar = TRUE] = c("A", "B", "C", "D", "E", "F", "G", "H")
myFlexTable[1:4, 3
  , textProperties = textProperties(vertical.align="superscript")] = c("1", "2", "3", "4")
}
\seealso{
\code{\link{addFlexTable}}
}

