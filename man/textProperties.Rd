\name{textProperties}
\alias{textProperties}
\title{Text formating properties}
\usage{
  textProperties(color = "black",
    font.size = getOption("ReporteRs-fontsize"),
    font.weight = "normal", font.style = "normal",
    underlined = FALSE,
    font.family = getOption("ReporteRs-default-font"))
}
\arguments{
  \item{color}{single character value specifying font
  color. (default to \code{black})}

  \item{font.size}{single integer value specifying font
  size in pixel. (default to \code{10})}

  \item{font.weight}{single character value specifying font
  weight (expected value is \code{normal} or \code{bold}).
  (default to \code{normal})}

  \item{font.style}{single character value specifying font
  style (expected value is \code{normal} or \code{italic}).
  (default to \code{normal})}

  \item{underlined}{single logical value specifying if the
  font is underlined (default to \code{FALSE}).}

  \item{font.family}{single character value specifying font
  name (it has to be an existing font in the OS). (default
  to \code{Arial}).}
}
\description{
  Create an object that describes text formating
  properties.
}
\examples{
# Create a new document
doc = docx( title = "title" )
text = pot( value = "Hello Word"
		, format = textProperties(color="red"
				, font.size = 12
				, font.weight = "bold"
				, font.style = "italic"
				, underlined = TRUE
				, font.family = "Courier New"
		)
) + " is rich"
doc <- addParagraph(doc, set_of_paragraphs(text), "Normal");
writeDoc( doc, "Hello_Word.docx" )
}
\seealso{
  \code{\link{docx}}
}

