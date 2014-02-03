\name{addPlot.reveal}
\alias{addPlot.reveal}
\title{Add a plot into an reveal object}
\usage{
  \method{addPlot}{reveal} (doc, fun,
    pointsize = getOption("ReporteRs-fontsize"),
    vector.graphic = T, width = 6, height = 6,
    fontname = getOption("ReporteRs-default-font"), ...)
}
\arguments{
  \item{doc}{Object of class \code{"reveal"} where
  paragraph has to be added}

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
  an object of class \code{"reveal"}.
}
\description{
  Add a plot into the \code{reveal} object.
}
\examples{
# Create a new document
doc = reveal( title = "title" )

# add a page where to add R plots with title 'Plots'
doc = addSlide( doc )
# Add a base plot
doc = addPlot( doc, fun = plot
		, x = rnorm( 100 )
		, y = rnorm (100 )
		, main = "base plot main title"
	)
myplot = qplot(Sepal.Length, Petal.Length, data = iris, color = Species, size = Petal.Width, alpha = I(0.7))
doc = addPlot( doc
		, print
		, width = 6, height = 7
		, x = myplot #this argument MUST be named, print is expecting argument 'x'
	)

# write the reveal object in a directory
reveal.directory <- "reveal_doc"
reveal.files = writeDoc( doc, directory = reveal.directory )
}
\seealso{
  \code{\link{reveal}}, \code{\link{addPlot}}
}

