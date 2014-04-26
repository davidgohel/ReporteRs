\name{setRowColors}
\alias{setRowColors}
\title{color rows on a table}
\usage{
setRowColors(object, i, colors)
}
\arguments{
  \item{object}{a \code{FlexTable} object}

  \item{i}{row index}

  \item{colors}{background colors to apply (e.g. "#000000"
  or "black")}
}
\description{
color rows on a table
}
\examples{
myFlexTable2 = FlexTable( data=mtcars, header.columns=TRUE, add.rownames=TRUE
  , cell_format=cellProperties(background.color="#5B7778", border.color="#EDBD3E")
)
myFlexTable2 = setRowColors( myFlexTable2, i=5:7, colors=rep( "red", 3) )
}
\seealso{
\code{\link{FlexTable}}
}

