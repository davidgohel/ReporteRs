\name{addFlexCellContent}
\alias{addFlexCellContent}
\title{Add content in a FlexTable}
\usage{
  addFlexCellContent(object, i, j, value, textProperties,
    newpar = F, byrow = FALSE)
}
\arguments{
  \item{object}{a \code{FlexTable} object}

  \item{i}{vector (integer index, row.names values or
  boolean vector) for rows.}

  \item{j}{vector (integer index, col.names values or
  boolean vector) for columns.}

  \item{value}{text values or values that have a
  \code{format} method returning character value.}

  \item{textProperties}{formating properties (an object of
  class \code{textProperties}).}

  \item{newpar}{logical value specifying wether or not the
  content should be added as a new paragraph}

  \item{byrow}{logical. If FALSE (the default) content is
  added by columns , otherwise content is added by rows.}
}
\description{
  add texts or paragraphs in cells contents of a FlexTable
  object
}
\examples{
data( data_ReporteRs )
myFlexTable = FlexTable( data = data_ReporteRs
	, span.columns = "col1"
	, header.columns = TRUE
	, row.names = FALSE )
myFlexTable = addFlexCellContent( myFlexTable
	, i = 1:4, j = 1
	, value = c("A", "B", "C", "D")
	, textProperties = textProperties( color="red" )
	)
myFlexTable = addFlexCellContent( myFlexTable
	, i = 1:4, j = 2
	, value = c("E", "F", "G", "H")
	, textProperties = textProperties( color="red" )
	, newpar = TRUE
	)
}
\seealso{
  \code{\link{addFlexTable}}
}

