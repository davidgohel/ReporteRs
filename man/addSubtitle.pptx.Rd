\name{addSubtitle.pptx}
\alias{addSubtitle.pptx}
\title{Insert a addSubtitle shape into a pptx object}
\usage{
  \method{addSubtitle}{pptx} (doc, value, ...)
}
\arguments{
  \item{doc}{Object of class \code{"pptx"}}

  \item{value}{\code{"character"} value to use as subtitle
  text}

  \item{...}{further arguments, not used.}
}
\value{
  an object of class \code{"pptx"}.
}
\description{
  Add a addSubtitle shape into a \code{"pptx"} object.
}
\details{
  Subtitle shape only exist in slide of type 'Title Slide'.
}
\examples{
# Create a new document
doc = pptx( title = "title" )

# add a slide with layout "Title Slide"
doc = addSlide( doc, slide.layout = "Title Slide" )
doc = addTitle( doc, "Presentation title" ) #set the main title
doc = addSubtitle( doc , "This document is generated with ReporteRs.")#set the sub-title

# Write the object in file "presentation.pptx"
writeDoc( doc, "presentation.pptx" )
}
\seealso{
  \code{\link{pptx}}, \code{\link{addSubtitle}}
}

