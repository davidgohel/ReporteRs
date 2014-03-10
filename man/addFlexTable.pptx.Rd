\name{addFlexTable.pptx}
\alias{addFlexTable.pptx}
\title{Insert a FlexTable into a docx object}
\usage{
  \method{addFlexTable}{pptx} (doc, flextable, ...)
}
\arguments{
  \item{doc}{docx object}

  \item{flextable}{the \code{FlexTable} object}

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

doc = pptx( title = "title" )
doc = addSlide( doc, slide.layout = "Title and Content" )
doc = addFlexTable( doc, myFlexTable )
writeDoc( doc, "addFlexTable_example.pptx")
#STOP_TAG_TEST
}
\seealso{
  \code{\link{FlexTable}}
}

