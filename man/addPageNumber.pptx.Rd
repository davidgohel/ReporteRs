\name{addPageNumber.pptx}
\alias{addPageNumber.pptx}
\title{Insert a page number shape into a document pptx object}
\usage{
  \method{addPageNumber}{pptx} (doc, value, ...)
}
\arguments{
  \item{doc}{Object of class \code{"pptx"}}

  \item{value}{character value to add into the page number
  shape of the current slide. optionnal. If missing current
  slide number will be used.}

  \item{...}{further arguments, not used.}
}
\value{
  a \code{pptx} document object
}
\description{
  Insert a page number shape into the current slide of a
  \code{pptx} object.
}
\examples{
# Create a new document
doc = pptx( title = "title" )
# add a slide with layout "Title Slide"
doc = addSlide( doc, slide.layout = "Title Slide" )
doc = addTitle( doc, "Presentation title" ) #set the main title
doc = addSubtitle( doc , "This document is generated with ReporteRs.")#set the sub-title

## add a page number on the current slide
doc = addPageNumber( doc )

doc = addSlide( doc, slide.layout = "Title and Content" )
## add a page number on the current slide but not the default text (slide number)
doc = addPageNumber( doc, value = "Page number text")

# Write the object in file "~/presentation.pptx"
writeDoc( doc, "~/presentation.pptx" )
}
\seealso{
  \code{\link{pptx}}, \code{\link{addDate.pptx}} ,
  \code{\link{addPageNumber}}
}

