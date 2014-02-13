\name{addPlot.docx}
\alias{addPlot.docx}
\title{Add a plot into a docx object}
\usage{
  \method{addPlot}{docx} (doc, fun,
    pointsize = getOption("ReporteRs-fontsize"),
    vector.graphic = F, width = 6, height = 6,
    fontname = getOption("ReporteRs-default-font"),
    editable = TRUE, bookmark,
    parStyle = parProperties(text.align = "center", padding = 5),
    ...)
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
  will replace the paragraph that contains the bookmark.\cr
  If not provided, plot(s) will be added at the end of the
  document.}

  \item{parStyle}{paragraph formatting properties of the
  paragraph that contains plot(s). An object of class
  \code{\link{parProperties}}}

  \item{pointsize}{the default pointsize of plotted text in
  pixels, default to getOption("ReporteRs-fontsize").}

  \item{fontname}{the default font family to use, default
  to getOption("ReporteRs-default-font").}

  \item{editable}{logical value - if TRUE vector graphics
  elements (points, texts, etc.) are editable.}

  \item{...}{arguments for \code{fun}.}
}
\value{
  an object of class \code{"docx"}.
}
\description{
  Add a plot into the \code{docx} object.
}
\examples{
# Create a new document
doc = docx( title = "title" )

doc = addTitle( doc, "Plot 1", level = 1 )
# Add a base plot
doc = addPlot( doc, fun = plot
		, x = rnorm( 100 )
		, y = rnorm (100 )
		, main = "base plot main title"
		, vector.graphic = TRUE
		, width = 5, height = 7
		, parStyle = parProperties(text.align = "left")
	)

doc = addTitle( doc, "Plot 2", level = 1 )
myplot = qplot(Sepal.Length, Petal.Length, data = iris, color = Species, size = Petal.Width, alpha = I(0.7))
doc = addPlot( doc = doc
		, fun = print
		, x = myplot #this argument MUST be named, print is expecting argument 'x'
	)

# Write the object in file "~/document.docx"
writeDoc( doc, "~/document.docx" )
}
\seealso{
  \code{\link{docx}}, \code{\link{addPlot}}
}

