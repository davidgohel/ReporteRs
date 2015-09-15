#############################
# simple example
#############################

MyFTable = FlexTable( data = iris[1:5,1:4] )

# add a footer row with 1 cell that spans four columns
MyFTable = addFooterRow( MyFTable, 
  value = c("a note in table footer"), colspan = 4 )
