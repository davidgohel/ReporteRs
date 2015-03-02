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
  outer.vertical = borderProperties( color = "#006699", 
	style = "solid", width = 2 ),
  outer.horizontal = borderProperties( color = "#006699", 
	style = "solid", width = 2 )
)
