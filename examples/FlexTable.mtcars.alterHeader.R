# add a pot to header column 1
MyFTable[ 1, 1, to="header"] = pot("Row names", textBoldItalic())
# modify the cell formatting properties for header column 1
MyFTable[ 1, 1, to="header"] = cellProperties( background.color = "#EEEEEE")
# center text for the header row
MyFTable[ 1, , to="header"] = parProperties( text.align = "center" )
