\name{addRScript.pptx}
\alias{addRScript.pptx}
\title{Add R script into a pptx object}
\usage{
\method{addRScript}{pptx}(doc, file, text,
  comment.properties = textProperties(color = "#008200"),
  symbol.properties = textProperties(color = "#6599FF"),
  assignement.properties = textProperties(color = "#666666"),
  keyword.properties = textProperties(color = "#097054"),
  formalargs.properties = textProperties(color = "#666666"),
  eqformalargs.properties = textProperties(color = "#666666"),
  functioncall.properties = textProperties(color = "#ff1493"),
  string.properties = textProperties(color = "blue"),
  number.properties = textProperties(color = "blue"),
  argument.properties = textProperties(color = "#ff8000"),
  package.properties = textProperties(color = "#8000ff"), ...)
}
\arguments{
  \item{doc}{Object of class \code{"pptx"} where
  expressions have to be added}

  \item{file}{R script file. Not used if text is provided.}

  \item{text}{character vector. The text to parse. Not used
  if file is provided.}

  \item{comment.properties}{comment textProperties}

  \item{symbol.properties}{symbol textProperties}

  \item{assignement.properties}{assignement textProperties}

  \item{keyword.properties}{keyword textProperties}

  \item{formalargs.properties}{formalargs textProperties}

  \item{eqformalargs.properties}{eqformalargs
  textProperties}

  \item{functioncall.properties}{functioncall
  textProperties}

  \item{string.properties}{string textProperties}

  \item{number.properties}{number textProperties}

  \item{argument.properties}{argument textProperties}

  \item{package.properties}{package textProperties}

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
doc = addRScript(doc, text = "ls()
x = rnorm(10)" )

# Write the object
writeDoc( doc, file = doc.filename )
#STOP_TAG_TEST
}
\seealso{
\code{\link{pptx}}, \code{\link{addRScript}}
}

