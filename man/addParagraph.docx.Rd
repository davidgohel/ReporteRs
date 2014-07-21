\name{addParagraph.docx}
\alias{addParagraph.docx}
\title{Insert a paragraph into a docx object}
\usage{
\method{addParagraph}{docx}(doc, value, stylename, bookmark, ...)
}
\arguments{
  \item{doc}{Object of class \code{"docx"} where paragraph
  has to be added}

  \item{value}{character vector containing texts to add to
  the document as paragraphs: an object of class
  \code{\link{pot}} or \code{\link{set_of_paragraphs}} or a
  character vector.}

  \item{stylename}{value of the named style to apply to
  paragraphs in the docx document. Expected value is an
  existing stylename of the template document used to
  create the \code{docx} object. see
  \code{\link{styles.docx}}.}

  \item{bookmark}{a character value ; id of the Word
  bookmark to replace by the table. optional. See
  \code{\link{bookmark}}.}

  \item{...}{further arguments, not used.}
}
\value{
an object of class \code{"docx"}.
}
\description{
Insert paragraph(s) of text into a \code{docx} object
}
\examples{
#START_TAG_TEST
doc.filename = "addParagraph_example.docx"

# set default font size to 10
options( "ReporteRs-fontsize" = 10 )

doc = docx( )

# returns available stylenames
styles( doc )

doc = addTitle( doc, "Title example 1", level = 1 )

# Add "Hello World" into the document doc
doc = addParagraph(doc, "Hello Word", stylename = "Normal" )


doc = addTitle( doc, "Title example 2", level = 1 )

# define some texts
texts = c( "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
		, "In sit amet ipsum tellus. Vivamus dignissim arcu sit amet faucibus auctor."
		, "Quisque dictum tristique ligula."
)

# add texts with stylename BulletList
doc = addParagraph( doc, value = texts, stylename="BulletList" )


doc = addTitle( doc, "Title example 3", level = 1 )

# "My tailor is rich" with formatting on some words
pot1 = pot("My tailor", textProperties(color = "red" ) 
  ) + " is " + pot("rich", textProperties( font.weight = "bold" ) )

# "Cats and dogs" with formatting on some words
pot2 = pot("Cats", textProperties(color = "red" ) 
  ) + " and " + pot("dogs", textProperties( color = "blue" ) )

# create a set of paragraphs made of pot1 and pot2
my.pars = set_of_paragraphs( pot1, pot2 )

# Add my.pars into the document doc
doc = addParagraph(doc, my.pars, stylename = "Normal" )

# Write the object
writeDoc( doc, file = doc.filename )
#STOP_TAG_TEST
}
\seealso{
\code{\link{docx}}, \code{\link{addParagraph}},
\code{\link{bookmark}}
}

