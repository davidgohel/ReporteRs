\name{addTitle.html}
\alias{addTitle.html}
\title{Insert a title into a html object}
\usage{
\method{addTitle}{html}(doc, value, level, ...)
}
\arguments{
  \item{doc}{Object of class \code{"html"}}

  \item{value}{\code{"character"} value to use as title
  text}

  \item{level}{\code{"integer"} positive value to use as
  heading level. 1 for title1, 2 for title2, etc.}

  \item{...}{further arguments, not used.}
}
\value{
an object of class \code{"html"}.
}
\description{
Add a title into a \code{"html"} object.
}
\examples{
#START_TAG_TEST
# Create a new document
doc = html( title = "title" )

# add a page where to write
doc = addPage( doc, title = "page example" )

doc = addTitle( doc, "My first title", level = 1 )
doc = addTitle( doc, "My first sub-title", level = 2 )

doc <- addParagraph(doc, "Hello Word!" )

# writes document in directory "addTitle_example"
writeDoc( doc, "addTitle_example" )
#STOP_TAG_TEST
}
\seealso{
\code{\link{html}}, \code{\link{addTitle}}
}

