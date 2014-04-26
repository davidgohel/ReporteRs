\name{setColColors}
\alias{setColColors}
\title{color columns on a table}
\usage{
setColColors(object, j, colors)
}
\arguments{
  \item{object}{a \code{FlexTable} object}

  \item{j}{col index}

  \item{colors}{background colors to apply (e.g. "#000000"
  or "black")}
}
\description{
color columns on a table
}
\examples{
myFlexTable2 = FlexTable( data=mtcars, header.columns=TRUE, add.rownames=TRUE
  , cell_format=cellProperties(background.color="#5B7778", border.color="#EDBD3E")
)
myFlexTable2 = setColColors( myFlexTable2, j=3, colors=rep( "red", nrow(mtcars)) )
}
\seealso{
\code{\link{FlexTable}}
}

