\name{addRScript}
\alias{addRScript}
\title{Add R script into a document object}
\usage{
addRScript(doc, file, text, comment.properties = textProperties(color =
  "#A7947D"), roxygencomment.properties = textProperties(color = "#5FB0B8"),
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
  default.properties = textProperties(color = "black"), ...)
}
\arguments{
  \item{doc}{document object}

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

  \item{...}{further arguments passed to other methods}
}
\value{
a document object
}
\description{
Add R script into a document object
}
\seealso{
\code{\link{addRScript.html}},
\code{\link{addRScript.docx}} ,
\code{\link{addRScript.pptx}}
}

