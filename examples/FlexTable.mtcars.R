# Create a FlexTable object with first 10 lines of data.frame mtcars
# add row.names as first column
# specify cell formating properties for header columns row
MyFTable = FlexTable( data = mtcars[1:10, ]
  , add.rownames=TRUE
)
