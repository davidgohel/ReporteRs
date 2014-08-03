\name{addPlot.docx}
\alias{addPlot.docx}
\title{Add a plot into a docx object}
\usage{
\method{addPlot}{docx}(doc, fun, pointsize = getOption("ReporteRs-fontsize"),
  vector.graphic = F, width = 6, height = 6,
  fontname = getOption("ReporteRs-default-font"), editable = TRUE, bookmark,
  par.properties = parProperties(text.align = "center", padding = 5), ...)
}
\arguments{
  \item{doc}{the \code{docx} to use}

  \item{fun}{plot function}

  \item{width}{plot width in inches (default value is 6).}

  \item{height}{plot height in inches (default value is
  6).}

  \item{vector.graphic}{logical scalar, default to FALSE.

  DrawingML instructions cannot be read by MS Word 2007.}

  \item{bookmark}{id of the Word bookmark to replace by the
  plot. optional.

  \code{bookmark} is a character vector specifying bookmark
  id to replace by the plot(s).\cr If provided, plot(s)
  will replace the paragraph that contains the bookmark.
  See \code{\link{bookmark}}.\cr If not provided, plot(s)
  will be added at the end of the document.}

  \item{par.properties}{paragraph formatting properties of
  the paragraph that contains plot(s). An object of class
  \code{\link{parProperties}}}

  \item{pointsize}{the default pointsize of plotted text in
  pixels, default to getOption("ReporteRs-fontsize").}

  \item{fontname}{the default font family to use, default
  to getOption("ReporteRs-default-font").}

  \item{editable}{logical value - if TRUE vector graphics
  elements (points, text, etc.) are editable.}

  \item{...}{arguments for \code{fun}.}
}
\value{
an object of class \code{"docx"}.
}
\description{
Add a plot into the \code{docx} object.
}
\examples{
#START_TAG_TEST
doc.filename = "addPlot_example.docx"

# set default font size to 10
options( "ReporteRs-fontsize" = 10 )

doc = docx( )

doc = addTitle( doc, "Title example 1", level = 1 )
# Add a base plot
# set vector.graphic to FALSE if Word version
#   used to read the file is <= 2007
doc = addPlot( doc, fun = plot
  , x = rnorm( 100 ), y = rnorm (100 )
  , main = "base plot main title"
  , vector.graphic = TRUE
  , width = 5, height = 7
  , par.properties = parProperties(text.align = "left")
)


doc = addTitle( doc, "Title example 2", level = 1 )
# load ggplot2
require( ggplot2 )

# create a ggplot2 plot
myplot = qplot(Sepal.Length, Petal.Length, data = iris
  , color = Species, size = Petal.Width, alpha = I(0.7) )

# Add myplot into object doc
#   myplot is assigned to argument 'x' because function 'print' on ggplot
#   objects is expecting argument 'x'.
doc = addPlot( doc = doc, fun = print, x = myplot )

# Write the object
writeDoc( doc, file = doc.filename )
#STOP_TAG_TEST
}
\seealso{
\code{\link{docx}}, \code{\link{addPlot}},
\code{\link{bookmark}}.
}

