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

FlexTable can be manipulated so that almost any formating
can be specified. See \code{\link{FlexTable}} for more
details.
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
#' #STOP_TAG_TEST
}
\seealso{
\code{\link{FlexTable}}, \code{\link{addFlexTable.docx}} ,
\code{\link{addFlexTable.pptx}},
\code{\link{addFlexTable.html}} , \code{\link{addTable}}
}

