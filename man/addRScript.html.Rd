\name{addRScript.html}
\alias{addRScript.html}
\title{Add R script into a html object}
\usage{
  \method{addRScript}{html} (doc, file, text,
    show_line_numbers = T, ...)
}
\arguments{
  \item{doc}{Object of class \code{"html"} where
  expressions have to be added}

  \item{file}{R script file. Not used if text is provided.}

  \item{text}{character vector. The text to parse. Not used
  if file is provided.}

  \item{show_line_numbers}{logical indicating is row
  numbers should be written or not}

  \item{...}{further arguments, not used.}
}
\value{
  an object of class \code{"html"}.
}
\description{
  Add R script into a \code{"html"} object.
}
\examples{
\dontrun{
# Create a new document
doc = html( title = "title" )

# add a page where to add R outputs with title 'page example'
doc = addPage( doc, title = "page example" )

doc <- addRScript(doc, text = "ls()" )

# write the html object in a directory
pages = writeDoc( doc, "addRScript_example")
print( pages ) # print filenames of generated html pages
}
}
\seealso{
  \code{\link{html}}, \code{\link{addRScript}}
}

