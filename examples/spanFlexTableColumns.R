mydata = iris[46:55, ]
MyFTable = FlexTable( data = mydata )

# merge columns 2 to 4 in line 3
MyFTable = spanFlexTableColumns( MyFTable, i = 2, from = 2, to = 4 )

# merge cells in line 4 when successive values of 
# a given character vector are identical. Note 
# the character vector length is the same 
# than the number of columns of the FlexTable.
MyFTable = spanFlexTableColumns( MyFTable, i = 4, 
  runs = c( "a", "b", "b", "c", "d") )
