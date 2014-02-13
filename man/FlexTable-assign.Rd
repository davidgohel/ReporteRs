\name{[<-.FlexTable}
\alias{[<-.FlexTable}
\title{Format FlexTable content}
\usage{
  \method{[}{FlexTable} (x, i, j) <- value
}
\arguments{
  \item{x}{the \code{FlexTable} object}

  \item{i}{vector integer index for rows.}

  \item{j}{vector integer index for columns.}

  \item{value}{an object of class
  \code{\link{cellProperties}} or an object of class
  \code{\link{parProperties}} or an object of class
  \code{\link{textProperties}}.}
}
\description{
  Format content of a FlexTable object
}
\examples{
data( data_ReporteRs )
myFlexTable = FlexTable( data = data_ReporteRs
	, span.columns = "col1"
, header.columns = TRUE
, row.names = FALSE )
myFlexTable[ 1:2, 2:3] = textProperties( color="red" )
myFlexTable[ 4:5, 4:5] = parProperties( text.align="right" )
myFlexTable[ 1:2, 5:6] = cellProperties( background.color="#F2969F")
}
\seealso{
  \code{\link{addFlexTable}}
}

