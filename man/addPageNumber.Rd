\name{addPageNumber}
\alias{addPageNumber}
\title{Insert a page number into a document object}
\usage{
addPageNumber(doc, ...)
}
\arguments{
  \item{doc}{document object}

  \item{...}{further arguments passed to other methods}
}
\value{
a document object
}
\description{
Insert a page number into a document object
}
\details{
addPageNumber only works for pptx slides. See
\code{\link{addPageNumber.pptx}}. \code{docx} and
\code{html} object have no method \code{addPageNumber}
implemented.
}
\seealso{
\code{\link{pptx}}
}

