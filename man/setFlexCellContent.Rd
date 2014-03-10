\name{setFlexCellContent}
\alias{setFlexCellContent}
\title{Replace FlexTable content}
\usage{
  setFlexCellContent(object, i, j, value)
}
\arguments{
  \item{object}{a \code{FlexTable} object}

  \item{i}{vector (integer index, row.names values or
  boolean vector) for rows.}

  \item{j}{vector (integer index, col.names values or
  boolean vector) for columns.}

  \item{value}{a \code{\link{pot}} or a
  \code{\link{set_of_paragraphs}} object to insert as new
  cell content.}
}
\description{
  Replace cells contents of a FlexTable object with one or
  more paragraph of texts.
}
\examples{
data( data_ReporteRs )
myFlexTable = FlexTable( data = data_ReporteRs
	, span.columns = "col1"
, header.columns = TRUE
, row.names = FALSE )
myFlexTable = setFlexCellContent( myFlexTable
, i = 1, j = 1
, pot("Hello World", format = textProperties( color="red" ) )
)
}
\seealso{
  \code{\link{addFlexTable}}
}

