\name{addColumnBreak.docx}
\alias{addColumnBreak.docx}
\title{Insert a column break into a docx section}
\usage{
\method{addColumnBreak}{docx}(doc, ...)
}
\arguments{
  \item{doc}{Object of class \code{\link{docx}} where
  column break has to be added}

  \item{...}{further arguments, not used.}
}
\value{
an object of class \code{\link{docx}}.
}
\description{
Insert a page break into a \code{\link{docx}} section.
}
\examples{
#START_TAG_TEST
doc.filename = "addColumnBreak.docx"
doc = docx( )
doc = addSection(doc, ncol = 2, columns.only = TRUE )
doc = addParagraph( doc = doc, "Text 1.", "Normal" )
doc = addColumnBreak(doc )
doc = addParagraph( doc = doc, "Text 2.", "Normal" )

# Write the object
writeDoc( doc, file = doc.filename )
#STOP_TAG_TEST
}
\seealso{
\code{\link{docx}}, \code{\link{addColumnBreak}},
\code{\link{addSection.docx}}
}

