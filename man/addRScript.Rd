\name{addRScript}
\alias{addRScript}
\title{Add R script into a document object}
\usage{
addRScript(doc, file, text, ...)
}
\arguments{
  \item{doc}{document object}

  \item{file}{R script file. Not used if text is provided.}

  \item{text}{character vector. The text to parse. Not used
  if file is provided.}

  \item{...}{further arguments passed to other methods}
}
\value{
a document object
}
\description{
Add R script into a document object
}
\details{
\code{addRScript} only works with html documents. See
\code{\link{addRScript.html}} for examples.
}
\seealso{
\code{\link{html}}, \code{\link{addRScript.html}}
}

