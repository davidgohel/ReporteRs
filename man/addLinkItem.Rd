\name{addLinkItem}
\alias{addLinkItem}
\title{add an item in a \code{BootstrapMenu} or a \code{DropDownMenu}}
\usage{
addLinkItem(x, label, link, dd, separator.before = FALSE,
  separator.after = FALSE)
}
\arguments{
  \item{x}{a \code{DropDownMenu} or a \code{BoostrapMenu}
  object.}

  \item{label}{\code{"character"} value: label of a simple
  link. If used, argument \code{link} must be specified.}

  \item{link}{\code{"character"} value: hyperlink value. If
  used, argument \code{label} must be specified.}

  \item{dd}{a \code{DropDownMenu} object to insert into the
  menu. If used, arguments \code{label} and \code{link}
  will be ignored.}

  \item{separator.before}{if TRUE, a separator will be
  inserted before the new item. It only applies when x is a
  \code{DropDownMenu} object.}

  \item{separator.after}{if TRUE, a separator will be
  inserted after the new item. It only applies when x is a
  \code{DropDownMenu} object.}
}
\value{
an object of class \code{BoostrapMenu}.
}
\description{
add an item in a \code{BootstrapMenu} or
\code{DropDownMenu} object. An item can be a simple link
associated with a label or a \code{DropDownMenu} object.
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

