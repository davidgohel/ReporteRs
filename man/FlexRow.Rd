\name{FlexRow}
\alias{FlexRow}
\title{Row object for FlexTable}
\usage{
FlexRow(values, colspan, textProp = textProperties(),
  parProp = parProperties(), cellProp = cellProperties())
}
\arguments{
  \item{values}{Optional. a character vector to use as text
  content, the row will contain as many cells as there are
  in \code{values}.}

  \item{textProp}{Optional. textProperties to apply to each
  cell. Used only if values are not missing.}

  \item{parProp}{Optional. parProperties to apply to each
  cell. Used only if values are not missing.}

  \item{cellProp}{Optional. cellProperties to apply to each
  cell. Used only if values are not missing.}

  \item{colspan}{integer Optional. vector specifying for
  each element the number of columns to span for each
  corresponding value (in \code{values}).}
}
\description{
Create a representation of a row that can be inserted in a
FlexTable.
}
\examples{
#START_TAG_TEST
## example 1
headerRow = FlexRow()
headerRow[1] = FlexCell( "Column 1", cellProp = cellProperties(background.color="#527578")  )
headerRow[2] = FlexCell( "Column 2", cellProp = cellProperties(background.color="#527578")  )

## example 2
headerRow = FlexRow( c("Column 1", "Column 2")
	, cellProp = cellProperties(background.color="#527578") )
#STOP_TAG_TEST
}
\seealso{
\code{\link{addFlexTable}}
}

