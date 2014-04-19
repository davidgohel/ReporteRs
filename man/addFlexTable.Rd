\name{addFlexTable}
\alias{addFlexTable}
\title{Insert a FlexTable into a document object}
\usage{
addFlexTable(doc, flextable, ...)
}
\arguments{
  \item{doc}{document object}

  \item{flextable}{the \code{FlexTable} object}

  \item{...}{further arguments passed to other methods}
}
\value{
a document object
}
\description{
Insert a FlexTable into a document object
}
\examples{
\dontrun{
data( data_ReporteRs )
myFlexTable = FlexTable( data = data_ReporteRs, span.columns="col1"
	, header.columns=TRUE, row.names=FALSE )
myFlexTable[ 1:2, 2:3] = textProperties( color="red" )
myFlexTable[ 3:4, 4:5] = parProperties( text.align="right" )
myFlexTable[ 1:2, 5:6] = cellProperties( background.color="#F2969F")
myFlexTable = setFlexCellContent( myFlexTable, 3, 6, pot("Hello"
	, format=textProperties(font.weight="bold") ) + pot("World"
	, format=textProperties(font.weight="bold", vertical.align="superscript") ) )
doc = addFlexTable( doc, myFlexTable )
}
}
\seealso{
\code{\link{FlexTable}}
}

