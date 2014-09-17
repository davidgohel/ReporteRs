\name{spanFlexTableColumns}
\alias{spanFlexTableColumns}
\title{Span columns within rows}
\usage{
spanFlexTableColumns(object, i, from, to, runs)
}
\arguments{
  \item{object}{a \code{FlexTable} object}

  \item{i}{vector (integer index, row.names values or
  boolean vector) for rows selection.}

  \item{from}{index of the first column to span (its
  content will be the visible one).}

  \item{to}{index of the last column to span.}

  \item{runs}{a vector of size \code{numcol} of FlexTable.
  If provided, successive runs of equal values will
  indicate to merge corresponding columns.}
}
\description{
Span columns within rows.
}
\note{
Overlappings of horizontally merged cells and vertically
merged cells are forbidden.
}
\examples{
#START_TAG_TEST
data(pbc_summary)

MyFTable = FlexTable( data = pbc_summary[, 1:4] )
# merge column 2 to 4 in line 3
MyFTable = spanFlexTableColumns( MyFTable, i = 3, from = 2, to = 4 )

# merge cells in rows 1 to 6 when successive values of runs are identical
MyFTable = spanFlexTableColumns( MyFTable, i = 4:6, runs = c( "a", "b", "b", "c") )
#STOP_TAG_TEST
}
\seealso{
\code{\link{spanFlexTableRows}}, \code{\link{FlexTable}}
}

