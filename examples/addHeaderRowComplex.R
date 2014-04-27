#########################################
# example with FlexRow objects usage
#########################################

data(pbc_summary)

# cell styles definitions
cellProperties1 = cellProperties( border.top.width = 2
    , border.right.style="dashed"
    , border.bottom.style="dashed"
    , border.left.width = 2 )
cellProperties2 = cellProperties( border.top.width = 2
    , border.left.style="dashed"
    , border.bottom.style="dashed"
    , border.right.width = 2 )

# create a FlexTable
MyFTable = FlexTable( data = pbc_summary[,1:4]
  , header.columns = FALSE, body.text.props=textProperties() )

# create a FlexRow - container for 2 cells
headerRow = FlexRow()
headerRow[1] = FlexCell( "By variables", colspan = 3, cell.properties = cellProperties1 )
headerRow[2] = FlexCell( "Serum cholesterol (mg/dl)", cell.properties = cellProperties2 )
# add the FlexRow to the FlexTable
MyFTable = addHeaderRow( MyFTable, headerRow )


# cell styles definitions
cellProperties3 = cellProperties( border.bottom.width = 2, border.left.width = 2
    , border.right.style="dashed"
    , border.top.style="dashed" 
)
cellProperties4 = cellProperties( border.bottom.width = 2
    , border.right.style="dashed", border.left.style="dashed"
    , border.top.style="dashed" )
cellProperties5 = cellProperties( border.bottom.width = 2, border.right.width = 2
    , border.left.style="dashed"
    , border.top.style="dashed"
)

# create a FlexRow - container for 4 cells
headerRow = FlexRow()
headerRow[1] = FlexCell( "Treatment", cell.properties = cellProperties3 )
headerRow[2] = FlexCell( "Sex", cell.properties = cellProperties4 )
headerRow[3] = FlexCell( "Status", cell.properties = cellProperties4 )
headerRow[4] = FlexCell( "Mean", cell.properties = cellProperties5 )
# add the FlexRow to the FlexTable
MyFTable = addHeaderRow( MyFTable, headerRow )
