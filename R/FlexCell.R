#' @title Cell object for FlexTable
#'
#' @description Create a representation of a cell that can be inserted in a FlexTable.
#' 
#' @param value a content value - a value of type \code{character} or \code{pot} or \code{set_of_paragraphs}.
#' @param colspan defines the number of columns the cell should span
#' @param parProp parProperties to apply to content
#' @param cellProp cellProperties to apply to content
#' @export
#' @seealso \code{\link{addFlexTable}}
#' @examples
#' FlexCell( value = "Hello" )
FlexCell = function( value, colspan = 1, parProp = parProperties(), cellProp = cellProperties() ) {
	
	if( !inherits( parProp, "parProperties" ) ){
		stop("argument 'parProp' must be an object of class 'parProperties'")
	}
	
	if( !inherits( cellProp, "cellProperties" ) ){
		stop("argument 'cellProp' must be an object of class 'cellProperties'")
	}
	
	if( missing(value) )
		stop("argument value is missing.")

	if( inherits(value, "character") ){
		value = set_of_paragraphs( value )
	}
	
	if( inherits(value, "pot") )
		value = set_of_paragraphs( value )
	
	if( !inherits(value, "set_of_paragraphs") )
		stop("argument value must be a character vector or an object of class 'set_of_paragraphs'.")
	
	paragraphsSection = ParagraphSection(value, parProp = parProp )
	
	jcellProp = .jCellProperties(cellProp)

	flexCell = rJava::.jnew(class.FlexCell, paragraphsSection$jobj, jcellProp)
	rJava::.jcall( flexCell, "V", "setColspan", as.integer( colspan ) )
	
	.Object = list()
	.Object$jobj = flexCell
	.Object$colspan = colspan

	class( .Object ) = c("FlexCell", "FlexElement")

	.Object
}

#' @method print FlexCell
#' @S3method print FlexCell
print.FlexCell = function(x, ...){
	out = rJava::.jcall( x$jobj, "S", "toString" )
	cat(out)
	invisible()
}

