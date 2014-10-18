\name{doc-list-settings}
\alias{doc-list-settings}
\alias{list.settings}
\title{format ordered and unordered lists}
\arguments{
  \item{ol.left}{left indent values (in inches) for each
  level of an ordered list. Length must be 9 as there are 9
  elements to define (from level1 to level9).}

  \item{ol.hanging}{space values (in inches) between
  numbering label (argument \code{ol.format}) and content
  for each level of an ordered list. Length must be 9 as
  there are 9 elements to define (from level1 to level9).}

  \item{ol.format}{type of numbering for ordered levels,
  values can be 'decimal' or 'upperRoman' or 'lowerRoman'
  or 'upperLetter' or 'lowerLetter'. Length must be 9 as
  there are 9 elements to define (from level1 to level9).}

  \item{ol.pattern}{numbering pattern for ordered levels. A
  level numbering has the following syntax: \code{"\%1"}
  (numbering of level1), \code{"\%2"} (numbering of
  level2), ..., \code{"\%9"} (numbering of level9).}

  \item{ul.left}{left indent values for each level of an
  unordered list. Length must be 9 as there are 9 elements
  to define (from level1 to level9). Length must be 9 as
  there are 9 elements to define (from level1 to level9).}

  \item{ul.hanging}{space values (in inches) between bullet
  symbol (argument \code{ul.format}) and content for each
  level of an unordered list. Length must be 9 as there are
  9 elements to define (from level1 to level9).}

  \item{ul.format}{type of bullet for unordered levels,
  values can be 'disc' or 'circle' or 'square'. Length must
  be 9 as there are 9 elements to define (from level1 to
  level9).}
}
\description{
Create a description used to format ordered and unordered
lists in object documents.
}
\details{
List settings are used to configure formatting of list in
documents.

It can be set in R session options or as a parameter in
\code{\link{docx}} or \code{\link{pptx}} or
\code{\link{addPage.html}}.
}
\examples{
numbering.pattern = c( "\%1.", "\%1. \%2.", "\%1. \%2. \%3.",
  "\%4.", "\%5.", "\%6.", "\%7.", "\%8.", "\%9." )

ordered.formats = rep( c( "decimal", "upperRoman", "upperLetter"), 3 )

unordered.formats = rep( c( "square", "disc", "circle"), 3 )

left.indent = seq( from = 0, by = 0.5, length.out = 9)

options("ReporteRs-list-definition" = list(
  ol.left = left.indent,
  ol.hanging = rep( 0.4, 9 ),
  ol.format = ordered.formats,
	ol.pattern = numbering.pattern,
	ul.left = left.indent,
	ul.hanging = rep( 0.4, 9 ),
	ul.format = unordered.formats
	)
)
}
\seealso{
\code{\link{addParagraph.docx}},
\code{\link{addParagraph.pptx}},
\code{\link{addParagraph.html}}
}

