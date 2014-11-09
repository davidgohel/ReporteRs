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
  after paragraph that contains the bookmark. See
  \code{\link{bookmark}}.  If not provided, table will be
  added at the end of the document.}

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

# Create a FlexTable with data.frame mtcars, display rownames
# use different formatting properties for header and body
MyFTable = FlexTable( data = mtcars, add.rownames = TRUE, 
  header.cell.props = cellProperties( background.color = "#00557F" ), 
  header.text.props = textProperties( color = "white", 
    font.size = 11, font.weight = "bold" ), 
  body.text.props = textProperties( font.size = 10 )
)
# zebra stripes - alternate colored backgrounds on table rows
MyFTable = setZebraStyle( MyFTable, odd = "#E1EEf4", even = "white" )

# applies a border grid on table
MyFTable = setFlexTableBorders(MyFTable,
  inner.vertical = borderProperties( color="#0070A8", style="solid" ),
  inner.horizontal = borderNone(),
  outer.vertical = borderProperties( color = "#006699", style = "solid", width = 2 ),
  outer.horizontal = borderProperties( color = "#006699", style = "solid", width = 2 )
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

Footnote1 = Footnote(  )
par1 = pot("About this reference", textBold( ) )
par2 = pot("Omni ab coalitos pro malivolus obsecrans graviter 
cum perquisitor perquisitor pericula saepeque inmunibus coalitos ut.", 
	textItalic(font.size = 8) )
Footnote1 = addParagraph( Footnote1, set_of_paragraphs( par1, par2 ), 
	parProperties(text.align = "justify"))
Footnote1 = addParagraph( Footnote1, set_of_paragraphs( "list item 1", "list item 2" ), 
	parProperties(text.align = "left", list.style = "ordered"))
an_rscript = RScript( text = "ls()
x = rnorm(10)" )
Footnote1 = addParagraph( Footnote1, an_rscript )

MyFTable[1, 1, newpar = TRUE] = pot("a note", footnote = Footnote1, format = textBold(color="gray") )

# applies a border grid on table
MyFTable = setFlexTableBorders( MyFTable, footer=TRUE
		, inner.vertical = borderProperties( color = "#666666" )
		, inner.horizontal = borderProperties( color = "#666666" )
		, outer.vertical = borderProperties( width = 2, color = "#666666" )
		, outer.horizontal = borderProperties( width = 2, color = "#666666" )
)

# add MyFTable into document 
doc = addFlexTable( doc, MyFTable )


doc = addTitle( doc, "Title example 3", level = 1 )
data = cor( cor(mtcars) )

pal = c( "#D73027", "#F46D43", "#FDAE61", "#FEE08B", 
	"#D9EF8B", "#A6D96A", "#66BD63", "#1A9850" )
mycut = cut( data, 
	breaks = c(-1,-0.75,-0.5,-0.25,0,0.25,0.5,0.75,1),
	include.lowest = TRUE, label = FALSE )
mycolors = pal[ mycut ]

MyFTable = FlexTable( round(data, 3), add.rownames = TRUE )

# set computed colors
MyFTable = setFlexTableBackgroundColors( MyFTable, 
	j = seq_len(ncol(data)) + 1, 
	colors = mycolors )

# cosmetics
MyFTable = setFlexTableBackgroundColors( MyFTable, i = 1, 
	colors = "gray", to = "header" )
MyFTable[1, , to = "header"] = textBold(color="white")

MyFTable = setFlexTableBackgroundColors( MyFTable, j = 1, colors = "gray" )
MyFTable[,1] = textBold(color="white")

MyFTable = setFlexTableBorders( MyFTable
	, inner.vertical = borderProperties( style = "dashed", color = "white" )
	, inner.horizontal = borderProperties( style = "dashed", color = "white"  )
	, outer.vertical = borderProperties( width = 2, color = "white"  )
	, outer.horizontal = borderProperties( width = 2, color = "white"  )
)

# add MyFTable into document 
doc = addFlexTable( doc, MyFTable )

# Write the object
writeDoc( doc, file = doc.filename )
#STOP_TAG_TEST
}
\seealso{
\code{\link{FlexTable}}, \code{\link{docx}}
}

