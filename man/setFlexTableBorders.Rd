\name{setFlexTableBorders}
\alias{setFlexTableBorders}
\title{change grid lines of a FlexTable}
\usage{
setFlexTableBorders(object, inner.vertical = borderProperties(),
  inner.horizontal = borderProperties(),
  outer.vertical = borderProperties(),
  outer.horizontal = borderProperties(), body = TRUE, header = TRUE,
  footer = FALSE)
}
\arguments{
  \item{object}{a \code{FlexTable} object}

  \item{inner.horizontal}{a \code{borderProperties} object}

  \item{inner.vertical}{a \code{borderProperties} object}

  \item{outer.horizontal}{a \code{borderProperties} object}

  \item{outer.vertical}{a \code{borderProperties} object}

  \item{body}{a logical value (default to TRUE), specifies
  to apply scheme to table body}

  \item{header}{a logical value (default to TRUE),
  specifies to apply scheme to table header}

  \item{footer}{a logical value (default to FALSE),
  specifies to apply scheme to table footer}
}
\description{
apply borders scheme to a FlexTable. A border scheme is a
set of 4 different borders: inner vectical and horizontal ,
outer vectical and horizontal.
}
\examples{
#START_TAG_TEST
# Create a FlexTable object with first 10 lines of data.frame mtcars
# add row.names as first column
# specify cell formating properties for header columns row
MyFTable = FlexTable( data = mtcars[1:10, ]
  , add.rownames=TRUE
)
MyFTable = setFlexTableBorders( MyFTable
  , inner.vertical = borderProperties( style = "dashed" )
  , inner.horizontal = borderProperties( style = "dashed" )
  , outer.vertical = borderProperties( width = 2 )
  , outer.horizontal = borderProperties( width = 2 )
)
#' #STOP_TAG_TEST
}
\seealso{
\code{\link{addHeaderRow}}, \code{\link{addFooterRow}} ,
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

