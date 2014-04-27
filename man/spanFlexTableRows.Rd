\name{spanFlexTableRows}
\alias{spanFlexTableRows}
\title{Span rows within columns}
\usage{
spanFlexTableRows(object, j, from, to, runs)
}
\arguments{
  \item{object}{a \code{FlexTable} object}

  \item{j}{vector (integer index, col.names values or
  boolean vector) for columns selection.}

  \item{from}{index of the first row to span (its content
  will be the visible one).}

  \item{to}{index of the last row to span.}

  \item{runs}{a vector of size \code{numrow} of FlexTable.
  If provided, successive runs of equal values will
  indicate to merge corresponding rows.}
}
\description{
Span rows within columns.
}
\examples{
#START_TAG_TEST
data(pbc_summary)

MyFTable = FlexTable( data = pbc_summary[, 1:4] )
# merge line 7 to 11 in column 1
MyFTable = spanFlexTableRows( MyFTable, j = 3, from = 5, to = 7 )
# merge cells in column 1 (trt) when successive values of trt are identical
MyFTable = spanFlexTableRows( MyFTable, j=1, runs = as.character( pbc_summary$trt ) )
# merge cells in column 2 (sex) when successive values of sex are identical
MyFTable = spanFlexTableRows( MyFTable, j=2, runs = as.character( pbc_summary$sex ) )
#' #STOP_TAG_TEST
}
\seealso{
\code{\link{addHeaderRow}}, \code{\link{addFooterRow}} ,
\code{\link{alterFlexTable}},
\code{\link{setFlexTableBorders}} ,
\code{\link{FlexTable}}, \code{\link{spanFlexTableColumns}}
, \code{\link{setRowsColors}},
\code{\link{setColumnsColors}}, \code{\link{setZebraStyle}}
, \code{\link{addFlexTable}},
\code{\link{addFlexTable.docx}} ,
\code{\link{addFlexTable.pptx}},
\code{\link{addFlexTable.html}}
}

