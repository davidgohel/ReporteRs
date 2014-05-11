\name{addPlot}
\alias{addPlot}
\title{Add a plot into a document object}
\usage{
addPlot(doc, fun, pointsize = 12, vector.graphic = F, ...)
}
\arguments{
  \item{doc}{document object}

  \item{fun}{plot function}

  \item{vector.graphic}{logical scalar, if TRUE, vector
  graphics are produced instead of PNG images.

  SVG will be produced for \code{html} objects and
  DrawingML instructions for \code{docx} and \code{pptx}
  objects.

  DrawingML instructions offer advantage to provide
  editable graphics (forms and texts colors , texts
  contents, moving and resizing is disabled).}

  \item{pointsize}{the default pointsize of plotted text in
  pixels, default to 12.}

  \item{...}{further arguments passed to or from other
  methods..}
}
\value{
a document object
}
\description{
Add a plot into a document object
}
\details{
Plot parameters are specified with the \code{...} argument.
However, the most convenient usage is to wrap the plot code
into a function whose parameters will be specified as
'...'.

If you want to add ggplot2 or lattice plot, use
\code{print} function.

\code{vector.graphic}: if document is a pptx or html
document, vector graphics will always be displayed.Don't
use vector graphics if document is a docx and MS Word
version used to open the document is 2007.

See \code{\link{addParagraph.docx}} or
\code{\link{addParagraph.pptx}} or
\code{\link{addParagraph.html}} for examples.
}
\seealso{
\code{\link{docx}}, \code{\link{addPlot.docx}} ,
\code{\link{pptx}}, \code{\link{addPlot.pptx}} ,
\code{\link{html}}, \code{\link{addPlot.html}}
}

