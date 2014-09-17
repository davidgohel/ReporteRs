# merge column 2 to 4 in line 3
MyFTable = spanFlexTableColumns( MyFTable, i = 3, from = 2, to = 4 )

# merge cells in rows 1 to 6 when successive values of runs are identical
MyFTable = spanFlexTableColumns( MyFTable, i = 4:6, runs = c( "a", "b", "b", "c") )
