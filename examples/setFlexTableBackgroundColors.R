data = cor( cor(mtcars) )

mycolors = brewer.pal(name = "RdYlGn", n = 8 )[cut( data ,
	breaks=c(-1,-0.75,-0.5,-0.25,0,0.25,0.5,0.75,1),
	include.lowest=TRUE,
	label = F
) ]

MyFTable = FlexTable( round(data, 3), add.rownames = TRUE )

# set computed colors
MyFTable = setFlexTableBackgroundColors( MyFTable, 
	j = seq_len(ncol(data)) + 1, 
	colors = mycolors )

# cosmetics
MyFTable = setFlexTableBackgroundColors( MyFTable, i = 1, 
	colors = "black", to = "header" )
MyFTable[1, , to = "header"] = textBold(color="white")

MyFTable = setFlexTableBackgroundColors( MyFTable, j = 1, colors = "black" )
MyFTable[,1] = textBold(color="white")

MyFTable = setFlexTableBorders( MyFTable
	, inner.vertical = borderProperties( style = "dashed", color = "white" )
	, inner.horizontal = borderProperties( style = "dashed", color = "white"  )
	, outer.vertical = borderProperties( width = 2, color = "white"  )
	, outer.horizontal = borderProperties( width = 2, color = "white"  )
)
