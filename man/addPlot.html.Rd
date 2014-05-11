\name{addPlot.html}
\alias{addPlot.html}
\title{Add a plot into an html object}
\usage{
\method{addPlot}{html}(doc, fun, pointsize = getOption("ReporteRs-fontsize"),
  vector.graphic = T, width = 6, height = 6,
  fontname = getOption("ReporteRs-default-font"), ...)
}
\arguments{
  \item{doc}{Object of class \code{html} where paragraph
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
doc.dirname = "addPlot_example"

# set default font size to 10
options( "ReporteRs-fontsize" = 10 )

doc = html()

# add a page with title "page example"
doc = addPage( doc, title = "page example" )

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

doc = addTitle( doc, "Title example 3", level = 1 )
###########################################################
# Create lm.D9, a lm object
ctl = c(4.17,5.58,5.18,6.11,4.50,4.61,5.17,4.53,5.33,5.14)
trt = c(4.81,4.17,4.41,3.59,5.87,3.83,6.03,4.89,4.32,4.69)
group = gl(2, 10, 20, labels = c("Ctl","Trt"))
weight = c(ctl, trt)
lm.D9 = lm(weight ~ group)

# add the 6 plots into the document
doc = addPlot( doc, plot, x = lm.D9, width = 6, height = 7 )

# Write the object
writeDoc( doc, directory = doc.dirname )
#STOP_TAG_TEST
}
\seealso{
\code{\link{html}}, \code{\link{addPlot}},
\code{\link{add.plot.interactivity}}
}

