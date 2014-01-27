\name{addFooter}
\alias{addFooter}
\title{Insert a footer into a document object}
\usage{
  addFooter(doc, ...)
}
\arguments{
  \item{doc}{document object}

  \item{...}{further arguments passed to other methods}
}
\value{
  a document object
}
\description{
  Insert a footer into a document object
}
\details{
  addFooter only works for pptx slides. See
  \code{\link{addFooter.pptx}}. \code{docx} and \code{html}
  object have no method \code{addFooter} implemented.
}
\seealso{
  \code{\link{pptx}}, \code{\link{addSlide.pptx}}
}

