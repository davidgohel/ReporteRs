\name{slide.layouts.pptx}
\alias{slide.layouts.pptx}
\title{Get layout names of a pptx document}
\usage{
  \method{slide.layouts}{pptx} (doc, layout, ...)
}
\arguments{
  \item{doc}{Object of class \code{pptx} to extract layout
  names from.}

  \item{layout}{optional single string value, one of the
  layout names}

  \item{...}{further arguments, not used.}
}
\description{
  Get layout names that exist into the template used when
  pptx has been created.
}
\details{
  Available names are layout names of the template document
  (e.g. Title and Content , Two Content, etc.). If layout
  is specified, the layout representation will be produced
  in a plot. This can be usefull to check available shapes.
}
\examples{
#START_TAG_TEST
# Create a new document
doc = pptx( title = "title" )

slide.layouts(doc)

# plot the layout "Two Content"
slide.layouts(doc, layout = "Two Content" )
#STOP_TAG_TEST
}
\seealso{
  \code{\link{pptx}}, \code{\link{addSlide.pptx}},
  \code{\link{slide.layouts}}
}

