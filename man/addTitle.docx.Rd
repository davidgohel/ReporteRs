\name{addTitle.docx}
\alias{addTitle.docx}
\title{Insert a title into a docx object}
\usage{
\method{addTitle}{docx}(doc, value, level = 1, ...)
}
\arguments{
  \item{doc}{Object of class \code{\link{docx}}}

  \item{value}{\code{"character"} value to use as title
  text}

  \item{level}{\code{"integer"} positive value to use as
  heading level. 1 for title1, 2 for title2, etc. Default
  to 1.}

  \item{...}{further arguments, not used.}
}
\value{
an object of class \code{\link{docx}}.
}
\description{
Add a title into a \code{\link{docx}} object.
}
\details{
In MS Word, you can use whatever style you want as title
formatting style. But to be considered as entries for a
Table of Content, used styles must be 'title' styles.
Theses are always available in MS Word list styles. When
template is read, ReporteRs try to guess what are theses
styles. If it does not succeed, you will see that error
when addTitle will be called:

Error in addHeader(...\cr You must defined title styles via
declareTitlesStyles first.

You have to use function
\code{\link{declareTitlesStyles.docx}} to indicate which
available styles are meant to be used as titles styles. A
side effect is that you will be able then to add a table of
content in your Word document.
}
\examples{
#START_TAG_TEST
# Create a new document
doc = docx( title = "title" )

# add a title (level 1)
doc = addTitle( doc, "My first title", level = 1 )

# add another title (level 2)
doc = addTitle( doc, "My first sub-title", level = 2 )
doc = addParagraph(doc, "Hello Word!", stylename = "Normal")

# Write the object in file "addTitle_example.docx"
writeDoc( doc, "addTitle_example.docx" )
#STOP_TAG_TEST
}
\seealso{
\code{\link{docx}}, \code{\link{addParagraph.docx}} ,
\code{\link{declareTitlesStyles.docx}},
\code{\link{styles.docx}}
}

