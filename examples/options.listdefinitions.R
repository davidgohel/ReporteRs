numbering.pattern = c( "%1.", "%1. %2.", "%1. %2. %3.", 
  "%4.", "%5.", "%6.", "%7.", "%8.", "%9." )

ordered.formats = rep( c( "decimal", "upperRoman", "upperLetter"), 3 )

unordered.formats = rep( c( "square", "disc", "circle"), 3 )

left.indent = seq( from = 0, by = 0.5, length.out = 9)

options("ReporteRs-list-definition" = list( 
  ol.left = left.indent, 
  ol.hanging = rep( 0.4, 9 ), 
  ol.format = ordered.formats, 
  ol.pattern = numbering.pattern, 
  ul.left = left.indent, 
  ul.hanging = rep( 0.4, 9 ), 
  ul.format = unordered.formats
  )
)
