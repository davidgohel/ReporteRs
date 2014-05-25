\name{addImage.pptx}
\alias{addImage.pptx}
\title{Insert an external image into a pptx object}
\usage{
\method{addImage}{pptx}(doc, filename, offx, offy, width, height, ...)
}
\arguments{
  \item{doc}{Object of class \code{"pptx"} where external
  image has to be added}

  \item{filename}{\code{"character"} value, complete
  filename of the external image}

  \item{offx}{optional, x position of the shape (top left
  position of the bounding box) in inch. See details.}

  \item{offy}{optional, y position of the shape (top left
  position of the bounding box) in inch See details.}

  \item{width}{optional, width of the shape in inch See
  details.}

  \item{height}{optional, height of the shape in inch See
  details.}

  \item{...}{further arguments, not used.}
}
\value{
an object of class \code{"pptx"}.
}
\description{
Add an external image into a \code{"pptx"} object.
}
\details{
Image is added to the next free 'content' shape of the
current slide. See \code{\link{slide.layouts.pptx}} to view
the slide layout.

If arguments offx, offy, width, height are missing,
position and dimensions will be defined by the width and
height of the next available shape of the slide. This
dimensions can be defined in the layout of the PowerPoint
template used to create the \code{pptx} object.

If arguments offx, offy, width, height are provided, they
become position and dimensions of the new shape.
}
\examples{
#START_TAG_TEST
# Create a new document
doc = pptx( title = "title" )

# add a slide with layout "Title and Content" then add an image
doc = addSlide( doc, slide.layout = "Title and Content" )

# the file 'logo.jpg' only exists in R for Windows
img.file = file.path( Sys.getenv("R_HOME"), "doc", "html", "logo.jpg" )
doc = addImage(doc, img.file )

writeDoc( doc, "addImage_example.pptx" )
#STOP_TAG_TEST
}
\seealso{
\code{\link{pptx}}, \code{\link{addPlot.pptx}} ,
\code{\link{addImage}}
}

