\name{addRScript.html}
\alias{addRScript.html}
\title{Add R script into a html object}
\usage{
\method{addRScript}{html}(doc, rscript, ...)
}
\arguments{
  \item{doc}{Object of class \code{"html"} where
  expressions have to be added}

  \item{rscript}{an object of class \code{RScript}}

  \item{...}{further arguments, not used.}
}
\value{
an object of class \code{"html"}.
}
\description{
Add R script into a \code{"html"} object.
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

