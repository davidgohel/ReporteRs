#############################
# simple example
#############################

# set header.columns to FALSE so that default header row is not added in
# the FlexTable object
# We do only want the 4 first columns of the dataset
MyFTable = FlexTable( data = iris[46:55, ], header.columns = FALSE )

# add an header row with 3 cells, the first one spans two columns, 
# the second one spans two columns and the last one does not span 
# multiple columns
MyFTable = addHeaderRow( MyFTable, 
  value = c("Sepal", "Petal", ""), 
  colspan = c( 2, 2, 1) 
)

# add an header row with modified table columns labels
MyFTable = addHeaderRow( MyFTable, 
  value=c("Length", "Width", "Length", "Width", "Species")
)
