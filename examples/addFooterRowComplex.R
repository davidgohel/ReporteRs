#########################################
# example with FlexRow objects usage
#########################################

# create a FlexTable
MyFTable = FlexTable( data = iris[1:5,1:4] )

# define a complex formatted text
mytext = pot("*", 
    format = textProperties(vertical.align="superscript", font.size = 9) 
  ) + pot( " this text is superscripted", 
    format = textProperties(font.size = 9) )

# create a FlexRow - container for 1 cell
footerRow = FlexRow()
footerRow[1] = FlexCell( mytext, colspan = 4 )

# add the FlexRow to the FlexTable
MyFTable = addFooterRow( MyFTable, footerRow )
