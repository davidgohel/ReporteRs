# Create a FlexTable object with first 10 lines of data.frame iris
MyFTable = FlexTable( data = iris[1:10, ] )
MyFTable = setFlexTableWidths( MyFTable, widths = c(1,1,1,1,3))
