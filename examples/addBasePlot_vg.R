# Add a base plot
doc = addPlot( doc, fun = plot,
  x = rnorm( 100 ), y = rnorm (100 ), main = "base plot main title",
  vector.graphic = TRUE, width = 5, height = 7,
  par.properties = parProperties(text.align = "left")
  )
