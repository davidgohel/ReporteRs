\name{BoostrapMenu}
\alias{BoostrapMenu}
\title{Create a bootstrap DropDownMenu}
\usage{
BoostrapMenu(title)
}
\arguments{
  \item{title}{\code{"character"} value: label of the
  title.}
}
\value{
an object of class \code{BoostrapMenu}.
}
\description{
Create a \code{DropDownMenu} object. This object is to be
used with \code{\link{BoostrapMenu}} to define menu links.
}
\examples{
#START_TAG_TEST
mymenu = BoostrapMenu( title = "my title")

mydd = DropDownMenu( label = "Mon menu" )
mydd = addLinkItem( mydd, label = "GitHub", "http://github.com/")
mydd = addLinkItem( mydd, separator.after = TRUE)
mydd = addLinkItem( mydd, label = "Wikipedia", "http://www.wikipedia.fr")

mymenu = addLinkItem( mymenu, label = "ReporteRs", "http://github.com/davidgohel/ReporteRs")
mymenu = addLinkItem( mymenu, dd = mydd )
#STOP_TAG_TEST
}
\seealso{
\code{\link{bsdoc}}, \code{\link{addBootstrapMenu}}
}

