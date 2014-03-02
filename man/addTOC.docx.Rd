\name{addTOC.docx}
\alias{addTOC.docx}
\title{Insert a table of contents into a docx object}
\usage{
\method{addTOC}{docx}(doc, stylename, ...)
}
\arguments{
  \item{doc}{Object of class \code{"docx"} where table of
  content has to be added}

  \item{stylename}{optional. Stylename in the document that
  will be used to build entries of the TOC.}

  \item{...}{further arguments, not used.}
}
\value{
an object of class \code{"docx"}.
}
\description{
Insert a table of contents into a \code{"docx"} object.
}
\details{
If stylename is not used, a classical table of content will
be produced.\cr If stylename is used, a custom table of
contents will be produced, pointing to entries that have
been formated with \code{stylename}. For example, this can
be used to produce a toc with only plots.
}
\examples{
#START_TAG_TEST
require( ggplot2 )

### example 1
# Create a new document
doc = docx( title = "title" )
#leave the first page blank and add a page break
doc = addPageBreak(doc)
# add a TOC (to be refresh when document is opened)
# and add a page break
doc <- addTOC(doc)
doc = addPageBreak(doc)

# add titles that will be entries in the TOC
doc = addTitle( doc, "My first title", level = 1 )
doc = addTitle( doc, "My second title", level = 1 )

# Write the object in file "addTOC_example1.docx"
writeDoc( doc, "addTOC_example1.docx" )


### example 2
# Create a new document
doc = docx( title = "title" )
#leave the first page blank and add a page break
doc = addPageBreak(doc)#'

doc = addTitle( doc, "Plots", level = 1 )
doc = addPlot( doc
		, fun = plot
		, x = rnorm( 100 )
		, y = rnorm (100 )
		, main = "base plot main title"
	)
doc = addParagraph( doc, value="graph example 1", stylename = "rPlotLegend" )

myplot = qplot(Sepal.Length, Petal.Length, data = iris, color = Species
		, size = Petal.Width, alpha = I(0.7))
doc = addPlot( doc = doc
		, fun = print
		, x = myplot #this argument MUST be named, print is expecting argument 'x'
	)
doc = addParagraph( doc, value="graph example 2", stylename = "rPlotLegend" )

# Because we used "rPlotLegend" as legend in plot
# , addTOC will use this stylename to define
# entries in the generated TOC
doc <- addTOC(doc, stylename = "rPlotLegend")

# Write the object in file "addTOC_example2.docx"
writeDoc( doc, "addTOC_example2.docx" )
#STOP_TAG_TEST
}
\seealso{
\code{\link{docx}}, \code{\link{addTitle.docx}} ,
\code{\link{styles.docx}}, \code{\link{addParagraph.docx}}
}

