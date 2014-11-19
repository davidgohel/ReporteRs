\name{addRScript}
\alias{addRScript}
\title{Add R script into a document object}
\usage{
addRScript(doc, rscript, file, text, ...)
}
\arguments{
  \item{doc}{document object}

  \item{file}{R script file. Not used if text or rscript is
  provided.}

  \item{text}{character vector. The text to parse. Not used
  if file or rscript is provided.}

  \item{rscript}{an object of class \code{RScript}. Not
  used if file or text is provided.}

  \item{...}{further arguments passed to other methods}
}
\value{
a document object
}
\description{
Add R script into a document object
}
\details{
You have to one of the following argument: file or text or
rscript.
}
\seealso{
\code{\link{addRScript.bsdoc}},
\code{\link{addRScript.docx}} ,
\code{\link{addRScript.pptx}}
}

