\name{addPlot.pptx}
\alias{addPlot.pptx}
\title{Add a plot into a pptx object}
\usage{
\method{addPlot}{pptx}(doc, fun, pointsize = 11, vector.graphic = TRUE,
  fontname = getOption("ReporteRs-default-font"), editable = TRUE, ...)
}
\arguments{
  \item{doc}{the \code{pptx} to use}

  \item{fun}{plot function}

  \item{pointsize}{the default pointsize of plotted text,
  interpreted as big points (1/72 inch) at res ppi.}

  \item{vector.graphic}{logical scalar, default to TRUE. If
  TRUE, vector graphics are produced instead of PNG images.
  Vector graphics in pptx document are DrawingML
  instructions.}

  \item{fontname}{the default font family to use, default
  to getOption("ReporteRs-default-font").}

  \item{editable}{logical value - if TRUE vector graphics
  elements (points, texts, etc.) are editable.}

  \item{...}{arguments for \code{fun}.}
}
\value{
an object of class \code{"pptx"}.
}
\description{
Add a plot to the current slide of an existing \code{pptx}
object.
}
\details{
Width and height can't be controled here. They are defined
by the width and height of the shape that will contain the
graphics.

This dimensions can be defined in the layout of the
PowerPoint template used to create the \code{pptx} object.
}
\examples{
#START_TAG_TEST
doc.filename = "addPlot_example.pptx"

# set default font size to 24
options( "ReporteRs-fontsize" = 24 )

doc = pptx( title = "title" )

# add a slide with layout "Title and Content"
doc = addSlide( doc, slide.layout = "Title and Content" )

doc = addTitle( doc, "Title example 1" )
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

# add a slide with layout "Title and Content"
doc = addSlide( doc, slide.layout = "Title and Content" )

doc = addTitle( doc, "Title example 2" )
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
\code{\link{pptx}}, \code{\link{addPlot}}
}

