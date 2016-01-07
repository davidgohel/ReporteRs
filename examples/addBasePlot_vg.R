# Add a base plot
# set vector.graphic to FALSE if Word version
#   used to read the file is <= 2007
doc = addPlot( doc, fun = plot,
  x = rnorm( 100 ), y = rnorm (100 ), main = "base plot main title",
  vector.graphic = TRUE,
  width = 5, height = 7,
  par.properties = parProperties(text.align = "left")
  )
