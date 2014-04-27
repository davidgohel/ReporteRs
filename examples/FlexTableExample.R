MyFTable = FlexTable( data = mtcars, add.rownames = TRUE
  , cell_format = cellProperties( border.color="#EDBD3E")
  , header_cell_format = cellProperties( background.color="#5B7778"
    , border.color="#EDBD3E")
)

MyFTable = setZebraStyle( MyFTable, odd = "#D1E6E7", even = "#93A8A9" )

MyFTable = setFlexTableBorders(MyFTable
  , inner.vertical = borderProperties( color="#EDBD3E", style="dotted" )
  , inner.horizontal = borderProperties( color = "#EDBD3E", style = "none" )
  , outer.vertical = borderProperties( color = "#EDBD3E", style = "solid" )
  , outer.horizontal = borderProperties( color = "#EDBD3E", style = "solid" )
)
