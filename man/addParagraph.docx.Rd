\name{addParagraph.docx}
\alias{addParagraph.docx}
\title{Insert a paragraph into a docx object}
\usage{
  \method{addParagraph}{docx} (doc, value, stylename,
    bookmark, ...)
}
\arguments{
  \item{doc}{Object of class \code{"docx"} where paragraph
  has to be added}

  \item{value}{character vector containing texts to add OR
  an object of class \code{\link{set_of_paragraphs}}.}

  \item{stylename}{value of the named style to apply to
  paragraphs in the docx document. see
  \code{\link{styles.docx}}.}

  \item{bookmark}{a character value ; id of the Word
  bookmark to replace by the table. optional}

  \item{...}{further arguments, not used.}
}
\value{
  an object of class \code{"docx"}.
}
\description{
  Insert paragraph(s) of text into a \code{docx} object
}
\examples{
# Create a new document
doc = docx( title = "title" )

# Add "Hello World" into the document doc
doc <- addParagraph(doc, "Hello Word!", "Normal");

# Add into the document : "My tailor is rich" and "Cats and Dogs"
# format some of the pieces of text
pot1 = pot("My tailor", textProperties(color="red") ) + " is " + pot("rich"
	, textProperties(font.weight="bold") )
my.pars = set_of_paragraphs( pot1 )
pot2 = pot("Cats", textProperties(color="red") ) + " and " + pot("Dogs"
	, textProperties(color="blue") )
my.pars = set_of_paragraphs( pot1, pot2 )

# used style is "BulletList" so that paragraphs will be preceded by bullet points
# ("BulletList" is an existing style in the defaut template docx of the package)
doc <- addParagraph(doc, my.pars, "BulletList");

# Write the object in file "document.docx"
writeDoc( doc, "document.docx" )
}
\seealso{
  \code{\link{docx}}, \code{\link{addParagraph}}
}

