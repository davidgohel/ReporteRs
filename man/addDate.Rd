\name{addDate}
\alias{addDate}
\title{Insert a date into a document object}
\usage{
  addDate(doc, ...)
}
\arguments{
  \item{doc}{document object}

  \item{...}{further arguments passed to other methods}
}
\value{
  a document object
}
\description{
  Insert a date into a document object
}
\details{
  addDate only works for pptx slides. See
  \code{\link{addSlide.pptx}}. \code{docx} and \code{html}
  object have no method \code{addDate} implemented.
}
\seealso{
  \code{\link{pptx}}, \code{\link{addSlide.pptx}}
}

