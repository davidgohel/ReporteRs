\name{addParagraph.html}
\alias{addParagraph.html}
\title{Insert a paragraph into an html object}
\usage{
\method{addParagraph}{html}(doc, value, par.properties = parProperties(),
  restart.numbering = FALSE, ...)
}
\arguments{
  \item{doc}{\code{\link{html}} object where paragraph has
  to be added}

  \item{value}{text to add to the document as paragraphs:
  an object of class \code{\link{pot}} or
  \code{\link{set_of_paragraphs}} or a character vector.}

  \item{par.properties}{\code{\link{parProperties}} to
  apply to paragraphs.}

  \item{restart.numbering}{boolean value. If \code{TRUE},
  next numbered list counter will be set to 1.}

  \item{...}{further arguments, not used.}
}
\value{
an object of class \code{\link{html}}.
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
  ) + " is " + pot("rich", textProperties(shading.color = "red", font.weight = "bold" ) )

# "Cats and dogs" with formatting on some words
pot2 = pot("Cats", textProperties(color = "red" ) 
  ) + " and " + pot("dogs", textProperties( color = "blue" ) )

# create a set of paragraphs made of pot1 and pot2
my.pars = set_of_paragraphs( pot1, pot2 )

# Add my.pars into the document doc
doc = addParagraph(doc, my.pars )


doc = addTitle( doc, "Title example 3", level = 1 )
# define some text
text1 = "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
text2 = "In sit amet ipsum tellus. Vivamus dignissim arcu sit amet faucibus auctor."
text3 = "Quisque dictum tristique ligula."

# define parProperties with list properties
ordered.list.level1 = parProperties(list.style = "ordered", level = 1 )
ordered.list.level2 = parProperties(list.style = "ordered", level = 2 )

# define parProperties with list properties
unordered.list.level1 = parProperties(list.style = "unordered", level = 1 )
unordered.list.level2 = parProperties(list.style = "unordered", level = 2 )

# add ordered list items 
doc = addParagraph( doc, value = text1, 
	par.properties = ordered.list.level1 )
doc = addParagraph( doc, value = text2, 
	par.properties = ordered.list.level2 )

# add ordered list items without restart renumbering
doc = addParagraph( doc, value = c( text1, text2, text3), 
	par.properties = ordered.list.level1 )

# add ordered list items and restart renumbering
doc = addParagraph( doc, value = c( text1, text2, text3), restart.numbering = TRUE, 
		par.properties = ordered.list.level1 )

# add unordered list items
doc = addParagraph( doc, value = text1, 
		par.properties = unordered.list.level1 )
doc = addParagraph( doc, value = text2, 
		par.properties = unordered.list.level2 )


# Write the object
writeDoc( doc, directory = doc.dirname )
#STOP_TAG_TEST
}
\seealso{
\code{\link{html}}, \code{\link{addParagraph}}
}

