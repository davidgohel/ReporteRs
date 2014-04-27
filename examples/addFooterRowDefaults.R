#############################
# simple example
#############################

data(pbc_summary)

MyFTable = FlexTable( data = pbc_summary[,1:4], header.columns = TRUE )

# add a footer row with 1 cell that spans four columns
MyFTable = addFooterRow( MyFTable
  , value = c("Mean of serum cholesterol (mg/dl)"), colspan = 4 )
