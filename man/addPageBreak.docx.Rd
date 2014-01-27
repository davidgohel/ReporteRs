\name{addPageBreak.docx}
\alias{addPageBreak.docx}
\title{Insert a page break into a docx object}
\usage{
  \method{addPageBreak}{docx} (doc, ...)
}
\arguments{
  \item{doc}{Object of class \code{"docx"} where page break
  has to be added}

  \item{...}{further arguments, not used.}
}
\value{
  an object of class \code{"docx"}.
}
\description{
  Insert a page break into a \code{"docx"} object.
}
\examples{
doc = docx( title = "title" )
doc <- addPageBreak(doc)
}
\seealso{
  \code{\link{docx}}, \code{\link{addPageBreak}}
}

