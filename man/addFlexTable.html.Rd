\name{addFlexTable.html}
\alias{addFlexTable.html}
\title{Insert a FlexTable into a docx object}
\usage{
\method{addFlexTable}{html}(doc, flextable, ...)
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
#####################################################################

# Create a FlexTable with data.frame mtcars, display rownames
# use different formatting properties for header and body cells
MyFTable = FlexTable( data = mtcars, add.rownames = TRUE
  , body.cell.props = cellProperties( border.color = "#EDBD3E")
  , header.cell.props = cellProperties( background.color = "#5B7778" )
)
# zebra stripes - alternate colored backgrounds on table rows
MyFTable = setZebraStyle( MyFTable, odd = "#D1E6E7", even = "#93A8A9" )

# applies a border grid on table
MyFTable = setFlexTableBorders(MyFTable
  , inner.vertical = borderProperties( color="#EDBD3E", style="dotted" )
  , inner.horizontal = borderProperties( color = "#EDBD3E", style = "none" )
  , outer.vertical = borderProperties( color = "#EDBD3E", style = "solid" )
  , outer.horizontal = borderProperties( color = "#EDBD3E", style = "solid" )
)
doc = html( title = "title" )
doc = addPage( doc, title = "Example" )
doc = addFlexTable( doc, MyFTable )
writeDoc( doc, "addFlexTable_example")
#STOP_TAG_TEST
}
\seealso{
\code{\link{FlexTable}}, \code{\link{html}} ,
\code{\link{addFlexTable.pptx}},
\code{\link{addFlexTable.docx}} ,
\code{\link{addTable.html}}
}

