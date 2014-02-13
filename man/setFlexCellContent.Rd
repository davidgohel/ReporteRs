\name{setFlexCellContent}
\alias{setFlexCellContent}
\title{Replace FlexTable content}
\usage{
  setFlexCellContent(object, i, j, value)
}
\arguments{
  \item{object}{a \code{FlexTable} object}

  \item{i}{vector integer index for rows. It must be a
  single value.}

  \item{j}{vector integer index for columns. It must be a
  single value.}

  \item{value}{a \code{\link{pot}} or a
  \code{\link{set_of_paragraphs}} object to insert as new
  cell content.}
}
\description{
  Replace a cell content of a FlexTable object with one or
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

