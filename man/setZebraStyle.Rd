\name{setZebraStyle}
\alias{setZebraStyle}
\title{FlexTable rows zebra striping}
\usage{
setZebraStyle(object, odd, even)
}
\arguments{
  \item{object}{a \code{FlexTable} object}

  \item{odd}{background color applied to odd row indexes -
  single character value (e.g. "#000000" or "black")}

  \item{even}{background color applied to even row indexes
  - single character value (e.g. "#000000" or "black")}
}
\description{
applies background color to alternate rows (zebra
striping). Set a color if row index is odd and another if
row index is even.
}
\examples{
#START_TAG_TEST
# Create a FlexTable object with first 10 lines of data.frame mtcars
# add row.names as first column
# specify cell formatting properties for header columns row
MyFTable = FlexTable( data = mtcars[1:10, ]
  , add.rownames=TRUE
)
# Zebra striped table
MyFTable = setZebraStyle( MyFTable, odd = "#8A949B", even = "#FAFAFA" )
#' #STOP_TAG_TEST
}
\seealso{
\code{\link{addHeaderRow}}, \code{\link{addFooterRow}} ,
\code{\link{alterFlexTable}},
\code{\link{setFlexTableBorders}} ,
\code{\link{spanFlexTableRows}},
\code{\link{spanFlexTableColumns}} ,
\code{\link{setRowsColors}},
\code{\link{setColumnsColors}}, \code{\link{FlexTable}} ,
\code{\link{addFlexTable}}, \code{\link{addFlexTable.docx}}
, \code{\link{addFlexTable.pptx}},
\code{\link{addFlexTable.html}}
}

