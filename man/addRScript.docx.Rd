\name{addRScript.docx}
\alias{addRScript.docx}
\title{Add R script into a docx object}
\usage{
\method{addRScript}{docx}(doc, rscript, file, text, bookmark, ...)
}
\arguments{
  \item{doc}{Object of class \code{"docx"} where
  expressions have to be added}

  \item{file}{R script file. Not used if text or rscript is
  provided.}

  \item{text}{character vector. The text to parse. Not used
  if file or rscript is provided.}

  \item{rscript}{an object of class \code{RScript}. Not
  used if file or text is provided.}

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
\details{
You have to one of the following argument: file or text or
rscript.
}
\examples{
#START_TAG_TEST
doc.filename = "addRScript_example.docx"
# Create a new document
doc = docx( title = "title" )

an_rscript = RScript( text = "ls()
x = rnorm(10)" )
doc = addRScript(doc, an_rscript )

doc = addPageBreak( doc )

doc = addRScript(doc, text = "ls()" )

# Write the object
writeDoc( doc, file = doc.filename )
#STOP_TAG_TEST
}
\seealso{
\code{\link{docx}}, \code{\link{addRScript}},
\code{\link{bookmark}}
}

