\name{addRScript.html}
\alias{addRScript.html}
\title{Add R script into a html object}
\usage{
\method{addRScript}{html}(doc, rscript, file, text, ...)
}
\arguments{
  \item{doc}{\code{\link{html}} object where expressions
  have to be added}

  \item{file}{R script file. Not used if text or rscript is
  provided.}

  \item{text}{character vector. The text to parse. Not used
  if file or rscript is provided.}

  \item{rscript}{an object of class \code{RScript}. Not
  used if file or text is provided.}

  \item{...}{further arguments, not used.}
}
\value{
an object of class \code{\link{html}}.
}
\description{
Add R script into a \code{\link{html}} object.
}
\details{
You have to one of the following argument: file or text or
rscript.
}
\examples{
#START_TAG_TEST
doc.dirname = "addRScript_example"
# Create a new document
doc = html( title = "title" )

# add a page where to add R outputs with title 'page example'
doc = addPage( doc, title = "page example" )

an_rscript = RScript( text = "ls()" )
doc = addRScript( doc, an_rscript )

# Write the object
writeDoc( doc, directory = doc.dirname )
#STOP_TAG_TEST
}
\seealso{
\code{\link{html}}, \code{\link{addRScript}}
}

