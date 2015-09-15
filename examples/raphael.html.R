
# load ggplot2
if( requireNamespace("ggplot2", quietly = TRUE) ){
	
  # create a ggplot2 plot
  myplot = ggplot2::qplot(Sepal.Length, Petal.Length, data = iris
    , color = Species, size = Petal.Width, alpha = I(0.7) )

  raphael.html( fun = function( ){
    plot( x = rnorm( 100 ), y = rnorm (100 ), 
		main = "base plot main title" )
    print( myplot )
  }, width = 5, height = 7 )
}
