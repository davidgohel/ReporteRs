\name{addImage.html}
\alias{addImage.html}
\title{Insert an external image into a html object}
\usage{
\method{addImage}{html}(doc, filename, width, height, ...)
}
\arguments{
  \item{doc}{Object of class \code{"html"} where external
  image has to be added}

  \item{filename}{\code{"character"} value, complete
  filename of the external image}

  \item{width}{image width in pixel}

  \item{height}{image height in pixel}

  \item{...}{further arguments, not used.}
}
\value{
an object of class \code{"html"}.
}
\description{
Add an external image into a \code{"html"} object.
}
\examples{
#START_TAG_TEST
# Create a new document
doc = html( title = "title" )

# add a page where to add content
doc = addPage( doc, title = "page example" )

# the file 'logo.jpg' only exists in R for Windows
img.file = file.path( Sys.getenv("R_HOME"), "doc", "html", "logo.jpg" )
doc = addImage(doc, img.file, width = 100, height = 76 )

writeDoc( doc, "addImage_example" )
#STOP_TAG_TEST
}
\seealso{
\code{\link{html}}, \code{\link{addPlot.html}} ,
\code{\link{addImage}}
}

