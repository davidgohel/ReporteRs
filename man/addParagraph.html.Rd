\name{addParagraph.html}
\alias{addParagraph.html}
\title{Insert a paragraph into an html object}
\usage{
\method{addParagraph}{html}(doc, value, parent.type = "div",
  par.properties = parProperties(), ...)
}
\arguments{
  \item{doc}{Object of class \code{"html"} where paragraph
  has to be added}

  \item{value}{text to add to the document as paragraphs:
  an object of class \code{\link{pot}} or
  \code{\link{set_of_paragraphs}} or a character vector.}

  \item{parent.type}{a character value ; parent tag for
  added paragraph. optional. If 'div', paragraph is normal
  ; if 'ol', paragraph will be an ordered list ; if 'ul',
  paragraph will be an unordered list ; if 'pre', paragraph
  will be a preformatted text area.}

  \item{par.properties}{paragraph formatting properties to
  apply to paragraphs of text. An object of class
  \code{\link{parProperties}}}

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
doc.dirname = "addParagraph_example"

# set default font size to 10
options( "ReporteRs-fontsize" = 10 )

doc = html()

# add a page with title "page example"
doc = addPage( doc, title = "page example" )

doc = addTitle( doc, "Title example 1", level = 1 )

# Add "Hello World" into the document doc
doc = addParagraph(doc, "Hello Word" )


doc = addTitle( doc, "Title example 2", level = 1 )

# "My tailor is rich" with formatting on some words
pot1 = pot("My tailor", textProperties(color = "red" ) 
  ) + " is " + pot("rich", textProperties( font.weight = "bold" ) )

# "Cats and dogs" with formatting on some words
pot2 = pot("Cats", textProperties(color = "red" ) 
  ) + " and " + pot("dogs", textProperties( color = "blue" ) )

# create a set of paragraphs made of pot1 and pot2
my.pars = set_of_paragraphs( pot1, pot2 )

# Add my.pars into the document doc
doc = addParagraph(doc, my.pars )

# Write the object
writeDoc( doc, directory = doc.dirname )
#STOP_TAG_TEST
}
\seealso{
\code{\link{docx}}, \code{\link{addTitle.docx}} ,
\code{\link{addTOC.docx}}, \code{\link{addParagraph}}
}

