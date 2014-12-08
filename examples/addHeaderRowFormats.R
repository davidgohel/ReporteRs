#######################################
# how to change default formats
#######################################

MyFTable = FlexTable( data = iris[46:55, ], header.columns = FALSE, 
  body.cell.props = cellProperties(border.color="#7895A2")
)
# add an header row with table columns labels
MyFTable = addHeaderRow( MyFTable, 
  text.properties = textProperties(color = "#517281", font.weight="bold"), 
  cell.properties = cellProperties(border.color="#7895A2"), 
  value = c("Sepal Length", "Sepal Width", "Sepal Length", "Sepal Width", "Species")
)
