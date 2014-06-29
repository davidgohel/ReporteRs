\name{raphael.html}
\alias{raphael.html}
\title{Add a plot into an html object}
\usage{
raphael.html(fun, pointsize = getOption("ReporteRs-fontsize"), width = 6,
  height = 6, fontname = getOption("ReporteRs-default-font"),
  canvas_id = 0, ...)
}
\arguments{
  \item{fun}{plot function}

  \item{width}{plot width in inches (default value is 6).}

  \item{height}{plot height in inches (default value is
  6).}

  \item{pointsize}{the default pointsize of plotted text in
  pixels, default to 12.}

  \item{fontname}{the default font family to use, default
  to getOption("ReporteRs-default-font").}

  \item{canvas_id}{canvas id - an integer - unique id in
  the web page}

  \item{...}{arguments for \code{fun}.}
}
\value{
an html string.
}
\description{
Add a plot into the \code{html} object.
}
\examples{
#START_TAG_TEST

# load ggplot2
require( ggplot2 )

# create a ggplot2 plot
myplot = qplot(Sepal.Length, Petal.Length, data = iris
		, color = Species, size = Petal.Width, alpha = I(0.7) )

raphael.html( fun = function( ){
		plot( x = rnorm( 100 ), y = rnorm (100 ), main = "base plot main title" )
		print( myplot )
	}
	, width = 5, height = 7
)
#STOP_TAG_TEST
}
\seealso{
\code{\link{html}}, \code{\link{addPlot}},
\code{\link{add.plot.interactivity}} ,
\code{\link{addPlot.html}}
}

