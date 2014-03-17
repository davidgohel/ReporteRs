\name{addPlot.html}
\alias{addPlot.html}
\title{Add a plot into an html object}
\usage{
  \method{addPlot}{html} (doc, fun,
    pointsize = getOption("ReporteRs-fontsize"),
    vector.graphic = T, width = 6, height = 6,
    fontname = getOption("ReporteRs-default-font"), ...)
}
\arguments{
  \item{doc}{Object of class \code{"html"} where paragraph
  has to be added}

  \item{fun}{plot function}

  \item{width}{plot width in inches (default value is 6).}

  \item{height}{plot height in inches (default value is
  6).}

  \item{vector.graphic}{logical scalar, default to FALSE.
  If TRUE, vector graphics are produced instead of PNG
  images. If TRUE, vector graphics are RaphaelJS
  instructions(transformed as SVG).}

  \item{pointsize}{the default pointsize of plotted text in
  pixels, default to 12.}

  \item{fontname}{the default font family to use, default
  to getOption("ReporteRs-default-font").}

  \item{...}{arguments for \code{fun}.}
}
\value{
  an object of class \code{"html"}.
}
\description{
  Add a plot into the \code{html} object.
}
\examples{
#START_TAG_TEST
require( ggplot2 )
# Create a new document
doc = html( title = "title" )

# add a page where to add R plots with title 'Plots'
doc = addPage( doc, title = "Plots" )
# Add a base plot
doc = addPlot( doc, fun = plot
		, x = rnorm( 100 )
		, y = rnorm (100 )
		, main = "base plot main title"
	)
myplot = qplot(Sepal.Length, Petal.Length, data = iris, color = Species
	, size = Petal.Width, alpha = I(0.7))
doc = addPlot( doc
		, print
		, width = 6, height = 7
		, x = myplot #this argument MUST be named, print is expecting argument 'x'
	)

doc = addPlot( doc, print
		, width = 6, height = 7
		, x = myplot, vector.graphic = FALSE
	)

ctl <- c(4.17,5.58,5.18,6.11,4.50,4.61,5.17,4.53,5.33,5.14)
trt <- c(4.81,4.17,4.41,3.59,5.87,3.83,6.03,4.89,4.32,4.69)
group <- gl(2, 10, 20, labels = c("Ctl","Trt"))
weight <- c(ctl, trt)
lm.D9 <- lm(weight ~ group)
doc = addPlot( doc, function() plot( lm.D9 )
		, width = 6, height = 7
		, x = myplot, vector.graphic = FALSE
	)
# write the html object in a directory
pages = writeDoc( doc, "addPlot_example")
print( pages ) # print filenames of generated html pages
#STOP_TAG_TEST
}
\seealso{
  \code{\link{html}}, \code{\link{addPlot}}
}

