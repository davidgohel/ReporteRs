#######################################
# how to change default formats
#######################################
data(pbc_summary)

MyFTable = FlexTable( data = pbc_summary[,1:4], header.columns = FALSE
  , body.cell.props = cellProperties(border.color="#7895A2")
)
# add an header row with table columns labels
MyFTable = addHeaderRow( MyFTable
  , text.properties = textProperties(color = "#517281", font.weight="bold")
  , cell.properties = cellProperties(border.color="#7895A2")
  , value=c("Treatment", "Sex", "Status", "Serum cholesterol (mg/dl)")
)
