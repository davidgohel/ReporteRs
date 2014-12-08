\docType{package}
\name{ReporteRs-package}
\alias{ReporteRs}
\alias{ReporteRs-package}
\title{ReporteRs: a package to create document from R}
\description{
ReporteRs lets you create Microsoft Word, Microsoft
Powerpoint and html documents.
}
\details{
\tabular{ll}{ Package: \tab ReporteRs\cr Type: \tab
Package\cr Version: \tab 0.7.2\cr Date: \tab 2014-12-08\cr
License: \tab GPL (>= 3)\cr LazyLoad: \tab yes\cr }

To get an r document object: \itemize{ \item
\code{\link{docx}} Create a Microsoft Word document object
\item \code{\link{pptx}} Create a Microsoft PowerPoint
document object \item \code{\link{bsdoc}} Create an HTML
document object }

The following functions can be used whatever the output
format is (docx, pptx, bsdoc).

\itemize{ \item \code{\link{addTitle}} Add a title \item
\code{\link{addFlexTable}} Add a table (new) \item
\code{\link{addPlot}} Add plots \item
\code{\link{addImage}} Add external images \item
\code{\link{addMarkdown}} Add markdown \item
\code{\link{addParagraph}} Add paragraphs of text \item
\code{\link{addRScript}} Add an r script \item
\code{\link{writeDoc}} Write the document into a file or a
directory }

\code{ReporteRs} comes with an object of class
\code{\link{pot}} to let you handle text output and format.
You can associate a text with formats (font size, font
color, etc.), with an hyperlink or with a
\code{\link{Footnote}} as a reference note.

\code{ReporteRs} comes also with an object of class
\code{\link{FlexTable}} that let you design and format
tabular outputs.

If many text output is needed you may consider using
function \code{\link{addMarkdown}}.

Default values:

With ReporteRs, some options can be used to reduce usage of
some parameters: \itemize{ \item
\code{"ReporteRs-default-font"} Default font family to use
(default to "Helvetica"). This will be used as default
values for argument \code{fontname} of
\code{\link{addPlot}} and argument \code{font.family} of
\code{\link{pot}}.

Note that if you do not have \code{Helvetica} font, this
options must be set to an available font.

\item \code{"ReporteRs-fontsize"} Default font size to use
(default to 11). This will be used as default values for
argument \code{pointsize} of \code{\link{addPlot}} and
argument \code{font.size} of \code{\link{pot}}.  \item
\code{"ReporteRs-backtick-color"} backtick font color in
markdown \item \code{"ReporteRs-backtick-shading-color"}
backtick shading color in markdown \item
\code{"ReporteRs-list-definition"} see
\code{\link{list.settings}}.  \item
\code{"ReporteRs-locale.language"} language encoding (for
html objects). Default to "en".  \item
\code{"ReporteRs-locale.region"} region encoding (for html
objects). Default to "US". }
}
\examples{
#START_TAG_TEST
options("ReporteRs-fontsize"=10, "ReporteRs-default-font"="Arial")
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
#STOP_TAG_TEST
}
\author{
David Gohel \email{david.gohel@lysis-consultants.fr}
}

