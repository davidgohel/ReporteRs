\name{FlexTable}
\alias{FlexTable}
\title{FlexTable}
\usage{
  FlexTable(data, span.columns = character(0),
    header.columns = TRUE, row.names = FALSE,
    cell_format = cellProperties(),
    par_format = parProperties(),
    text_format = textProperties())
}
\arguments{
  \item{data}{(a \code{data.frame} or \code{matrix} object)
  to add}

  \item{span.columns}{a character vector specifying columns
  names where row merging should be done (if successive
  values in a column are the same ; if
  data[p,j]==data[p-1,j] )}

  \item{header.columns}{logical value - should the colnames
  be included in the table as table headers. If FALSE, no
  headers will be printed unless you use
  \code{\link{addHeaderRow}}.}

  \item{row.names}{logical value - should the row.names be
  included in the table.}

  \item{cell_format}{default cells formatting properties
  for any data}

  \item{par_format}{default paragraphs formatting
  properties for any data}

  \item{text_format}{default texts formatting properties
  for any data}
}
\description{
  Create a representation of a table. FlexTable can be
  manipulated so that almost any formating can be
  specified. It allows to insert headers and footers rows
  (with merged cells). Formating can be done on cells,
  paragraphs and texts (borders, colors, fonts, etc.)
}
\examples{
data( data_ReporteRs )
myFlexTable = FlexTable( data = data_ReporteRs
	, span.columns = "col1"
	, header.columns = TRUE
 , row.names = FALSE )
myFlexTable[ 1:2, 2:3] = textProperties( color="red" )
myFlexTable[ 4:5, 4:5] = parProperties( text.align="right" )
myFlexTable[ 1:2, 5:6] = cellProperties( background.color="#F2969F")
}
\seealso{
  \code{\link{addFlexTable}}, \code{\link{FlexRow}},
  \code{\link{FlexCell}} , \code{\link{pot}},
  \code{\link{set_of_paragraphs}},
  \code{\link{addFlexTable.docx}} ,
  \code{\link{addFlexTable.pptx}},
  \code{\link{addFlexTable.html}}
}

