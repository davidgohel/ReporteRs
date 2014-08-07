\name{addParagraph}
\alias{addParagraph}
\title{Add a paragraph into a document object}
\usage{
addParagraph(doc, value, ...)
}
\arguments{
  \item{doc}{document object}

  \item{value}{text to add to the document as paragraphs:
  an object of class \code{\link{pot}} or
  \code{\link{set_of_paragraphs}} or a character vector.}

  \item{...}{further arguments passed to other methods}
}
\value{
a document object
}
\description{
Add a paragraph into a document object
}
\details{
a paragraph is a set of text that ends with an end of
line(\code{'\n'} in C). Read \code{\link{pot}} to see how
to get different font formats. Trying to insert a
\code{'\n'} will have no effect. If an end of line is
required , a new paragraph is required.
}
\seealso{
\code{\link{docx}}, \code{\link{addParagraph.docx}} ,
\code{\link{pptx}}, \code{\link{addParagraph.pptx}} ,
\code{\link{html}}, \code{\link{addParagraph.html}} ,
\code{\link{pot}}, \code{\link{textProperties}}
}

