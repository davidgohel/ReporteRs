#############################
# simple example
#############################

data(pbc_summary)

# set header.columns to FALSE so that default header row is not added in
# the FlexTable object
# We do only want the 4 first columns of the dataset
MyFTable = FlexTable( data = pbc_summary[,1:4], header.columns = FALSE )

# add an header row with 2 cells, the first one spans three columns
# and the second one spans one column (normal width)
MyFTable = addHeaderRow( MyFTable
  , value = c("By variables", "Serum cholesterol (mg/dl)")
  , colspan = c( 3, 1) 
)

# add an header row with table columns labels
MyFTable = addHeaderRow( MyFTable
  , value=c("Treatment", "Sex", "Status", "Mean")
)
