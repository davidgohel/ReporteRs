\name{addImage.html}
\alias{addImage.html}
\title{Insert an external image into a html object}
\usage{
  \method{addImage}{html} (doc, filename, ...)
}
\arguments{
  \item{doc}{Object of class \code{"html"} where external
  image has to be added}

  \item{filename}{\code{"character"} value, complete
  filename of the external image}

  \item{...}{further arguments, not used.}
}
\value{
  an object of class \code{"html"}.
}
\description{
  Add an external image into a \code{"html"} object.
}
\examples{
# Create a new document
doc = html( title = "title" )
# add a page where to add R outputs with title 'page example'
doc = addPage( doc, title = "page example" )
doc <- addImage(doc, file.path( Sys.getenv("R_HOME"), "doc", "html", "logo.jpg" ) );
writeDoc( doc, "image_html" )
}
\seealso{
  \code{\link{html}}, \code{\link{addPlot.html}} ,
  \code{\link{addImage}}
}

