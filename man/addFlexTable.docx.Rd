\name{addFlexTable.docx}
\alias{addFlexTable.docx}
\title{Insert a FlexTable into a docx object}
\usage{
\method{addFlexTable}{docx}(doc, flextable,
  parStyle = parProperties(text.align = "left"), bookmark, ...)
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
doc = docx( title = "title" )
doc = addFlexTable( doc, MyFTable )
writeDoc( doc, "addFlexTable.docx")
#' #STOP_TAG_TEST
}
\seealso{
\code{\link{FlexTable}}
}

