\name{addPage.html}
\alias{addPage.html}
\title{Insert a page into an html object}
\usage{
\method{addPage}{html}(doc, title,
  list.definition = getOption("ReporteRs-list-definition"), ...)
}
\arguments{
  \item{doc}{\code{\link{html}} object where page has to be
  added}

  \item{title}{\code{"character"} value: title of the HTML
  page.}

  \item{list.definition}{a list definition to specify how
  ordered and unordered lists have to be formated. See
  \code{\link{list.settings}}. Default to
  \code{getOption("ReporteRs-list-definition")}.}

  \item{...}{further arguments, not used.}
}
\value{
an object of class \code{\link{html}}.
}
\description{
Add a page into a \code{\link{html}} object.
}
\details{
A page is where content is added. This function is a key
function ; if no page has been added into the document
object no content (tables, plots, images, text) can be
added.
}
\examples{
#START_TAG_TEST
# Create a new document
doc = html( title = "title" )

# add a page where to add R outputs with title 'page example'
doc = addPage( doc, title = "page example" )

# add iris dataset as a table in the page
doc = addTable(doc, iris )

# write the html object in a directory
pages = writeDoc( doc, "addPage_example")
print( pages ) # print filenames of generated html pages
#STOP_TAG_TEST
}
\seealso{
\code{\link{html}}, \code{\link{addPage}}
}

