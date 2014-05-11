#####################################################################

# a summary of mtcars
dataset = aggregate( mtcars[, c("disp", "mpg", "wt")]
		, by = mtcars[, c("cyl", "gear", "carb")]
		, FUN = mean )
dataset = dataset[ order(dataset$cyl, dataset$gear, dataset$carb), ]

options( "ReporteRs-fontsize" = 9 )

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
