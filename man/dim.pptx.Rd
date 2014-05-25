\name{dim.pptx}
\alias{dim.pptx}
\title{Get layout information on a PowerPoint slide}
\usage{
\method{dim}{pptx}(x)
}
\arguments{
  \item{x}{Object of class \code{pptx}}
}
\description{
Returns slide width and height, position and dimension of
the next available shape in the current slide.
}
\examples{
#START_TAG_TEST
doc = pptx( title = "title" )
doc = addSlide( doc, "Title and Content" )
dim(doc)
#STOP_TAG_TEST
}
\seealso{
\code{\link{pptx}}, \code{\link{dim.docx}}
}

