# load ggplot2
if( requireNamespace("ggplot2", quietly = TRUE) ){

  # create a ggplot2 plot
  myplot = ggplot2::qplot(Sepal.Length, Petal.Length, data = iris
    , color = Species, size = Petal.Width, alpha = I(0.7) )

  # Add myplot into object doc
  doc = addPlot( doc = doc, fun = print, x = myplot )
}
