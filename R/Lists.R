#' @title format ordered and unordered lists
#'
#' @description
#' Create a description used to format ordered and unordered lists in object documents.
#' 
#' @param ol.left left indent
#' @param ol.hanging hanging
#' @param ol.format (decimal, upperRoman, lowerRoman, upperLetter, lowerLetter, ordinal)
#' @param ol.pattern pattern
#' @param ul.left left indent
#' @param ul.hanging hanging
#' @param ul.format (disc, circle, square)
#' @param ul.pattern pattern
#' @export
list.settings = function( 
		ol.left = cumsum( rep( 0.2, 9 ) ), 
		ol.hanging = rep( 0.2, 9 ), 
		ol.format = rep( "decimal", 9 ), 
		ol.pattern = paste0( "%", 1:9, "." ), 
		ul.left = cumsum( rep( 0.2, 9 ) ), 
		ul.hanging = rep( 0.2, 9 ), 
		ul.format = c( "disc", "circle", "square", "disc", "circle", "square","disc", "circle", "square" ), 
		ul.pattern = paste0( "%", 1:9, " " )
		){
	
	
	ol.left = as.double( ol.left )
	ol.hanging = as.double( ol.hanging )
	ul.left = as.double( ul.left )
	ul.hanging = as.double( ul.hanging )
	
	
	orderedSettings = .jnew(class.ListDefinition, as.integer(0) )
	for( i in seq_along( ol.left ) ){
		.jcall( orderedSettings, "Z", "addLevel", as.double( ol.left[i] ), 
				as.double( ol.hanging[i] ), "left", 
				as.character( ol.format[i] ), as.character( ol.pattern[i] ) )
	}
	unorderedSettings = .jnew(class.ListDefinition, as.integer(1) )
	for( i in seq_along( ul.left ) ){
		.jcall( unorderedSettings, "Z", "addLevel", as.double( ul.left[i] ), 
				as.double( ul.hanging[i] ), "left", 
				as.character( ul.format[i] ), as.character( ul.pattern[i] ) )
	}
	numberingDefinition = .jnew(class.NumberingDefinition ) 
	
	.jcall( numberingDefinition, "V", "setOrdered", 
		orderedSettings )
	.jcall( numberingDefinition, "V", "setUnOrdered", 
		unorderedSettings )

	numberingDefinition
	
}

