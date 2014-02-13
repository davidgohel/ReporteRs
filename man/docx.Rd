\name{docx}
\alias{docx}
\title{Create Microsoft Word document object representation}
\usage{
  docx(title = "untitled", template)
}
\arguments{
  \item{title}{\code{"character"} value: title of the
  document (in the doc properties).}

  \item{template}{\code{"character"} value, it represents
  the filename of the docx file used as a template.}
}
\value{
  an object of class \code{"docx"}.
}
\description{
  Create a \code{"docx"} object
}
\details{
  Several methods can used to send R output into an object
  of class \code{"docx"}.

  \itemize{ \item \code{\link{addTitle.docx}} add titles
  \item \code{\link{addParagraph.docx}} add texts \item
  \code{\link{addPlot.docx}} add plots \item
  \code{\link{addTable.docx}} add tables \item
  \code{\link{addFlexTable.docx}} add
  \code{\link{FlexTable}} \item \code{\link{addImage.docx}}
  add external images \item \code{\link{addTOC.docx}} add
  table of content \item \code{\link{addPageBreak.docx}}
  add page break }

  R outputs (tables, plots, paragraphs and images) can be
  inserted (and not added at the end) in a document if a
  bookmark exists in the template file.

  Once object has content, user can write the docx into a
  ".docx" file, see \code{\link{writeDoc}}.
}
\note{
  Word 2007-2013 (*.docx) file formats are the only
  supported files.\cr Document are manipulated in-memory ;
  a \code{docx}'s document is not written to the disk
  unless the \code{\link{writeDoc}} method has been called
  on the object.
}
\examples{
\donttest{
library( ReporteRs )

# Word document to write
docx.file <- "~/document.docx"


# Create a new document
doc = docx( title = "title" )
# display layouts names
styles( doc )

# add slide title
doc = addParagraph( doc, "Document title", stylename = "TitleDoc" )
# add slide subtitle
doc = addParagraph( doc , "This document is generated with ReporteRs.", stylename="Citationintense")

doc = addPageBreak( doc )
doc = addTitle( doc, "Table of contents", level =  1 )
doc = addTOC( doc )
doc = addPageBreak( doc )
doc = addTitle( doc, "Texts demo", level =  1 )
texts = c( "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
		, "In sit amet ipsum tellus. Vivamus dignissim arcu sit amet faucibus auctor."
		, "Quisque dictum tristique ligula."
)
# add simple text
doc = addParagraph( doc, value = texts, stylename="BulletList" )

# Add "My tailor is rich" and "Cats and Dogs"
# format some of the pieces of text
pot1 = pot("My tailor", textProperties(color="red"
						, font.size = 28 ) ) + " is " + pot("rich"
				, textProperties(font.weight="bold") )
my.pars = set_of_paragraphs( pot1 )
pot2 = pot("Cats", textProperties(color="red", font.size = 28)
) + " and " + pot("Dogs", textProperties(color="blue", font.size = 28) )
my.pars = set_of_paragraphs( pot1, pot2 )
doc <- addParagraph(doc, my.pars, stylename="Normal" )


myplot = qplot(Sepal.Length, Petal.Length
		, data = iris, color = Species
		, size = Petal.Width, alpha = I(0.7)
)

# Add myplot
doc = addTitle( doc, "Plot examples", level =  1 )
doc = addTitle( doc, "Plot example 1" , level =  2 )
doc = addPlot( doc, function( ) print( myplot ) )
doc = addParagraph( doc, value = "my first plot", stylename = "rPlotLegend")

doc = addTitle( doc, "Plot example 2" , level =  2 )
doc = addPlot( doc, function( ) {
			print( ggplot(iris, aes(Sepal.Length, fill = Species)) + geom_density(alpha = 0.7) )
		}
)
doc = addParagraph( doc, value = "my second plot", stylename = "rPlotLegend")
doc = addTitle( doc, "Plot example 3" , level =  2 )
doc = addPlot( doc, function( ) {
			plot(iris$Sepal.Length, iris$Petal.Length, col = iris$Species)
		}, fontname = "Arial"
)
doc = addParagraph( doc, value = "my third plot", stylename = "rPlotLegend")

# add a slide with layout "Comparison"
doc = addTitle( doc, "Table examples", level =  1 )

doc = addParagraph( doc, "Simple add", stylename="Normal" )
# add iris sample
doc = addTable( doc, data = iris[25:33, ] )
doc = addParagraph( doc, value = "my first table", stylename = "rTableLegend")

doc = addParagraph( doc, "Customized table add", stylename="Normal" )

data( data_ReporteRs )
# add dummy dataset and customise some options
doc <- addTable( doc
		, data = data_ReporteRs
		, header.labels = c( "Header 1", "Header 2", "Header 3", "Header 4", "Header 5", "Header 6" )
		, groupedheader.row = list( values = c("Grouped column 1", "Grouped column 2"), colspan = c(3, 3) )
		, col.types = c( "character", "integer", "double", "date", "percent", "character" )
		, columns.font.colors = list(
				"col1" = c("#527578", "#84978F", "#ADA692", "#47423F")
				, "col3" = c("#74A6BD", "#7195A3", "#D4E7ED", "#EB8540")
		)
		, columns.bg.colors = list(
				"col2" = c("#527578", "#84978F", "#ADA692", "#47423F")
				, "col4" = c("#74A6BD", "#7195A3", "#D4E7ED", "#EB8540")
		)
)
doc = addParagraph( doc, value = "my second table", stylename = "rTableLegend")


# add a FlexTable with many options
# let's take a sample of iris
irisdata = iris[47:54,c(5,1:4)]

## properties to use later
# cell headers props
cpHeader = cellProperties(background.color = "#102E37", border.color = "#F78D3F")
# cell data props
cpData = cellProperties( background.color = "#E8EDE0", border.color="#F78D3F")
# text headers props
tpHeader = textProperties( color = "#E8EDE0", font.weight="bold")
# text data props
tpData = textProperties( color = "#102E37")

# create the FlexTable
myFlexTable = FlexTable( data = irisdata
  , cell_format = cpData, text_format = tpData
  , span.columns = "Species"
  , header.columns = FALSE, row.names = FALSE
  )

# create a FlexRow to use as FlexTable header row
headerRow = FlexRow()
for(i in 1:ncol(irisdata))
   headerRow[i] = FlexCell( pot( names(irisdata)[i], format = tpHeader )
      , cellProp = cpHeader )
myFlexTable = addHeaderRow( myFlexTable, headerRow)

# Let's format text cells in red
myFlexTable[ 1:2, 1:2] = textProperties( color = "red" )
# Let's right align column 1 paragraphs
myFlexTable[ , 1] = parProperties( text.align = "right" )
# Let's change background color of a cell
myFlexTable[ 8, 5] = cellProperties( background.color = "#FF9729", border.width = 0)

# Replace a cell with a pot object
myFlexTable = setFlexCellContent( myFlexTable, 8, 5
  , pot("Hello", format = textProperties( font.weight = "bold" ) ) + pot("World"
      , format = textProperties( font.weight = "bold", vertical.align = "superscript") ) )

doc = addFlexTable( doc, myFlexTable )
doc = addParagraph( doc, value = "my third table", stylename = "rTableLegend")
doc = addTitle( doc, "List of graphics", level =  1 )
doc = addTOC( doc, stylename = "rPlotLegend" )
doc = addTitle( doc, "List of tables", level =  1 )
doc = addTOC( doc, stylename = "rTableLegend" )


# write the doc
writeDoc( doc, docx.file)
# browseURL( docx.file )
}
}
\references{
  Wikipedia: Office Open
  XML\cr\url{http://en.wikipedia.org/wiki/Office_Open_XML}
}
\seealso{
  \code{\link{addTitle.docx}}, \code{\link{addImage.docx}},
  \code{\link{addParagraph.docx}} ,
  \code{\link{addPlot.docx}}, \code{\link{addTable.docx}},
  \code{\link{addTOC.docx}} , \code{\link{styles.docx}},
  \code{\link{writeDoc.docx}}
}

