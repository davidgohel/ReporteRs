\name{addPage.html}
\alias{addPage.html}
\title{Insert a page into an html object}
\usage{
\method{addPage}{html}(doc, title, ...)
}
\arguments{
  \item{doc}{Object of class \code{"html"} where page has
  to be added}

  \item{title}{\code{"character"} value: title of the HTML
  page.}

  \item{...}{further arguments, not used.}
}
\value{
an object of class \code{"html"}.
}
\description{
Add a page into a \code{"html"} object.
}
\details{
A page is where content is added. This function is a key
function ; if no page has been added into the document
object no content (tables, plots, images, texts) can be
added.
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
pages = writeDoc( doc, "addPage_example")
print( pages ) # print filenames of generated html pages
#STOP_TAG_TEST
}
\seealso{
\code{\link{html}}, \code{\link{addPage}}
}

