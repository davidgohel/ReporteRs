\name{addFlexTable.docx}
\alias{addFlexTable.docx}
\title{Insert a FlexTable into a docx object}
\usage{
\method{addFlexTable}{docx}(doc, flextable,
  par.properties = parProperties(text.align = "left"), bookmark, ...)
}
\arguments{
  \item{doc}{docx object}

  \item{flextable}{the \code{FlexTable} object}

  \item{par.properties}{paragraph formatting properties of
  the paragraph that contains the table. An object of class
  \code{\link{parProperties}}}

  \item{bookmark}{a character vector specifying bookmark id
  (where to put the table).  If provided, table will be add
  after paragraph that contains the bookmark.  If not
  provided, table will be added at the end of the
  document.}

  \item{...}{further arguments - not used}
}
\value{
a docx object
}
\description{
Insert a FlexTable into a docx object
}
\examples{
#START_TAG_TEST
doc.filename = "addFlexTable_example.docx"

# set default font size to 10
options( "ReporteRs-fontsize" = 10 )

doc = docx( )

doc = addTitle( doc, "Title example 1", level = 1 )
#####################################################################

# set default font size to 10
options( "ReporteRs-fontsize" = 10 )

# Create a FlexTable with data.frame mtcars, display rownames
# use different formatting properties for header and body cells
MyFTable = FlexTable( data = mtcars, add.rownames = TRUE
  , body.cell.props = cellProperties( border.color = "#EDBD3E")
  , header.cell.props = cellProperties( background.color = "#5B7778" )
)
# zebra stripes - alternate colored backgrounds on table rows
MyFTable = setZebraStyle( MyFTable, odd = "#D1E6E7", even = "#93A8A9" )

# applies a border grid on table
MyFTable = setFlexTableBorders(MyFTable
  , inner.vertical = borderProperties( color="#EDBD3E", style="dotted" )
  , inner.horizontal = borderProperties( color = "#EDBD3E", style = "none" )
  , outer.vertical = borderProperties( color = "#EDBD3E", style = "solid" )
  , outer.horizontal = borderProperties( color = "#EDBD3E", style = "solid" )
)

# add MyFTable into document 
doc = addFlexTable( doc, MyFTable )

doc = addTitle( doc, "Title example 2", level = 1 )
#####################################################################

# set default font size to 10
options( "ReporteRs-fontsize" = 10 )

# a summary of mtcars
dataset = aggregate( mtcars[, c("disp", "mpg", "wt")]
		, by = mtcars[, c("cyl", "gear", "carb")]
		, FUN = mean )
dataset = dataset[ order(dataset$cyl, dataset$gear, dataset$carb), ]


# set cell padding defaut to 2
baseCellProp = cellProperties( padding = 2 )

# Create a FlexTable with data.frame dataset
MyFTable = FlexTable( data = dataset
		, body.cell.props = baseCellProp
		, header.cell.props = baseCellProp
		, header.par.props = parProperties(text.align = "right" )
)

# set columns widths (in inches)
MyFTable = setFlexTableWidths( MyFTable, widths = c(0.5, 0.5, 0.5, 0.7, 0.7, 0.7) )

# span successive identical cells within column 1, 2 and 3
MyFTable = spanFlexTableRows( MyFTable, j = 1, runs = as.character( dataset$cyl ) )
MyFTable = spanFlexTableRows( MyFTable, j = 2, runs = as.character( dataset$gear ) )
MyFTable = spanFlexTableRows( MyFTable, j = 3, runs = as.character( dataset$carb ) )

# overwrites some text formatting properties
MyFTable[dataset$wt < 3, 6] = textProperties( color="#003366")
MyFTable[dataset$mpg < 20, 5] = textProperties( color="#993300")

# overwrites some paragraph formatting properties
MyFTable[, 1:3] = parProperties(text.align = "center")
MyFTable[, 4:6] = parProperties(text.align = "right")

# applies a border grid on table
MyFTable = setFlexTableBorders( MyFTable, footer=TRUE
		, inner.vertical = borderProperties( color = "#666666" )
		, inner.horizontal = borderProperties( color = "#666666" )
		, outer.vertical = borderProperties( width = 2, color = "#666666" )
		, outer.horizontal = borderProperties( width = 2, color = "#666666" )
)

# add MyFTable into document 
doc = addFlexTable( doc, MyFTable )

# Write the object
writeDoc( doc, file = doc.filename )
#STOP_TAG_TEST
}
\seealso{
\code{\link{FlexTable}}, \code{\link{docx}} ,
\code{\link{addFlexTable.pptx}},
\code{\link{addFlexTable.html}} ,
\code{\link{addTable.docx}}
}

