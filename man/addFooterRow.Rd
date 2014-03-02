\name{addFooterRow}
\alias{addFooterRow}
\title{add footer in a FlexTable}
\usage{
addFooterRow(x, value)
}
\arguments{
  \item{x}{a \code{FlexTable} object}

  \item{value}{\code{FlexRow} object to insert as a footer
  row}
}
\description{
add a footer row in a FlexTable
}
\examples{
data( data_ReporteRs )
myFlexTable = FlexTable( data = data_ReporteRs
		, header.columns=FALSE
		, row.names=FALSE )

cp1 = cellProperties(background.color="#EBEBEB")

footerRow = FlexRow()
for(i in 1:ncol(data_ReporteRs))
   footerRow[i] = FlexCell( pot( paste("footer", i)
		, format = textProperties(font.weight="bold") )
		, cellProp = cp1 )
myFlexTable = addFooterRow( myFlexTable, footerRow)
}
\seealso{
\code{\link{FlexTable}}
}

