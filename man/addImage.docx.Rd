\name{addImage.docx}
\alias{addImage.docx}
\title{Insert external images into a docx object}
\usage{
\method{addImage}{docx}(doc, filename, width = 6, height = 6, bookmark,
  par.properties = parProperties(text.align = "center", padding = 5), ...)
}
\arguments{
  \item{doc}{Object of class \code{"docx"} where external
  image has to be added}

  \item{filename}{\code{"character"} value, complete
  filenamed of the external images}

  \item{width}{images width in inches (default value is
  6).}

  \item{height}{images height in inches (default value is
  6).}

  \item{bookmark}{a character value ; id of the Word
  bookmark to replace by the image. optional. if missing,
  image is added at the end of the document.}

  \item{par.properties}{paragraph formatting properties of
  the paragraph that contains images. An object of class
  \code{\link{parProperties}}}

  \item{...}{further arguments, not used.}
}
\value{
an object of class \code{"docx"}.
}
\description{
Add external images into a \code{"docx"} object.
}
\examples{
#START_TAG_TEST
# Create a new document
doc = docx( title = "title" )

# the file 'logo.jpg' only exists in R for Windows
img.file = file.path( Sys.getenv("R_HOME"), "doc", "html", "logo.jpg" )
doc = addImage(doc, img.file )

# Write the object in file "addImage_example.docx"
writeDoc( doc, "addImage_example.docx" )
#STOP_TAG_TEST
}
\seealso{
\code{\link{docx}}, \code{\link{addPlot.docx}} ,
\code{\link{addImage}}
}

