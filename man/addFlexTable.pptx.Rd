\name{addFlexTable.pptx}
\alias{addFlexTable.pptx}
\title{Insert a FlexTable into a docx object}
\usage{
\method{addFlexTable}{pptx}(doc, flextable, ...)
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
MyFTable = FlexTable( data = mtcars, add.rownames = TRUE
  , cell_format = cellProperties( border.color="#EDBD3E")
  , header_cell_format = cellProperties( background.color="#5B7778"
    , border.color="#EDBD3E")
)

MyFTable = setZebraStyle( MyFTable, odd = "#D1E6E7", even = "#93A8A9" )

MyFTable = setFlexTableBorders(MyFTable
  , inner.vertical = borderProperties( color="#EDBD3E", style="dotted" )
  , inner.horizontal = borderProperties( color = "#EDBD3E", style = "none" )
  , outer.vertical = borderProperties( color = "#EDBD3E", style = "solid" )
  , outer.horizontal = borderProperties( color = "#EDBD3E", style = "solid" )
)
doc = pptx( title = "title" )
doc = addSlide( doc, slide.layout = "Title and Content" )
doc = addFlexTable( doc, MyFTable )
writeDoc( doc, "addFlexTable_example.pptx")
#' #STOP_TAG_TEST
}
\seealso{
\code{\link{FlexTable}}
}

