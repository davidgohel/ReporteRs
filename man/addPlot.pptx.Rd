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
require( ggplot2 )
# Create a new document
doc = pptx( title = "title" )

# add a slide with layout "Title and Content" then add plot
doc = addSlide( doc, slide.layout = "Title and Content" )
doc = addTitle( doc, "base plot" )
# Add a base plot
doc = addPlot( doc, fun = plot
		, x = rnorm( 100 )
		, y = rnorm (100 )
		, main = "base plot main title"
	)

# add a slide with layout "Two Content" then add 2 plots
doc = addSlide( doc, slide.layout = "Two Content" )
doc = addTitle( doc, "2 ggplot2 examples" )
doc = addPlot( doc
		, function(){
			print( qplot(Sepal.Length, Petal.Length, data = iris, color = Species
				, size = Petal.Width, alpha = I(0.7)) )
		}
	)

myplot = qplot(Sepal.Length, Petal.Length, data = iris, color = Species
			, size = Petal.Width, alpha = I(0.7))
doc = addPlot( doc
		, print
		, x = myplot #this argument MUST be named, print is expecting argument 'x'
		, vector.graphic = FALSE
	)

# Write the object in file "addPlot_example.pptx"
writeDoc( doc, "addPlot_example.pptx" )
#STOP_TAG_TEST
}
\seealso{
\code{\link{pptx}}, \code{\link{addPlot}}
}

