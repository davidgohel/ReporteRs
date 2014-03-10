\name{addFlexTable.docx}
\alias{addFlexTable.docx}
\title{Insert a FlexTable into a docx object}
\usage{
  \method{addFlexTable}{docx} (doc, flextable,
    parStyle = parProperties(text.align = "left"),
    bookmark, ...)
}
\arguments{
  \item{doc}{docx object}

  \item{flextable}{the \code{FlexTable} object}

  \item{parStyle}{paragraph formatting properties of the
  paragraph that contains the table. An object of class
  \code{\link{parProperties}}}

  \item{bookmark}{a character vector specifying bookmark id
  (where to put the table).  If provided, table will be add
  after paragraph that contains the bookmark.  If not
  provided, table will be added at the end of the
  document.}

  \item{...}{further arguments - not used}
}
\value{
  a docx object
}
\description{
  Insert a FlexTable into a docx object
}
\examples{
#START_TAG_TEST
data( data_ReporteRs )

myFlexTable = FlexTable( data = data_ReporteRs, span.columns = "col1"
	, header.columns = TRUE, row.names=FALSE )

myFlexTable[ 1:2, 2:3] = textProperties( color="red" )
myFlexTable[ 3:4, 4:5] = parProperties( text.align="right" )
myFlexTable[ 1:2, 5:6] = cellProperties( background.color="#F2969F")

myFlexTable = setFlexCellContent( myFlexTable, 3, 6, pot("Hello"
	, format=textProperties(font.weight="bold") ) + pot("World"
	, format=textProperties(font.weight="bold", vertical.align="superscript") ) )

doc = docx( title = "title" )
doc = addFlexTable( doc, myFlexTable )
writeDoc( doc, "addFlexTable_example.docx")
#STOP_TAG_TEST
}
\seealso{
  \code{\link{FlexTable}}
}

