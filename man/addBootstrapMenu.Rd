\name{addBootstrapMenu}
\alias{addBootstrapMenu}
\title{add a \code{BootstrapMenu} into a \code{bsdoc} object.}
\usage{
addBootstrapMenu(doc, bsmenu)
}
\arguments{
  \item{doc}{a \code{bsdoc} object.}

  \item{bsmenu}{the \code{BootstrapMenu} to add into the
  \code{bsdoc}.}
}
\value{
an object of class \code{BootstrapMenu}.
}
\description{
add a \code{BootstrapMenu} into a \code{bsdoc} object.
}
\examples{
#START_TAG_TEST
library( ReporteRs )

doc = bsdoc( title = "my document" )

mymenu = BootstrapMenu( title = "my title")

mydd = DropDownMenu( label = "Mon menu" )
mydd = addLinkItem( mydd, label = "GitHub", "http://github.com/")
mydd = addLinkItem( mydd, separator.after = TRUE)
mydd = addLinkItem( mydd, label = "Wikipedia", "http://www.wikipedia.fr")

mymenu = addLinkItem( mymenu, label = "ReporteRs", "http://github.com/davidgohel/ReporteRs")
mymenu = addLinkItem( mymenu, dd = mydd )

doc = addBootstrapMenu( doc, mymenu )

pages = writeDoc( doc, file = "addBoostrapMenu_example/example.html")
#STOP_TAG_TEST
}
\seealso{
\code{\link{bsdoc}}, \code{\link{BootstrapMenu}}
}

