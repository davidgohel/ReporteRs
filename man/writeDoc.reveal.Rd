\name{writeDoc.reveal}
\alias{writeDoc.reveal}
\title{Write a reveal object in a reveal file}
\usage{
  \method{writeDoc}{reveal} (doc, directory, ...)
}
\arguments{
  \item{doc}{Object of class \code{"reveal"} that has to be
  written.}

  \item{directory}{single character value, name of the
  directory that will contain generated reveal pages.}

  \item{...}{further arguments, not used.}
}
\description{
  Write the \code{"reveal"} object in '.reveal' files
  located in a specified directory.
}
\examples{
# Create a new document
doc = reveal( title = "title" )

# add a page where to add R outputs
doc = addSlide( doc  )
# add iris dataset as a table in the page
doc <- addTable(doc, iris )

# write the reveal object in a directory
reveal.directory <- "reveal_doc"
reveal.files = writeDoc( doc, directory = reveal.directory )
}
\seealso{
  \code{\link{reveal}}, \code{\link{writeDoc}}
}

