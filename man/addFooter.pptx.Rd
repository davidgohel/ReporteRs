\name{addFooter.pptx}
\alias{addFooter.pptx}
\title{Insert a footer shape into a document pptx object}
\usage{
\method{addFooter}{pptx}(doc, value, ...)
}
\arguments{
  \item{doc}{Object of class \code{"pptx"}}

  \item{value}{character value to add into the footer shape
  of the current slide.}

  \item{...}{further arguments, not used.}
}
\value{
a document object
}
\description{
Insert a footer shape into the current slide of a
\code{pptx} object.
}
\examples{
#START_TAG_TEST

# Create a new document
doc = pptx( title = "title" )

# add a slide with layout "Title Slide"
doc = addSlide( doc, slide.layout = "Title Slide" )
doc = addTitle( doc, "Presentation title" ) #set the main title
doc = addSubtitle( doc , "This document is generated with ReporteRs.")#set the sub-title

## add a page number on the current slide
doc = addFooter( doc, "Hi!" )

writeDoc( doc, "addFooter_example.pptx" )
#STOP_TAG_TEST
}
\seealso{
\code{\link{pptx}}, \code{\link{addDate.pptx}} ,
\code{\link{addPageNumber.pptx}}, \code{\link{addFooter}}
}

