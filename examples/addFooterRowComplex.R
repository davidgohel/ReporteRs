#########################################
# example with FlexRow objects usage
#########################################

data(pbc_summary)

# create a FlexTable
MyFTable = FlexTable( data = pbc_summary[,1:4] )

# define a complex formatted text
mytext = pot("*"
    , format = textProperties(vertical.align="superscript", font.size = 9) 
  ) + pot( " Mean of serum cholesterol (mg/dl)"
    , format = textProperties(font.size = 9)
  )

# create a FlexRow - container for 1 cell
footerRow = FlexRow()
footerRow[1] = FlexCell( mytext, colspan = 4 )

# add the FlexRow to the FlexTable
MyFTable = addFooterRow( MyFTable, footerRow )
