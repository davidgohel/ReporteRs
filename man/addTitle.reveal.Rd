\name{addTitle.reveal}
\alias{addTitle.reveal}
\title{Insert a title into a reveal object}
\usage{
  \method{addTitle}{reveal} (doc, value, level, ...)
}
\arguments{
  \item{doc}{Object of class \code{"reveal"}}

  \item{value}{\code{"character"} value to use as title
  text}

  \item{level}{\code{"integer"} positive value to use as
  heading level. 1 for title1, 2 for title2, etc.}

  \item{...}{further arguments, not used.}
}
\value{
  an object of class \code{"reveal"}.
}
\description{
  Add a title into a \code{"reveal"} object.
}
\examples{
# Create a new document
doc = reveal( title = "title" )
# add a page where to write
doc = addSlide( doc )
doc = addTitle( doc, "My first title", level = 1 )
doc = addTitle( doc, "My first sub-title", level = 2 )
doc <- addParagraph(doc, "Hello Word!", "Normal");
# write the reveal object in a directory
reveal.directory <- "reveal_doc"
reveal.files = writeDoc( doc, directory = reveal.directory )
}
\seealso{
  \code{\link{reveal}}, \code{\link{addTitle}}
}

