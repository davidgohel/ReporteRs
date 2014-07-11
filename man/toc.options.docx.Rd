\name{toc.options.docx}
\alias{toc.options.docx}
\title{Set TOC options}
\usage{
\method{toc.options}{docx}(x, list.separator)
}
\arguments{
  \item{x}{Object of class \code{docx}}

  \item{list.separator}{list separator (should be the same
  than in computer's regional settings)}
}
\description{
set options for custom table of contents of a \code{docx}
object.
}
\details{
This function is to be used if TOC cannot be built. It is
occuring when list separator used when building the TOC is
different from the list separator in your computer's
regional settings.

see \url{http://support.microsoft.com/kb/302865/EN-US}
}
\examples{
#START_TAG_TEST
doc = docx( title = "title" )
doc = toc.options( doc, list.separator = "," )
#STOP_TAG_TEST
}
\seealso{
\code{\link{docx}}, \code{\link{addTOC.docx}}
}

