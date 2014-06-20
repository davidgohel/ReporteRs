\name{addRScript.docx}
\alias{addRScript.docx}
\title{Add R script into a docx object}
\usage{
\method{addRScript}{docx}(doc, file, text,
  comment.properties = textProperties(color = "#A7947D"),
  roxygencomment.properties = textProperties(color = "#5FB0B8"),
  symbol.properties = textProperties(color = "black"),
  operators.properties = textProperties(color = "black"),
  keyword.properties = textProperties(color = "#4A444D"),
  string.properties = textProperties(color = "#008B8B", font.style =
  "italic"), number.properties = textProperties(color = "blue"),
  functioncall.properties = textProperties(color = "#823C3C"),
  argument.properties = textProperties(color = "#F25774"),
  package.properties = textProperties(color = "green"),
  formalargs.properties = textProperties(color = "#424242"),
  eqformalargs.properties = textProperties(color = "#424242"),
  assignement.properties = textProperties(color = "black"),
  slot.properties = textProperties(color = "#F25774"),
  default.properties = textProperties(color = "black"), stylename, bookmark,
  ...)
}
\arguments{
  \item{doc}{Object of class \code{"docx"} where
  expressions have to be added}

  \item{file}{R script file. Not used if text is provided.}

  \item{text}{character vector. The text to parse. Not used
  if file is provided.}

  \item{comment.properties}{comment txtProperties object}

  \item{roxygencomment.properties}{roxygencomment
  txtProperties object}

  \item{operators.properties}{operators txtProperties
  object}

  \item{keyword.properties}{keyword txtProperties object}

  \item{string.properties}{string txtProperties object}

  \item{number.properties}{number txtProperties object}

  \item{functioncall.properties}{functioncall txtProperties
  object}

  \item{argument.properties}{argument txtProperties object}

  \item{package.properties}{package txtProperties object}

  \item{formalargs.properties}{formalargs txtProperties
  object}

  \item{eqformalargs.properties}{eqformalargs txtProperties
  object}

  \item{assignement.properties}{assignement txtProperties
  object}

  \item{symbol.properties}{symbol txtProperties object}

  \item{slot.properties}{slot txtProperties object}

  \item{default.properties}{default txtProperties object}

  \item{stylename}{value of the named style to apply to
  paragraphs in the docx document. Expected value is an
  existing stylename of the template document used to
  create the \code{docx} object. see
  \code{\link{styles.docx}}.}

  \item{bookmark}{a character value ; id of the Word
  bookmark to replace by the table. optional. See
  \code{\link{bookmark}}.}

  \item{...}{further arguments, not used.}
}
\value{
an object of class \code{"html"}.
}
\description{
Add R script into a \code{"docx"} object.
}
\examples{
#START_TAG_TEST
doc.filename = "addRScript_example.docx"
# Create a new document
doc = docx( title = "title" )

doc = addRScript(doc, text = "ls()
x = rnorm(10)", stylename = "rRawOutput" )

# Write the object
writeDoc( doc, file = doc.filename )
#STOP_TAG_TEST
}
\seealso{
\code{\link{docx}}, \code{\link{addRScript}},
\code{\link{bookmark}}
}

