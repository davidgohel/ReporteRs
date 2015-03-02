


data( iris )
iris = head( iris[, c(5, 1:4)] )

default_text = textProperties( font.size = 11 )
note_text = chprop(default_text, 
	vertical.align = "superscript", color = "blue")

iris_ft = FlexTable( data = iris, header.columns = FALSE )
iris_ft = addHeaderRow( iris_ft, 
	value = c("", "Measures" ), colspan = c( 4, 1 ) )
iris_ft = addHeaderRow( iris_ft, 
	value = gsub( "\\.", " ", names( iris ) ) )
iris_ft[2, 2, newpar = TRUE ] = "Hi there"
iris_ft[2, 1, to="header"] = pot("* this is a note", note_text )


iris_ft = spanFlexTableRows( iris_ft, j = "Species", 
	runs = as.character( iris$Species ) )
iris_ft = setFlexTableBorders( iris_ft, 
  inner.vertical = borderProperties( style = "none" ), 
  inner.horizontal = borderProperties( width = 1 ), 
  outer.vertical = borderProperties( width = 0 ), 
  outer.horizontal = borderProperties( width = 2 ), 
  footer = TRUE
)
