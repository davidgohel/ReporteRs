\name{addPlot}
\alias{addPlot}
\title{Add a plot into a document object}
\usage{
  addPlot(doc, fun, pointsize = 12, vector.graphic = F,
    ...)
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
  Plot parameters are specified with the \code{...}
  argument. However, the most convenient usage is to wrap
  the plot code into a function whose parameters will be
  specified as '...'.

  If you want to add ggplot2 or lattice plot, use
  \code{print} function. See examples for more details.
  \describe{ \item{vector.graphic}{If document is a pptx or
  html document, vector graphics will always be displayed.
  Don't use vector graphics if document is a docx and MS
  Word version used to open the document is 2007.  } }
}
\examples{
\dontrun{
# Add a base plot
doc = addPlot( doc = doc, fun = plot
		, x = rnorm( 100 )
		, y = rnorm (100 )
		, main = "base plot main title"
	)

## Add a ggplot2
myplot = qplot(Sepal.Length, Petal.Length, data = iris, color = Species
	, size = Petal.Width, alpha = I(0.7))
doc = addPlot( doc = doc
		, fun = print
		, x = myplot #this argument MUST be named, print is expecting argument 'x'
	)

## Add a ggplot2 and another plot
require(ggplot2)
doc = addPlot( doc = doc
		, fun = function(){
			print( qplot(Sepal.Length, Petal.Length, data = iris, color = Species
				, size = Petal.Width, alpha = I(0.7)) )
			plot(x = rnorm( 100 ), y = rnorm (100 ), main = "base plot main title")
		}
	)
}
}
\seealso{
  \code{\link{docx}}, \code{\link{addPlot.docx}} ,
  \code{\link{pptx}}, \code{\link{addPlot.pptx}} ,
  \code{\link{html}}, \code{\link{addPlot.html}}
}

