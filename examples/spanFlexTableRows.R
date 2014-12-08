mydata = iris[46:55, ]
MyFTable = FlexTable( data = mydata )

# merge line 5 to 7 in column 1
MyFTable = spanFlexTableRows( MyFTable, j = 3, from = 5, to = 7 )

# merge cells in column "Species" when successive values 
# of Species are identical. Note 
# the character vector length is the same 
# than the number of lines of the FlexTable.
MyFTable = spanFlexTableRows( MyFTable, j = "Species", 
  runs = as.character( mydata$Species ) )
