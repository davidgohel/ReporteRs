#' @title Cell object for FlexTable
#'
#' @description Create a representation of a cell that can be inserted in a FlexRow.
#' For internal usage.
#' 
#' @param value a content value - a value of type \code{character} or \code{\link{pot}} or \code{\link{set_of_paragraphs}}.
#' @param colspan defines the number of columns the cell should span
#' @param par.properties parProperties to apply to content
#' @param cell.properties cellProperties to apply to content
#' @export
#' @seealso \code{\link{addFlexTable}}, \code{\link{addHeaderRow}}, \code{\link{addFooterRow}}
#' @examples 
#' #
#' @example examples/FlexCell.R
FlexCell = function( value, colspan = 1, par.properties = parProperties(), cell.properties = cellProperties() ) {
	
	if( !inherits( par.properties, "parProperties" ) ){
		stop("argument 'par.properties' must be an object of class 'parProperties'")
	}
	
	if( !inherits( cell.properties, "cellProperties" ) ){
		stop("argument 'cell.properties' must be an object of class 'cellProperties'")
	}
	
	if( missing(value) )
		stop("argument value is missing.")
	
	if( is.null(value) )
		stop("argument value is null.")
	
	if( inherits(value, "character") ){
		value = set_of_paragraphs( value )
	}
	
	if( inherits(value, "pot") )
		value = set_of_paragraphs( value )
	
	if( !inherits(value, "set_of_paragraphs") )
		stop("argument value must be a character vector or an object of class 'set_of_paragraphs'.")
	
	parset = .jset_of_paragraphs(value, par.properties)
		
	jcellProp = .jCellProperties(cell.properties)

	flexCell = .jnew(class.FlexCell, parset, jcellProp)
	.jcall( flexCell, "V", "setColspan", as.integer( colspan ) )
	
	.Object = list()
	.Object$jobj = flexCell
	.Object$colspan = colspan

	class( .Object ) = c("FlexCell")

	.Object
}

#' @export
print.FlexCell = function(x, ...){
	out = .jcall( x$jobj, "S", "toString" )
	cat(out)
	invisible()
}

