\name{FlexRow}
\alias{FlexRow}
\title{Row object for FlexTable}
\usage{
  FlexRow()
}
\description{
  Create a representation of a row that can be inserted in
  a FlexTable.
}
\examples{
headerRow = FlexRow()
headerRow[1] = FlexCell( "Column 1" )
headerRow[2] = FlexCell( "Column 2" )
}
\seealso{
  \code{\link{addFlexTable}}
}

