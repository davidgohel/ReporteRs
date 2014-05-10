\name{setColumnsColors}
\alias{setColumnsColors}
\title{applies background colors to columns of a FlexTable}
\usage{
setColumnsColors(object, j, colors)
}
\arguments{
  \item{object}{a \code{FlexTable} object}

  \item{j}{vector (integer index, col.names values or
  boolean vector) for columns selection.}

  \item{colors}{background colors to apply (e.g. "#000000"
  or "black")}
}
\description{
applies background colors to columns of a FlexTable
}
\examples{
#START_TAG_TEST
# Create a FlexTable object with first 10 lines of data.frame mtcars
# add row.names as first column
MyFTable = FlexTable( data = mtcars[1:10, ]
  , add.rownames=TRUE
)
MyFTable = setColumnsColors( MyFTable, j=3:4, colors = "red" )
#' #STOP_TAG_TEST
}
\seealso{
\code{\link{addHeaderRow}}, \code{\link{addFooterRow}},
\code{\link{setFlexTableWidths}} ,
\code{\link{alterFlexTable}},
\code{\link{setFlexTableBorders}} ,
\code{\link{spanFlexTableRows}},
\code{\link{spanFlexTableColumns}} ,
\code{\link{setRowsColors}}, \code{\link{FlexTable}},
\code{\link{setZebraStyle}} , \code{\link{addFlexTable}},
\code{\link{addFlexTable.docx}} ,
\code{\link{addFlexTable.pptx}},
\code{\link{addFlexTable.html}}
}

