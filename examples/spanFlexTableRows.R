# merge line 7 to 11 in column 1
MyFTable = spanFlexTableRows( MyFTable, j = 3, from = 5, to = 7 )
# merge cells in column 1 (trt) when successive values of trt are identical
MyFTable = spanFlexTableRows( MyFTable, j=1, runs = as.character( pbc_summary$trt ) )
# merge cells in column 2 (sex) when successive values of sex are identical
MyFTable = spanFlexTableRows( MyFTable, j=2, runs = as.character( pbc_summary$sex ) )
