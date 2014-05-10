\name{spanFlexTableColumns}
\alias{spanFlexTableColumns}
\title{Span columns within rows}
\usage{
spanFlexTableColumns(object, i, from, to)
}
\arguments{
  \item{object}{a \code{FlexTable} object}

  \item{i}{vector (integer index, row.names values or
  boolean vector) for rows selection.}

  \item{from}{index of the first column to span (its
  content will be the visible one).}

  \item{to}{index of the last column to span.}
}
\description{
Span columns within rows.
}
\note{
Overlappings of horizontally merged cells and vertically
merged cells are forbidden.
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
\code{\link{addHeaderRow}}, \code{\link{addFooterRow}},
\code{\link{setFlexTableWidths}} ,
\code{\link{alterFlexTable}},
\code{\link{setFlexTableBorders}} ,
\code{\link{spanFlexTableRows}}, \code{\link{FlexTable}} ,
\code{\link{setRowsColors}},
\code{\link{setColumnsColors}}, \code{\link{setZebraStyle}}
, \code{\link{addFlexTable}},
\code{\link{addFlexTable.docx}} ,
\code{\link{addFlexTable.pptx}},
\code{\link{addFlexTable.html}}
}

