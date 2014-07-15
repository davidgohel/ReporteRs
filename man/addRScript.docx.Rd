\name{addRScript.docx}
\alias{addRScript.docx}
\title{Add R script into a docx object}
\usage{
\method{addRScript}{docx}(doc, rscript, bookmark, ...)
}
\arguments{
  \item{doc}{Object of class \code{"docx"} where
  expressions have to be added}

  \item{rscript}{an object of class \code{RScript}}

  \item{bookmark}{a character value ; id of the Word
  bookmark to replace by the script. optional. See
  \code{\link{bookmark}}.}

  \item{...}{further arguments, not used.}
}
\value{
an object of class \code{"docx"}.
}
\description{
Add R script into a \code{"docx"} object.
}
\examples{
#START_TAG_TEST
doc.filename = "addRScript_example.docx"
# Create a new document
doc = docx( title = "title" )

an_rscript = RScript( text = "ls()
x = rnorm(10)" )
doc = addRScript(doc, an_rscript )

# Write the object
writeDoc( doc, file = doc.filename )
#STOP_TAG_TEST
}
\seealso{
\code{\link{docx}}, \code{\link{addRScript}},
\code{\link{bookmark}}
}

