#
# demo many options
data( data_ReporteRs )
# add dummy data 'data_ReporteRs' and customise some options
doc = addTable( doc
    , data = data_ReporteRs
    , header.labels = c( "Header 1", "Header 2", "Header 3"
        , "Header 4", "Header 5", "Header 6" )
    , groupedheader.row = list( values = c("Grouped column 1", "Grouped column 2")
        , colspan = c(3, 3) )
    , col.types = c( "character", "integer", "double", "date", "percent", "character" )
    , columns.font.colors = list(
        "col1" = c("#527578", "#84978F", "#ADA692", "#47423F")
        , "col3" = c("#74A6BD", "#7195A3", "#D4E7ED", "#EB8540")
    )
    , columns.bg.colors = list(
        "col2" = c("#527578", "#84978F", "#ADA692", "#47423F")
        , "col4" = c("#74A6BD", "#7195A3", "#D4E7ED", "#EB8540")
    )
)
