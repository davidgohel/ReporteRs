# load ggplot2
require( ggplot2 )

# create a ggplot2 plot
myplot = qplot(Sepal.Length, Petal.Length, data = iris
  , color = Species, size = Petal.Width, alpha = I(0.7) )

# Add myplot into object doc
#   myplot is assigned to argument 'x' because function 'print' on ggplot
#   objects is expecting argument 'x'.
doc = addPlot( doc = doc, fun = print, x = myplot )
