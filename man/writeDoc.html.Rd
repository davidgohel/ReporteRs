\name{writeDoc.html}
\alias{writeDoc.html}
\title{Write a html object in a html file}
\usage{
  \method{writeDoc}{html} (doc, directory, ...)
}
\arguments{
  \item{doc}{Object of class \code{"html"} that has to be
  written.}

  \item{directory}{single character value, name of the
  directory that will contain generated html pages.}

  \item{...}{further arguments, not used.}
}
\value{
  the function a character vector containing generated html
  documents filenames.
}
\description{
  Write the \code{"html"} object in '.html' files located
  in a specified directory.
}
\examples{
#START_TAG_TEST
# Create a new document
doc = html( title = "title" )

# add a page where to add R outputs with title 'page example'
doc = addPage( doc, title = "page example" )
# add iris dataset as a table in the page
doc <- addTable(doc, iris )

# write the html object in a directory
pages = writeDoc( doc, "writeDoc_example")
print( pages ) # print filenames of generated html pages
#STOP_TAG_TEST
}
\seealso{
  \code{\link{html}}, \code{\link{writeDoc}}
}

