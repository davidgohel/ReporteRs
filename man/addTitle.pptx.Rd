\name{addTitle.pptx}
\alias{addTitle.pptx}
\title{Insert a title into a pptx object}
\usage{
\method{addTitle}{pptx}(doc, value, ...)
}
\arguments{
  \item{doc}{\code{\link{pptx}} object}

  \item{value}{\code{"character"} value to use as title
  text}

  \item{...}{further arguments, not used.}
}
\value{
an object of class \code{\link{pptx}}.
}
\description{
Add a title into a \code{\link{pptx}} object.
}
\examples{
#START_TAG_TEST
# Create a new document
doc = pptx( title = "title" )

# add a slide with layout "Title and Content"
doc = addSlide( doc, slide.layout = "Title and Content" )

# Here we fill the title shape with "My title"
doc = addTitle( doc, "My title" )

# Write the object in file "addTitle_example.pptx"
writeDoc( doc, "addTitle_example.pptx" )
#STOP_TAG_TEST
}
\seealso{
\code{\link{pptx}}, \code{\link{addTitle}},
\code{\link{addSlide.pptx}}
}

