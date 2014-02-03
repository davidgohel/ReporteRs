\name{addSlide.reveal}
\alias{addSlide.reveal}
\title{Insert a slide into a reveal object}
\usage{
  \method{addSlide}{reveal} (doc, ...)
}
\arguments{
  \item{doc}{Object of class \code{"reveal"} where slide
  has to be added}

  \item{...}{further arguments, not used.}
}
\value{
  an object of class \code{"reveal"}.
}
\description{
  Add a slide into a \code{"reveal"} object.
}
\details{
  A slide is where content is added. This function is a key
  function ; if no slide has been added into the document
  object no content (tables, plots, images, texts) can be
  added.
}
\examples{
# Create a new document
doc = reveal( title = "title" )

# reveal document to write
reveal.directory <- "reveal_doc"

# add a page where to add R outputs with title 'page example'
doc = addSlide( doc )

# add iris dataset as a table in the page
doc <- addTable(doc, iris )

# write the html object in a directory
writeDoc( doc, directory = reveal.directory )
}
\seealso{
  \code{\link{reveal}}, \code{\link{addSlide}}
}

