\name{addRScript.pptx}
\alias{addRScript.pptx}
\title{Add R script into a pptx object}
\usage{
\method{addRScript}{pptx}(doc, rscript, ...)
}
\arguments{
  \item{doc}{Object of class \code{"pptx"} where
  expressions have to be added}

  \item{rscript}{an object of class \code{RScript}}

  \item{...}{further arguments, not used.}
}
\value{
an object of class \code{"pptx"}.
}
\description{
Add R script into a \code{"pptx"} object.
}
\examples{
#START_TAG_TEST
doc.filename = "addRScript_example.pptx"
# Create a new document
doc = pptx( title = "title" )
doc = addSlide( doc, slide.layout = "Title and Content" )
an_rscript = RScript( text = "ls()
x = rnorm(10)", par.properties = parProperties() )
doc = addRScript(doc, an_rscript )

# Write the object
writeDoc( doc, file = doc.filename )
#STOP_TAG_TEST
}
\seealso{
\code{\link{pptx}}, \code{\link{addRScript}}
}

