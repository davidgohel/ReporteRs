# modify the text formatting properties for the row.names column
MyFTable[ , 1] = textProperties( font.style="italic", font.size = 9)
# align text to right for the row.names column
MyFTable[ , 1] = parProperties( text.align = "right" )

# change cell formatting properties for various columns
MyFTable[ c(3,6:9), c( "mpg", "disp"
  , "hp", "drat", "wt", "qsec" ) ] = cellProperties( background.color="#CCCCCC")
