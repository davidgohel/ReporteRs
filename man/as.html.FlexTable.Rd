\name{as.html.FlexTable}
\alias{as.html.FlexTable}
\title{get HTML code from a FlexTable}
\usage{
\method{as.html}{FlexTable}(object, ...)
}
\arguments{
  \item{object}{the \code{FlexTable} object}

  \item{...}{further arguments passed to other methods}
}
\value{
a character value
}
\description{
get HTML code from a FlexTable
}
\examples{
#START_TAG_TEST
#####################################################################

# set default font size to 10
options( "ReporteRs-fontsize" = 10 )

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

# get HTML of the FlexTable
as.html( MyFTable )
#STOP_TAG_TEST
}
\seealso{
\code{\link{FlexTable}}
}

