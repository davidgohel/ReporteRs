\name{setRowsColors}
\alias{setRowsColors}
\title{applies background colors to rows of a FlexTable}
\usage{
setRowsColors(object, i, colors)
}
\arguments{
  \item{object}{a \code{FlexTable} object}

  \item{i}{vector (integer index, row.names values or
  boolean vector) for rows selection.}

  \item{colors}{background colors to apply (e.g. "#000000"
  or "black")}
}
\description{
applies background colors to rows of a FlexTable
}
\examples{
#START_TAG_TEST
# Create a FlexTable object with first 10 lines of data.frame mtcars
# add row.names as first column
# specify cell formatting properties for header columns row
MyFTable = FlexTable( data = mtcars[1:10, ]
  , add.rownames=TRUE
)
MyFTable = setRowsColors( MyFTable, i=1:4, colors = "red" )
#' #STOP_TAG_TEST
}
\seealso{
\code{\link{addHeaderRow}}, \code{\link{addFooterRow}} ,
\code{\link{alterFlexTable}},
\code{\link{setFlexTableBorders}} ,
\code{\link{spanFlexTableRows}},
\code{\link{spanFlexTableColumns}} ,
\code{\link{FlexTable}}, \code{\link{setColumnsColors}},
\code{\link{setZebraStyle}} , \code{\link{addFlexTable}},
\code{\link{addFlexTable.docx}} ,
\code{\link{addFlexTable.pptx}},
\code{\link{addFlexTable.html}}
}

