\name{addHeaderRow}
\alias{addHeaderRow}
\title{add header in a FlexTable}
\usage{
addHeaderRow(x, value)
}
\arguments{
  \item{x}{a \code{FlexTable} object}

  \item{value}{\code{FlexRow} object to insert as an header
  row}
}
\description{
add a header row in a FlexTable
}
\examples{
data( data_ReporteRs )
myFlexTable = FlexTable( data = data_ReporteRs
		, header.columns=FALSE
		, row.names=FALSE )

cp1 = cellProperties(background.color="#EBEBEB")

headerRow = FlexRow()
for(i in 1:ncol(data_ReporteRs))
   headerRow[i] = FlexCell( pot( names(data_ReporteRs)[i]
		, format=textProperties(font.weight="bold") ), cellProp = cp1 )
myFlexTable = addHeaderRow( myFlexTable, headerRow)
}
\seealso{
\code{\link{FlexTable}}
}

