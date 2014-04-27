FlexCell( value = "Hello" )
FlexCell( value = "Hello", colspan = 3)
FlexCell( "Column 1", cell.properties = cellProperties(background.color="#527578")  )


# define a complex formatted text
mytext = pot("Hello", format = textProperties(color = "blue") 
  ) + " " + pot( "world", format = textProperties(font.size = 9)
)
Fcell = FlexCell( mytext, colspan = 4 )

# define two paragraph and put them in a FlexCell
mytext1 = pot("Hello", format = textProperties(color = "blue") )
mytext2 = pot( "world", format = textProperties(font.size = 9) )
Fcell = FlexCell( set_of_paragraphs( mytext1, mytext2 ) )
