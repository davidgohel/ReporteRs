\name{setZebraStyle}
\alias{setZebraStyle}
\title{color alternate rows on a table}
\usage{
setZebraStyle(object, odd, even)
}
\arguments{
  \item{object}{a \code{FlexTable} object}

  \item{odd}{background color applied to odd rows - single
  character value (e.g. "#000000" or "black")}

  \item{even}{background color applied to even rows -
  single character value (e.g. "#000000" or "black")}
}
\description{
Zebra striping — coloring alternate rows on a table
}
\examples{
myFlexTable2 = FlexTable( data=mtcars, header.columns=TRUE, add.rownames=TRUE
  , cell_format=cellProperties(background.color="#5B7778", border.color="#EDBD3E")
)
myFlexTable2 = setZebraStyle( myFlexTable2, "#D1E6E7", "#93A8A9" )
}
\seealso{
\code{\link{FlexTable}}
}

