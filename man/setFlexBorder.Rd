\name{setFlexBorder}
\alias{setFlexBorder}
\title{apply borders scheme to a FlexTable}
\usage{
setFlexBorder(object, inner_v = borderProperties(),
  inner_h = borderProperties(), outer_v = borderProperties(),
  outer_h = borderProperties())
}
\arguments{
  \item{object}{a \code{FlexTable} object}

  \item{inner_h}{a \code{borderProperties} object}

  \item{inner_v}{a \code{borderProperties} object}

  \item{outer_h}{a \code{borderProperties} object}

  \item{outer_v}{a \code{borderProperties} object}
}
\description{
apply borders scheme to a FlexTable. A border scheme is a
set of 4 different borders : inner vectical and horizontal
, outer vectical and horizontal.
}
\examples{
myFlexTable2 = FlexTable( data=mtcars, header.columns=TRUE, add.rownames=TRUE
  , cell_format=cellProperties(background.color="#5B7778", border.color="#EDBD3E")
)

myFlexTable2 = setFlexBorder(myFlexTable2, inner_v=borderProperties(style="none")
  , inner_h=borderProperties(color="#EDBD3E", style="dotted")
  , outer_v=borderProperties(color="#EDBD3E", style="solid")
  , outer_h=borderProperties(color="#EDBD3E", style="solid") )
}
\seealso{
\code{\link{FlexTable}}
}

