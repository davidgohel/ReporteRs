\name{addImage.bsdoc}
\alias{addImage.bsdoc}
\title{Insert an external image into a bsdoc object}
\usage{
\method{addImage}{bsdoc}(doc, filename, width, height,
  par.properties = parProperties(text.align = "center", padding = 5), ...)
}
\arguments{
  \item{doc}{\code{\link{bsdoc}} object where external
  image has to be added}

  \item{filename}{\code{"character"} value, complete
  filename of the external image}

  \item{width}{image width in pixel}

  \item{height}{image height in pixel}

  \item{par.properties}{paragraph formatting properties of
  the paragraph that contains images. An object of class
  \code{\link{parProperties}}}

  \item{...}{further arguments, not used.}
}
\value{
an object of class \code{\link{bsdoc}}.
}
\description{
Add an external image into a \code{\link{bsdoc}} object.
}
\examples{
#START_TAG_TEST
doc.filename = "addImage_bsdoc/example.html"

# set default font size to 11
options( "ReporteRs-fontsize" = 11 )

doc = bsdoc( )
# the file 'logo.jpg' only exists in R for Windows
img.file = file.path( Sys.getenv("R_HOME"), "doc", "html", "logo.jpg" )
doc = addImage(doc, img.file, width = 100, height = 76 )

# Write the object
writeDoc( doc, file = doc.filename )
#STOP_TAG_TEST
}
\seealso{
\code{\link{bsdoc}}, \code{\link{addPlot.bsdoc}} ,
\code{\link{addImage}}
}

