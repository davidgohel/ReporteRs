\name{addParagraph.html}
\alias{addParagraph.html}
\title{Insert a paragraph into an html object}
\usage{
  \method{addParagraph}{html} (doc, value,
    stylename = "text-primary", parent.type = "div", ...)
}
\arguments{
  \item{doc}{Object of class \code{"html"} where paragraph
  has to be added}

  \item{value}{character vector containing texts to add OR
  an object of class \code{\link{set_of_paragraphs}}.}

  \item{stylename}{value of the named style to apply to
  paragraphs in the html document. See
  http://getbootstrap.com/css and look for 'class'
  examples.}

  \item{parent.type}{a character value ; parent tag for
  added paragraph. optional. If 'div', paragraph is normal
  ; if 'ol', paragraph will be an ordered list ; if 'ul',
  paragraph will be an unordered list ; if 'pre', paragraph
  will be a preformatted text area.}

  \item{...}{further arguments, not used.}
}
\value{
  an object of class \code{"html"}.
}
\description{
  Insert paragraph(s) of text into a \code{html} object
}
\examples{
#START_TAG_TEST
# Create a new document
doc = html( title = "title" )

# add a page where to add R outputs with title 'page example 1'
doc = addPage( doc, title = "page example 1" )

# Add "Hello World" into the document doc
doc <- addParagraph(doc, "Hello Word!")

# add a page where to add R outputs with title 'page example 2'
doc = addPage( doc, title = "page example 2" )

# Add into the document : "My tailor is rich" and "Cats and Dogs"
# format some of the pieces of text
pot1 = pot("My tailor", textProperties(color="red") ) + " is " + pot("rich"
	, textProperties(font.weight="bold") )
pot2 = pot("Cats", textProperties(color="red") ) + " and " + pot("Dogs"
	, textProperties(color="blue") )
my.pars = set_of_paragraphs( pot1, pot2 )

# used parent.type = "ul" so that paragraphs will be preceded by bullet points
doc <- addParagraph(doc, my.pars, parent.type = "ul")

# write the html object in a directory
pages = writeDoc( doc, "addParagraph_example")
print( pages ) # print filenames of generated html pages
#STOP_TAG_TEST
}
\seealso{
  \code{\link{docx}}, \code{\link{addTitle.docx}} ,
  \code{\link{addTOC.docx}}, \code{\link{addParagraph}}
}

