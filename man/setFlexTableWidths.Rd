\name{setFlexTableWidths}
\alias{setFlexTableWidths}
\title{set columns widths of a FlexTable}
\usage{
setFlexTableWidths(object, widths)
}
\arguments{
  \item{object}{a \code{FlexTable} object}

  \item{widths}{a numeric vector specifying columns widths
  in inches.}
}
\description{
set columns widths of a FlexTable in inches.
}
\examples{
#START_TAG_TEST
# Create a FlexTable object with first 10 lines of data.frame iris
MyFTable = FlexTable( data = iris[1:10, ] )
MyFTable = setFlexTableWidths( MyFTable, widths = c(1,1,1,1,3))
#' #STOP_TAG_TEST
}
\seealso{
\code{\link{addHeaderRow}}, \code{\link{addFooterRow}},
\code{\link{setFlexTableWidths}} ,
\code{\link{alterFlexTable}}, \code{\link{FlexTable}} ,
\code{\link{spanFlexTableRows}},
\code{\link{spanFlexTableColumns}} ,
\code{\link{setRowsColors}},
\code{\link{setColumnsColors}}, \code{\link{setZebraStyle}}
, \code{\link{addFlexTable}},
\code{\link{addFlexTable.docx}} ,
\code{\link{addFlexTable.pptx}},
\code{\link{addFlexTable.html}}
}

