\name{FlexCell}
\alias{FlexCell}
\title{Cell object for FlexTable}
\usage{
  FlexCell(value, colspan = 1, parProp = parProperties(),
    cellProp = cellProperties())
}
\arguments{
  \item{value}{a content value - a value of type
  \code{character} or \code{pot} or
  \code{set_of_paragraphs}.}

  \item{colspan}{defines the number of columns the cell
  should span}

  \item{parProp}{parProperties to apply to content}

  \item{cellProp}{cellProperties to apply to content}
}
\description{
  Create a representation of a cell that can be inserted in
  a FlexTable.
}
\examples{
FlexCell( value = "Hello" )
}
\seealso{
  \code{\link{addFlexTable}}
}

